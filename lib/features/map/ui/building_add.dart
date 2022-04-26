import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/widgets/add_buttons_section.dart';
import 'package:bntu_app/ui/widgets/image_loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../provider/map_provider.dart';
import 'widgets/building_form.dart';

class BuildingAdd extends StatefulWidget {
  const BuildingAdd({Key? key}) : super(key: key);

  @override
  _BuildingAddState createState() => _BuildingAddState();
}

class _BuildingAddState extends State<BuildingAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _optionalController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? _image;
  String _imagePath = '';
  UploadTask? task;
  final ImagePicker _picker = ImagePicker();

  static YandexMapController? controller;
  bool isNightModeEnabled = false;
  bool isZoomGesturesEnabled = false;
  bool isTiltGesturesEnabled = false;
  late Point _newPoint;

  void getPhoto() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }

  Future<void> saveImage() async {
    Uint8List? data;
    await File(_image!.path)
        .readAsBytes()
        .then((value) => {data = Uint8List.fromList(value)});

    task = uploadFile(data!);
    setState(() {});
    await showDialog(
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

    final storageTaskSnapshot = await task!.whenComplete(() {
      task = null;
    });
    final path = await storageTaskSnapshot.ref.getDownloadURL();

    _imagePath = path;
  }

  UploadTask? uploadFile(Uint8List data) {
    try {
      final storageReference = FirebaseStorage.instance
          .ref('buildings/${_nameController.text}/photo.jpg');
      // return storageReference.putFile(File(_image.path));

      return storageReference.putData(data);
    } on FirebaseException catch (_) {
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

  // Future<void> _getUser() async {
  //   final user = await _authService.getCurrentUser();
  //   setState(() {
  //     _user = user as User;
  //   });
  // }

  void _addBuilding(MapProvider state) async {
    if (_formKey.currentState!.validate()) {
      if (_image != null) {
        await saveImage().whenComplete(() {
          state.addBuilding(
            _nameController.text.trim(),
            _optionalController.text.trim(),
            _newPoint,
            _imagePath,
          );
          Navigator.of(context).pop();
        });
      } else {
        state.addBuilding(
          _nameController.text.trim(),
          _optionalController.text.trim(),
          _newPoint,
          '',
        );
      }
      Navigator.of(context).pop();
      await Fluttertoast.showToast(msg: 'Точка успешно добавлена');
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
    if (point != Constants.initialPoint) await addPlacemark(point);
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
    if (controller!.placemarks.isNotEmpty) {
      controller!.removePlacemark(controller!.placemarks.first);
    }
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
    await controller!.enableCameraTracking(
      onCameraPositionChange: cameraPositionChanged,
      style: const PlacemarkStyle(
          iconName: 'assets/yandex_images/place.png', opacity: 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
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
                          setInitialPos();
                          // if (widget.isEdit) {
                          //   setPos(Point(
                          //     longitude: _point!.longitude,
                          //     latitude: _point!.latitude,
                          //   ));
                          // }
                          await enableCameraTracking();
                          if (themeProvider.brightness ==
                              CustomBrightness.dark) {
                            await controller?.toggleNightMode(enabled: true);
                          }
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
                ),
              ],
            ),
          ),
          Consumer<MapProvider>(
            builder: (context, state, child) {
              return AddButtonsSection(onAddPressed: () {
                _addBuilding(state);
              });
            },
          ),
        ],
      ),
    );
  }
}
