import 'package:flutter/cupertino.dart';

class User
{

   int _id;
   String _name;
   String _adress;
   int _type;
   int _preferences;

  int get id => _id;
  String get name => _name;
  String get adress => _adress;
  int get type => _type;
  int get preferences => _preferences;

  User(this._name, this._adress, this._preferences, this._type);

  User.withId(this._id, this._name, this._adress, this._preferences, this._type);


  set name(String value) {
    _name = value;
  }

  set adress(String value) {
    _adress = value;
  }

  set type(int value) {
    _type = value;
  }

  set preferences(int value) {
    _preferences = value;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    debugPrint("INSERTING NAME FROM TO MAP$_name");
    map['name'] = _name;
    map['adress'] = _adress;
    map['preferences'] = _preferences;
    map['type'] = _type;
    debugPrint("INSERTING NAME FROM TO MAP$map");
    return map;
  }

  // Extract a Note object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._adress = map['adress'];
    this._preferences = map['preferences'];
    this._type = map['type'];
  }


}