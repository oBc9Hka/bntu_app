import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/themes/material_themes.dart';
import 'package:bntu_app/models/buildings_model.dart';
import 'package:bntu_app/util/data.dart';
import 'package:bntu_app/yandex/widgets/dummy_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class BuildingsMap extends StatefulWidget {
  const BuildingsMap({Key? key}) : super(key: key);

  @override
  _BuildingsMapState createState() => _BuildingsMapState();
}

class _BuildingsMapState extends State<BuildingsMap> {
  static YandexMapController? controller;
  final Data _data = Data();
  bool _showOptional = true;
  final Color mainColor = Color.fromARGB(255, 0, 138, 94);
  Building _prevSelectedItem = Building(
      name: '', optional: '', isActive: false, point: Data.initialPoint);

  bool isNightModeEnabled = false;
  bool isZoomGesturesEnabled = false;
  bool isTiltGesturesEnabled = false;

  List<Building> _buildings = Data().buildings;

  @override
  void initState() {
    super.initState();
  }

  void setPos(Point point) async {
    await controller!.move(
        zoom: 17,
        point: point,
        animation: const MapAnimation(smooth: true, duration: 1.0));

    removePlacemark();
    if (point != Data.initialPoint) addPlacemark(point);
  }

  void setInitialPos() async {
    await controller!.move(
        point: Data.initialPoint,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Карта корпусов'),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
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
                  activeTrackColor: mainColor,
                ),
                // child: ListTile(title: Text('Отображение факультетов'), trailing: Icon(Icons.toggle_on),),
              ),
            ],
            icon: Icon(Icons.settings),
          )
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
                  onMapSizeChanged: (MapSize size) =>
                      print('Map size changed to ${size.width}x${size.height}'),
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
                              icon: Icon(Icons.do_not_disturb_on_outlined)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _prevSelectedItem.isActive = false;
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
          Expanded(
            child: ListView.separated(
              itemCount: _buildings.length,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                var item = _buildings[index];
                String subtitle = _showOptional
                    ? item.optional != ''
                        ? ' (${item.optional})'
                        : ''
                    : '';
                String title = item.name + subtitle;
                return ListTile(
                  title: Text(
                    title,
                    style: TextStyle(color: item.isActive ? mainColor : null),
                  ),
                  onTap: () {
                    setState(() {
                      _prevSelectedItem.isActive = false;
                      item.isActive = true;
                      _prevSelectedItem = item;
                    });
                    setPos(item.point);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
