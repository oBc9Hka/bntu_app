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
  static const Point _initialPoint =
      Point(latitude: 53.922288, longitude: 27.593033);
  static const Point _fitrPoint = Point(
      latitude: 53.923535877325975,
      longitude: 27.594567697065315); //53.923249, 27.594045
  static const Point _stfPoint =
      Point(latitude: 53.923110908637625, longitude: 27.595203159339945);
  static const Point _mainPoint =
      Point(latitude: 53.920923742676344, longitude: 27.59313709795913);

  bool isNightModeEnabled = false;
  bool isZoomGesturesEnabled = false;
  bool isTiltGesturesEnabled = false;

  final Placemark _placemarkWithDynamicIcon = Placemark(
    point: const Point(latitude: 30.320045, longitude: 59.945933),
    onTap: (Placemark self, Point point) =>
        print('Tapped me at ${point.latitude},${point.longitude}'),
    style: PlacemarkStyle(
      opacity: 0.95,
      rawImageData: rawImageData,
    ),
  );

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
    if (point != _initialPoint) addPlacemark(point);
  }

  void setInitialPos() async{
    await controller!.move(
        point: _initialPoint,
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
      ),
      body: Column(
        children: [
          Expanded(
            child: YandexMap(
                onMapCreated: (YandexMapController yandexMapController) async {
                  controller = yandexMapController;
                },
                onMapRendered: () async {
                  print('Map rendered');
                  setPos(_initialPoint);
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
                onMapTap: (Point point) =>
                    print('Tapped map at ${point.latitude},${point.longitude}'),
                onMapLongTap: (Point point) => print(
                    'Long tapped map at ${point.latitude},${point.longitude}')),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Корпус 11А ФИТР'),
                  onTap: () {
                    // removePlacemark();
                    setPos(_fitrPoint);
                    // addPlacemark(_fitrPoint);
                  },
                ),
                ListTile(
                  title: Text('Корпус 11Б СТФ'),
                  onTap: () {
                    // removePlacemark();
                    setPos(_stfPoint);
                    // addPlacemark(_stfPoint);
                  },
                ),
                ListTile(
                  title: Text('Корпус 1 Главный'),
                  onTap: () {
                    // removePlacemark();
                    setPos(_mainPoint);
                    // addPlacemark(_mainPoint);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setInitialPos();
                  },
                  child: Text('БНТУ'),
                ),
                ElevatedButton(
                  onPressed: () {
                    addPlacemark(_fitrPoint);
                  },
                  child: Text('Placemark'),
                ),
                ElevatedButton(
                  onPressed: () {
                    removePlacemark();
                  },
                  child: Text('Remove Placemark'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
