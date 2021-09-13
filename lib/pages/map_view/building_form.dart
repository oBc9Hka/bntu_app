import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bntu_app/models/buildings_model.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:bntu_app/util/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class BuildingForm extends StatefulWidget {
  const BuildingForm({Key? key, this.building, required this.isEdit})
      : super(key: key);
  final QueryDocumentSnapshot<Object?>? building;
  final bool isEdit;

  @override
  _BuildingFormState createState() => _BuildingFormState();
}

class _BuildingFormState extends State<BuildingForm> {
  static YandexMapController? controller;
  bool isNightModeEnabled = false;
  bool isZoomGesturesEnabled = false;
  bool isTiltGesturesEnabled = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _optionalController = TextEditingController();
  GeoPoint? _point;
  late Point _newPoint;
  String _imagePath = '';
  bool _temporaryLoaded = false;

  final Color mainColor = Color.fromARGB(255, 0, 138, 94);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Building _building = Building();
  AuthService _authService = AuthService();
  User? _user;

  XFile? _image;
  UploadTask? task;
  final ImagePicker _picker = ImagePicker();

  void getPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
    if (_image != null) {
      saveImage();
    }
  }

  Future<void> saveImage() async {
    Uint8List? data;
    await File(_image!.path)
        .readAsBytes()
        .then((value) => {data = Uint8List.fromList(value)});

    task = uploadFile(data!);
    setState(() {});

    if (task == null) return;

    final TaskSnapshot storageTaskSnapshot = await task!.whenComplete(() {
      task = null;
    });
    final String path = await storageTaskSnapshot.ref.getDownloadURL();

    _imagePath = path;
  }

  UploadTask? uploadFile(Uint8List data) {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref('buildings/${_nameController.text}/photo.jpg');
      // return storageReference.putFile(File(_image.path));

      return storageReference.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            _temporaryLoaded = true;
            final snap = snapshot.data;
            final progress = snap!.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(1);
            return Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Center(
                child: Text(
                  '$percentage%',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );

  void changeUploadStatus() {}

  Future<void> _getUser() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _user = user as User;
    });
  }

  void _addBuilding() {
    if (_formKey.currentState!.validate()) {
      _building.addBuilding(
        _nameController.text,
        _optionalController.text,
        _newPoint,
        _imagePath,
      );
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Точка успешно добавлена');
    }
  }

  void _editBuilding(String id) {
    if (_formKey.currentState!.validate()) {
      _building.editBuilding(
        _nameController.text,
        _optionalController.text,
        _newPoint,
        _imagePath,
        id,
      );
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Точка успешно добавлена');
    }
  }

  void _removeBuilding(
      BuildContext context, QueryDocumentSnapshot<Object?>? item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 40,
            child: const Center(
                child: Text(
              'Хотите удалить точку?',
              style: TextStyle(fontSize: 18),
            )),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _building.removeBuilding(item!.id);
                Navigator.pop(context);
                Navigator.pop(context);
                Fluttertoast.showToast(msg: 'Точка успешно удалена');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                'Удалить',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black38),
              ),
              child: const Text(
                'Отмена',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }

  void setInitialPos() async {
    await controller!.move(
        point: Data.initialPoint,
        animation: const MapAnimation(smooth: true, duration: 1.0));
  }

  void setPos(Point point) async {
    await controller!.move(
        zoom: 17,
        point: point,
        animation: const MapAnimation(smooth: true, duration: 1.0));

    removePlacemark();
    if (point != Data.initialPoint) addPlacemark(point);
  }

  Future<void> addPlacemark(Point point) async {
    await controller!.addPlacemark(Placemark(
      point: point,
      style: const PlacemarkStyle(
        iconName: 'assets/yandex_images/place.png',
        opacity: 0.9,
      ),
    ));
  }

  void removePlacemark() {
    if (controller!.placemarks.isNotEmpty)
      controller!.removePlacemark(controller!.placemarks.first);
  }

  Future<void> cameraPositionChanged(dynamic arguments) async {
    final bool bFinal = arguments['final'];
    if (bFinal) {
      removePlacemark();
      setState(() {
        _newPoint = Point(
            latitude: arguments['latitude'], longitude: arguments['longitude']);
      });
      await addPlacemark(_newPoint);
    }
  }

  Future<void> enableCameraTracking() async {
    final currentCameraTracking = await controller!.enableCameraTracking(
      onCameraPositionChange: cameraPositionChanged,
      style: const PlacemarkStyle(
          iconName: 'assets/yandex_images/place.png', opacity: 0.5),
    );
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _nameController = TextEditingController(text: widget.building!['name']);
      _optionalController =
          TextEditingController(text: widget.building!['optional']);
      _point = widget.building!['point'];
      _imagePath = widget.building!['imagePath'];
    }

    return ListView(
      children: [
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              YandexMap(
                onMapCreated: (YandexMapController yandexMapController) async {
                  controller = yandexMapController;
                },
                onMapRendered: () async {
                  print('Map rendered');
                  setInitialPos();
                  if (widget.isEdit) {
                    setPos(Point(
                      longitude: _point!.longitude,
                      latitude: _point!.latitude,
                    ));
                  }
                  enableCameraTracking();
                  var tiltGesturesEnabled =
                      await controller!.isTiltGesturesEnabled();
                  var zoomGesturesEnabled =
                      await controller!.isZoomGesturesEnabled();

                  var zoom = await controller!.getZoom();
                  var minZoom = await controller!.getMinZoom();
                  var maxZoom = await controller!.getMaxZoom();

                  print(
                      'Current zoom: $zoom, minZoom: $minZoom, maxZoom: $maxZoom');

                  setState(() {
                    // isTiltGesturesEnabled = tiltGesturesEnabled;
                    isZoomGesturesEnabled = zoomGesturesEnabled;
                  });
                },
                onMapSizeChanged: (MapSize size) =>
                    print('Map size changed to ${size.width}x${size.height}'),
                onMapTap: (Point point) =>
                    print('Tapped map at ${point.latitude},${point.longitude}'),
                onMapLongTap: (Point point) => print(
                    'Long tapped map at ${point.latitude},${point.longitude}'),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 60,
                  height: 160,
                  child: Card(
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              controller!.zoomIn();
                            },
                            icon: Icon(Icons.add)),
                        IconButton(
                            onPressed: () {
                              controller!.zoomOut();
                            },
                            icon: Icon(Icons.do_not_disturb_on_outlined)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                // _prevSelectedItem.isActive = false;
                              });
                              setInitialPos();
                            },
                            icon: Icon(Icons.zoom_out_map)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Название'),
                      validator: (value) {
                        if (value == '') return 'Введите название';
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _optionalController,
                      decoration:
                          const InputDecoration(labelText: 'Опциональное поле'),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    getPhoto();
                  },
                  child: Text('Загрузить изображение')),
              (widget.isEdit && widget.building!['imagePath'] != '' &&
                      _temporaryLoaded)
                  ? SizedBox(
                      height: 100,
                      child: Image.network(widget.building!['imagePath']))
                  : Text('Изображение не загружено'),
              if (task != null)
                // buildUploadStatus(task!)
                // _temporaryLoaded = true
                // changeUploadStatus()
                Builder(builder: (BuildContext context) {
                  // setState(() {
                  // });
                  return buildUploadStatus(task!);
                })
              else
                Container(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widget.isEdit
                  ? ElevatedButton(
                      onPressed: () {
                        _editBuilding(widget.building!.id);
                      },
                      child: Text('Изменить'),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(mainColor),
                        minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        elevation: MaterialStateProperty.all(10),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: mainColor),
                          ),
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        _addBuilding();
                      },
                      child: Text('Добавить'),
                      style: ButtonStyle(
                        // foregroundColor: MaterialStateProperty.all(mainColor),
                        minimumSize: MaterialStateProperty.all(Size(120, 50)),
                        elevation: MaterialStateProperty.all(10),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: mainColor),
                          ),
                        ),
                      ),
                    ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Назад'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(mainColor),
                  minimumSize: MaterialStateProperty.all(Size(120, 50)),
                  elevation: MaterialStateProperty.all(10),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: mainColor),
                    ),
                  ),
                ),
              ),
              if (widget.isEdit)
                ElevatedButton(
                  onPressed: () {
                    _removeBuilding(context, widget.building);
                  },
                  child: Icon(Icons.delete),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    minimumSize: MaterialStateProperty.all(Size(50, 50)),
                    elevation: MaterialStateProperty.all(10),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}