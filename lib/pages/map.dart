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
  static const Point _initialPoint = Point(
    latitude: 53.922288,
    longitude: 27.593033,
  );
  static const Point _fitrPoint = Point(
    latitude: 53.923535877325975,
    longitude: 27.594567697065315,
  ); //53.923249, 27.594045
  static const Point _stfPoint = Point(
    latitude: 53.92081864094582,
    longitude: 27.59123845256903,
  );
  static const Point _stf11Point = Point(
    latitude: 53.923118058543665,
    longitude: 27.59519077485521,
  );
  static const Point _atfPoint = Point(
    latitude: 53.920566711381106,
    longitude: 27.588723434350214,
  );
  static const Point _vtfPoint = Point(
    latitude: 53.91910324719865,
    longitude: 27.589826140063735,
  );
  static const Point _afPoint = Point(
    latitude: 53.920630730257464,
    longitude: 27.592178328101312,
  );
  static const Point _msfPoint = Point(
    latitude: 53.92323901242053,
    longitude: 27.59410660579215,
  );
  static const Point _psfPoint = Point(
    latitude: 53.923462691462255,
    longitude: 27.591747159328776,
  );
  static const Point _mtfPoint = Point(
    latitude: 53.92400876345276,
    longitude: 27.592709257715995,
  );
  static const Point _efPoint = Point(
    latitude: 53.92233624395413,
    longitude: 27.59204490826724,
  );
  static const Point _mainPoint = Point(
    latitude: 53.920923742676344,
    longitude: 27.59313709795913,
  );

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

  List<Map<String, dynamic>> _buildings = [
    {'name': 'Главный корпус', 'point': _mainPoint},
    {'name': 'Корпус №2 (ЭФ)', 'point': _efPoint},
    {'name': 'Корпус №3', 'point': _mainPoint},
    {'name': 'Корпус №4 ВТФ()', 'point': _vtfPoint},
    {'name': 'Корпус №5 (СТФ)', 'point': _stfPoint},
    {'name': 'Корпус №6 (МСФ)', 'point': _msfPoint},
    {'name': 'Корпус №7 (МТФ)', 'point': _mtfPoint},
    {'name': 'Корпус №8 (АТФ)', 'point': _atfPoint},
    {'name': 'Корпус №9', 'point': _mainPoint},
    {'name': 'Корпус №10', 'point': _mainPoint},
    {'name': 'Корпус №11А (ФИТР)', 'point': _fitrPoint},
    {'name': 'Корпус №11Б (Спортклуб БНТУ)', 'point': _stf11Point},
    {'name': 'Корпус №12', 'point': _mainPoint},
    {'name': 'Корпус №13', 'point': _mainPoint},
    {'name': 'Корпус №14', 'point': _mainPoint},
    {'name': 'Корпус №15', 'point': _mainPoint},
    {'name': 'Корпус №16', 'point': _mainPoint},
    {'name': 'Корпус №17 (ПСФ)', 'point': _psfPoint},
    {'name': 'Корпус №18 (ФМПП/ФЭС)', 'point': _mainPoint},
  ];

  @override
  void initState() {
    setInitialPos();
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

  void setInitialPos() async {
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
    const Color main_color = Color.fromARGB(255, 0, 138, 94); // green color
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
                ..._buildings.map(
                  (item) => ListTile(
                    title: Text(item['name']),
                    onTap: () {
                      setPos(item['point']);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
