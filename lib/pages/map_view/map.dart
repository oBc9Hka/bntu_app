import 'package:bntu_app/pages/map_view/building_add.dart';
import 'package:bntu_app/pages/map_view/building_edit.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:bntu_app/util/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  void showBottomSheet(String title, String subtitle, String imagePath) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle != ''
                            ? Text(
                                subtitle,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: (imagePath != '')
                    ? Stack(
                        children: [
                          Center(child: CircularProgressIndicator()),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.network(imagePath, loadingBuilder:
                                    (BuildContext context, Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return CircularProgressIndicator();
                                }).image,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(child: Text('Изображение отсутствует')),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                              icon: Icon(Icons.remove)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = -1;
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('buildings')
                  .orderBy('name')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    ),
                  );
                if (snapshot.data!.docs.isEmpty) return Text('Данных нет');

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?> item =
                        snapshot.data!.docs[index];
                    if (index != snapshot.data!.docs.length)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      );
                    String subtitle = _showOptional
                        ? item['optional'] != ''
                            ? ' (${item['optional']})'
                            : ''
                        : '';
                    String title = item['name'] + subtitle;
                    GeoPoint _pointToCast = item['point'];
                    Point _point = Point(
                        latitude: _pointToCast.latitude,
                        longitude: _pointToCast.longitude);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          setPos(_point);
                        },
                        title: Text(title),
                        selected: index == _selectedIndex,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                                setPos(_point);
                                showBottomSheet(item['name'],
                                    item['optional'], item['imagePath']);
                              },
                              padding: EdgeInsets.all(0),
                              icon: const Icon(Icons.info),
                            ),
                            if (_user != null)
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BuildingEdit(
                                                  building: item)));
                                },
                                padding: EdgeInsets.all(0),
                                icon: const Icon(Icons.edit),
                              ),
                          ],
                        ),
                      ),
                    );
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
