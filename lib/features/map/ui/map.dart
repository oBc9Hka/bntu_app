import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/constants/constants.dart';
import '../../../core/provider/app_provider.dart';
import 'widgets/buildings_modal.dart';
import '../provider/map_provider.dart';
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

  int _selectedIndex = -1;

  bool isNightModeEnabled = false;
  bool isZoomGesturesEnabled = false;
  bool isTiltGesturesEnabled = false;

  void setPos(Point point) async {
    await controller!.move(
        zoom: 17,
        point: point,
        animation: const MapAnimation(smooth: true, duration: 1.0));

    removePlacemark();
    if (point != Constants.initialPoint) await addPlacemark(point);
  }

  void _showBottomSheet(
      String title, String subtitle, String imagePath, String description) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheet(
          title: title,
          subtitle: subtitle,
          imagePath: imagePath,
          description: description,
        );
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
    if (controller!.placemarks.isNotEmpty) {
      controller!.removePlacemark(controller!.placemarks.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final appState = context.watch<AppProvider>();
    return Consumer<MapProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('?????????? ????????????????'),
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
                      title: Text('?????????????????????? ??????.????????????????????'),
                      activeColor: Constants.mainColor,
                      activeTrackColor: Color.fromARGB(120, 0, 138, 94),
                    ),
                  ),
                  if (appState.user != null)
                    PopupMenuItem(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BuildingAdd()));
                        },
                        title: Text('???????????????? ??????????'),
                      ),
                    ),
                ],
                tooltip: '??????????????????',
                icon: Icon(Icons.settings),
              ),
              if (appState.user != null)
                IconButton(
                    onPressed: () {
                      state.initBuildings();
                    },
                    tooltip: '???????????????? ????????????',
                    icon: Icon(Icons.refresh)),
            ],
          ),
          body: kIsWeb
              ? Center(
                  child: Text(
                      '???????????? ?? ?????????????? ???????? ???? ???????????????????????????? ?? ????????????????'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          YandexMap(
                            onMapCreated: (YandexMapController
                                yandexMapController) async {
                              controller = yandexMapController;
                            },
                            onMapRendered: () async {
                              print('Map rendered');
                              setInitialPos();
                              var tiltGesturesEnabled =
                                  await controller!.isTiltGesturesEnabled();
                              var zoomGesturesEnabled =
                                  await controller!.isZoomGesturesEnabled();

                              if (themeProvider.brightness ==
                                  CustomBrightness.dark) {
                                await controller?.toggleNightMode(
                                    enabled: true);
                              }

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
                                        tooltip: '????????????????????',
                                        icon: Icon(Icons.add)),
                                    IconButton(
                                        onPressed: () {
                                          controller!.zoomOut();
                                        },
                                        tooltip: '????????????????',
                                        icon: Icon(Icons.remove)),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _selectedIndex = -1;
                                          });
                                          setInitialPos();
                                        },
                                        tooltip: '???????????????? ??????????????????????',
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
                                var item = state.buildings[index];
                                var subtitle = _showOptional
                                    ? item.optional != ''
                                        ? ' (${item.optional})'
                                        : ''
                                    : '';
                                var title = item.name! + subtitle;
                                return ListTile(
                                  tileColor: themeProvider.brightness ==
                                          CustomBrightness.light
                                      ? Colors.white
                                      : null,
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                    setPos(item.point!);
                                  },
                                  title: Text(title),
                                  selected: index == _selectedIndex,
                                  trailing: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _selectedIndex = index;
                                              setPos(item.point!);
                                              _showBottomSheet(
                                                  item.name!,
                                                  item.optional!,
                                                  item.imagePath!,
                                                  item.description ?? '');
                                            },
                                            tooltip: '???????????????? ????????',
                                            padding: EdgeInsets.all(0),
                                            icon: const Icon(Icons.info),
                                          ),
                                          if (appState.user != null)
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BuildingEdit(
                                                            building: item),
                                                  ),
                                                );
                                              },
                                              tooltip: '??????????????????????????',
                                              padding: EdgeInsets.all(0),
                                              icon: const Icon(Icons.edit),
                                            ),
                                          if (appState.user != null)
                                            IconButton(
                                              onPressed: () {
                                                try {
                                                  state.moveUpBuilding(
                                                    state.buildings[index].docId
                                                        .toString(),
                                                    state.buildings[index - 1]
                                                        .docId
                                                        .toString(),
                                                  );
                                                } catch (e) {
                                                  print('catch');
                                                }
                                              },
                                              tooltip: '?????????????? ?? ????????????',
                                              icon: Icon(
                                                Icons.arrow_upward,
                                              ),
                                            ),
                                          if (appState.user != null)
                                            IconButton(
                                              onPressed: () {
                                                try {
                                                  state.moveDownBuilding(
                                                    state.buildings[index].docId
                                                        .toString(),
                                                    state.buildings[index + 1]
                                                        .docId
                                                        .toString(),
                                                  );
                                                } catch (e) {
                                                  print('catch');
                                                }
                                              },
                                              tooltip: '???????????????? ?? ????????????',
                                              icon: Icon(
                                                Icons.arrow_downward,
                                              ),
                                            ),
                                        ],
                                      ),
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
