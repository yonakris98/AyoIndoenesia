import 'dart:io';
import 'dart:math';

class Team {
  int id;
  String name;
  String address;
  String city;
  String since;
  String logo;

  Team(this.id, this.name, this.address, this.city, this.since, this.logo);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'since': since,
      'logo': logo
    };
    return map;
  }

  Team.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    address = map['address'];
    city = map['city'];
    since = map['since'];
    logo = map['logo'];
  }
}
