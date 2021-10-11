import 'package:bntu_app/models/buildings_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/widgets/buildings_modal.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'building_add.dart';
import 'building_edit.dart';

class BuildingsMap extends StatefulWidget {
  const BuildingsMap({Key? key}) : super(key: key);

  @override
  _BuildingsMapState createState() => _BuildingsMapState();
}

class _BuildingsMapState extends State<BuildingsMap> {
  static YandexMapController? controller;
  bool _showOptional = true;
  final Color mainColor = Color.fromARGB(255, 0, 138, 94);
  AuthService _authService = AuthService();
  User? _user;

  int _selectedIndex = -1;

  Future<void> _getUser() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _user = user as User;
    });
  }

  bool isNightModeEnabled = false;
  bool isZoomGesturesEnabled = false;
  bool isTiltGesturesEnabled = false;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void setPos(Point point) async {
    await controller!.move(
        zoom: 17,
        point: point,
        animation: const MapAnimation(smooth: true, duration: 1.0));

    removePlacemark();
    if (point != Constants.initialPoint) addPlacemark(point);
  }

  void _showBottomSheet(String title, String subtitle, String imagePath) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheet(
            title: title, subtitle: subtitle, imagePath: imagePath);
      },
    );
  }

  void setInitialPos() async {
    await controller!.move(
        point: Constants.initialPoint,
        animation: const MapAnimation(smooth: true, duration: 1.0));

    removePlacemark();
  }

  Future<void> cameraPositionChanged(dynamic arguments) async {
    final bool bFinal = arguments['final'];
    if (bFinal) {
      await addPlacemark(Point(
          latitude: arguments['latitude'], longitude: arguments['longitude']));
    }
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Карта корпусов'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: SwitchListTile(
                      onChanged: (bool value) {
                        setState(() {
                          _showOptional = value;
                        });
                        Navigator.of(context).pop();
                      },
                      value: _showOptional,
                      title: Text('Отображение доп.информации'),
                      activeColor: mainColor,
                      activeTrackColor: Color.fromARGB(120, 0, 138, 94),
                    ),
                  ),
                  if (_user != null)
                    PopupMenuItem(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BuildingAdd()));
                        },
                        title: Text('Добавить точку'),
                      ),
                    ),
                ],
                tooltip: 'Настройки',
                icon: Icon(Icons.settings),
              ),
              IconButton(
                  onPressed: () {
                    state.initBuildings();
                  },
                  tooltip: 'Обновить список',
                  icon: Icon(Icons.refresh)),
            ],
          ),
          body: Column(
            children: [
              Expanded(
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
                          isTiltGesturesEnabled = tiltGesturesEnabled;
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
                                  tooltip: 'Приблизить',
                                  icon: Icon(Icons.add)),
                              IconButton(
                                  onPressed: () {
                                    controller!.zoomOut();
                                  },
                                  tooltip: 'Отдалить',
                                  icon: Icon(Icons.remove)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedIndex = -1;
                                    });
                                    setInitialPos();
                                  },
                                  tooltip: 'Показать студгородок',
                                  icon: Icon(Icons.zoom_out_map)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: !state.isBuildingsLoaded
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: state.buildings.length,
                        itemBuilder: (BuildContext context, int index) {
                          Building item = state.buildings[index];
                          String subtitle = _showOptional
                              ? item.optional != ''
                                  ? ' (${item.optional})'
                                  : ''
                              : '';
                          String title = item.name! + subtitle;
                          return ListTile(
                            onTap: () {
                              _selectedIndex = index;
                              setPos(item.point!);
                            },
                            title: Text(title),
                            selected: index == _selectedIndex,
                            trailing: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _selectedIndex = index;
                                        setPos(item.point!);
                                        _showBottomSheet(item.name!, item.optional!,
                                            item.imagePath!);
                                      },
                                      tooltip: 'Показать фото',
                                      padding: EdgeInsets.all(0),
                                      icon: const Icon(Icons.info),
                                    ),
                                    if (_user != null)
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BuildingEdit(building: item),
                                            ),
                                          );
                                        },
                                        tooltip: 'Редактировать',
                                        padding: EdgeInsets.all(0),
                                        icon: const Icon(Icons.edit),
                                      ),
                                    IconButton(
                                      onPressed: () {
                                        try {
                                          state.moveUpBuilding(
                                            state.buildings[index].docId.toString(),
                                            state.buildings[index - 1].docId.toString(),
                                          );
                                        } catch (e) {}
                                      },
                                      tooltip: 'Поднять в списке',
                                      icon: Icon(
                                        Icons.arrow_upward,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        try {
                                          state.moveDownBuilding(
                                            state.buildings[index].docId.toString(),
                                            state.buildings[index + 1].docId.toString(),
                                          );
                                        } catch (e) {}
                                      },
                                      tooltip: 'Опустить в списке',
                                      icon: Icon(
                                        Icons.arrow_downward,
                                      ),
                                    ),
                                  ],
                                ),
                                // if (_user != null)
                                //   Row(
                                //     mainAxisSize: MainAxisSize.min,
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       IconButton(
                                //         onPressed: () {
                                //           try {
                                //             state.moveUpInfoCard(
                                //               state.buildings[index].docId.toString(),
                                //               state.buildings[index - 1].docId.toString(),
                                //             );
                                //           } catch (e) {}
                                //         },
                                //         tooltip: 'Поднять в списке',
                                //         icon: Icon(
                                //           Icons.arrow_upward,
                                //           color: mainColor,
                                //         ),
                                //       ),
                                //       IconButton(
                                //         onPressed: () {
                                //           try {
                                //             state.moveDownInfoCard(
                                //               state.buildings[index].docId.toString(),
                                //               state.buildings[index + 1].docId.toString(),
                                //             );
                                //           } catch (e) {}
                                //         },
                                //         tooltip: 'Опустить в списке',
                                //         icon: Icon(
                                //           Icons.arrow_downward,
                                //           color: mainColor,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                              ],
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
