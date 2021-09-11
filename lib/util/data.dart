import 'package:bntu_app/models/info_cards_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../models/buildings_model.dart';

class Data {
  // Map data
  static Point initialPoint = Point(
    latitude: 53.922288,
    longitude: 27.593033,
  );
  static Point mainPoint = Point(
    latitude: 53.920923742676344,
    longitude: 27.59313709795913,
  );
  static Point k2Point = Point(
    latitude: 53.92233624395413,
    longitude: 27.59204490826724,
  );
  static Point k3Point = Point(
    latitude: 53.92134241046744,
    longitude: 27.59166895032382,
  );
  static Point k4Point = Point(
    latitude: 53.91910324719865,
    longitude: 27.589826140063735,
  );
  static Point k5Point = Point(
    latitude: 53.92081864094582,
    longitude: 27.59123845256903,
  );
  static Point k6Point = Point(
    latitude: 53.92325660127674,
    longitude: 27.594087015709988,
  );
  static Point k7Point = Point(
    latitude: 53.92407681668006,
    longitude: 27.59250309543205,
  );
  static Point k8Point = Point(
    latitude: 53.920566711381106,
    longitude: 27.588723434350214,
  );
  static Point k9Point = Point(
    latitude: 53.92159897823049,
    longitude: 27.589887749918546,
  );
  static Point k10Point = Point(
    latitude: 53.87637617942955,
    longitude: 27.624218476663117,
  );
  static Point k11APoint = Point(
    latitude: 53.923535877325975,
    longitude: 27.594567697065315,
  );
  static Point k11BPoint = Point(
    latitude: 53.923118058543665,
    longitude: 27.59519077485521,
  );
  static Point k12Point = Point(
    latitude: 53.92372035805554,
    longitude: 27.59373769649872,
  );
  static Point k13Point = Point(
    latitude: 53.922489451378695,
    longitude: 27.59360227905006,
  );
  static Point k14Point = Point(
    latitude: 53.92288060060802,
    longitude: 27.593045553727734,
  );
  static Point k15Point = Point(
    latitude: 53.9378118395672,
    longitude: 27.66951018893107,
  );
  static Point k16Point = Point(
    latitude: 53.9288556286421,
    longitude: 27.66924613393249,
  );
  static Point k17Point = Point(
    latitude: 53.923462691462255,
    longitude: 27.591747159328776,
  );
  static Point k18APoint = Point(
    latitude: 53.921608433132704,
    longitude: 27.59442148433854,
  );
  static Point k18BPoint = Point(
    latitude: 53.921912962179206,
    longitude: 27.59386104215173,
  );
  static Point k19Point = Point(
    latitude: 53.92864362453092,
    longitude: 27.613752288620248,
  );
  static Point k20Point = Point(
    latitude: 53.930665888895454,
    longitude: 27.668686985918043,
  );

  List<Building> buildings = [
    Building(
        name: 'Главный корпус',
        optional: '',
        isActive: false,
        point: mainPoint),
    Building(
        name: 'Корпус №2',
        optional: 'Деканат ЭФ',
        isActive: false,
        point: k2Point),
    Building(name: 'Корпус №3', optional: '', isActive: false, point: k3Point),
    Building(
        name: 'Корпус №4',
        optional: 'Деканат ВТФ',
        isActive: false,
        point: k4Point),
    Building(
        name: 'Корпус №5',
        optional: 'Деканат СТФ',
        isActive: false,
        point: k5Point),
    Building(
        name: 'Корпус №6',
        optional: 'Деканат МСФ',
        isActive: false,
        point: k6Point),
    Building(
        name: 'Корпус №7',
        optional: 'Деканат МТФ',
        isActive: false,
        point: k7Point),
    Building(
        name: 'Корпус №8',
        optional: 'Деканат АТФ',
        isActive: false,
        point: k8Point),
    Building(name: 'Корпус №9', optional: '', isActive: false, point: k9Point),
    Building(
        name: 'Корпус №10', optional: '', isActive: false, point: k10Point),
    Building(
        name: 'Корпус №11А',
        optional: 'Деканат ФИТР',
        isActive: false,
        point: k11APoint),
    Building(
        name: 'Корпус №11Б',
        optional: 'Спортклуб БНТУ',
        isActive: false,
        point: k11BPoint),
    Building(
        name: 'Корпус №12', optional: '', isActive: false, point: k12Point),
    Building(
        name: 'Корпус №13', optional: '', isActive: false, point: k13Point),
    Building(
        name: 'Корпус №14', optional: '', isActive: false, point: k14Point),
    Building(
        name: 'Корпус №15', optional: '', isActive: false, point: k15Point),
    Building(
        name: 'Корпус №16', optional: 'Деканат СФ', isActive: false, point: k16Point),
    Building(
        name: 'Корпус №17',
        optional: 'Деканат ПСФ',
        isActive: false,
        point: k17Point),
    Building(
        name: 'Корпус №18A',
        optional: 'Деканат ФМПП, ФЭС',
        isActive: false,
        point: k18APoint),
    Building(
        name: 'Корпус №18Б',
        optional: 'Деканат ФМПП, ФЭС',
        isActive: false,
        point: k18BPoint),
    Building(
        name: 'Корпус №19',
        optional: 'Лицей БНТУ',
        isActive: false,
        point: k19Point),
    Building(
      name: 'Корпус №20',
      optional: 'ИПФ, ФТК',
      isActive: false,
      point: k20Point,
    )
  ];

}
