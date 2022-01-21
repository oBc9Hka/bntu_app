import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bntu_app/models/buildings_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/widgets/edit_buttons_section.dart';
import 'package:bntu_app/ui/widgets/image_loading.dart';
import 'package:bntu_app/ui/widgets/remove_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'building_form.dart';

class BuildingEdit extends StatefulWidget {
  const BuildingEdit({Key? key, required this.building}) : super(key: key);
  final Building building;

  @override
  _BuildingEditState createState() => _BuildingEditState();
}

class _BuildingEditState extends State<BuildingEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController =
  TextEditingController();
  TextEditingController _optionalController =
  TextEditingController();

  XFile? _image;
  String _imagePath = '';
  UploadTask? task;
  final ImagePicker _picker = ImagePicker();

  static YandexMapController? controller;
  bool isNightModeEnabled = false;
  bool isZoomGesturesEnabled = false;
  bool isTiltGesturesEnabled = false;
  GeoPoint? _point;
  late Point _newPoint;

  void getPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }

  Future<void> saveImage(String folderName) async {
    Uint8List? data;
    await File(_image!.path)
        .readAsBytes()
        .then((value) => {data = Uint8List.fromList(value)});

    task = uploadFile(data!, folderName);
    setState(() {});
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var themeProvider = Provider.of<ThemeProvider>(context);
          return AlertDialog(
            title: Text('Пожалуйста, подождите'),
            content: SizedBox(
              height: 50,
              child: Column(
                children: [
                  Text('Идёт сохранение изменений'),
                  if (task != null) buildUploadStatus(task!)
                ],
              ),
            ),
            backgroundColor: themeProvider.brightness == CustomBrightness.light
                ? Colors.white70
                : Colors.black54,
          );
        });

    if (task == null) return;

    final TaskSnapshot storageTaskSnapshot = await task!.whenComplete(() {
      task = null;
    });
    final String path = await storageTaskSnapshot.ref.getDownloadURL();

    _imagePath = path;
  }

  UploadTask? uploadFile(Uint8List data, folder) {
    try {
      final Reference storageReference =
          FirebaseStorage.instance.ref('buildings/$folder/photo.jpg');
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
            final snap = snapshot.data;
            final progress = snap!.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(1);

            return Container(
              child: Center(
                child: Text('$percentage%'),
              ),
            );
          } else {
            return Container();
          }
        },
      );

  void _editBuilding(AppProvider state, String name, String optional) async {
    if (_formKey.currentState!.validate()) {
      if (_image != null) {
        await saveImage(name).whenComplete(() {
          state.editBuilding(
            name,
            optional,
            _newPoint,
            _imagePath,
            widget.building.docId!,
          );
          Navigator.of(context).pop();
        });
      } else {
        state.editBuilding(
          name,
          optional,
          _newPoint,
          '',
          widget.building.docId!,
        );
      }
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Точка успешно изменена');
    }
  }

  void setInitialPos() async {
    await controller!.move(
        point: Constants.initialPoint,
        animation: const MapAnimation(smooth: true, duration: 1.0));
  }

  void setPos(Point point) async {
    await controller!.move(
        zoom: 17,
        point: point,
        animation: const MapAnimation(smooth: true, duration: 1.0));

    removePlacemark();
    if (point != Constants.initialPoint) addPlacemark(point);
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
    _nameController = TextEditingController(text: widget.building.name);
    _optionalController =
        TextEditingController(text: widget.building.optional);
    _point = GeoPoint(
        widget.building.point!.latitude, widget.building.point!.longitude);
    _imagePath = widget.building.imagePath!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление точки'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      YandexMap(
                        onMapCreated:
                            (YandexMapController yandexMapController) async {
                          controller = yandexMapController;
                        },
                        onMapRendered: () async {
                          print('Map rendered');

                          setPos(Point(
                            longitude: _point!.longitude,
                            latitude: _point!.latitude,
                          ));

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
                        onMapSizeChanged: (MapSize size) => print(
                            'Map size changed to ${size.width}x${size.height}'),
                        onMapTap: (Point point) => print(
                            'Tapped map at ${point.latitude},${point.longitude}'),
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
                                    icon:
                                        Icon(Icons.do_not_disturb_on_outlined)),
                                IconButton(
                                    onPressed: () {
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
                BuildingForm(
                  nameController: _nameController,
                  optionalController: _optionalController,
                  formKey: _formKey,
                ),
                ImageLoading(
                  onLoadPressed: () {
                    getPhoto();
                  },
                  image: _image,
                  item: widget.building,
                ),
              ],
            ),
          ),
          Consumer<AppProvider>(
            builder: (context, state, child) {
              return EditButtonsSection(
                onEditPressed: () {
                  _editBuilding(
                    state,
                    _nameController.text.trim(),
                    _optionalController.text.trim(),
                  );
                },
                onRemovePressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RemoveItem(
                        itemName: 'точку',
                        onRemovePressed: () {
                          state.removeBuilding(widget.building.docId!);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(msg: 'Точка успешно удалена');
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
