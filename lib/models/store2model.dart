import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Store2Model {
  final int id;
  final String name;
  final int user;
  final String main_address;
  final String sec_address;
  final String img_url;
  final String main_phone_no;
  final String sec_phone_no;
  Store2Model({
    required this.id,
    required this.name,
    required this.user,
    required this.main_address,
    required this.sec_address,
    required this.img_url,
    required this.main_phone_no,
    required this.sec_phone_no,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'user': user,
      'main_address': main_address,
      'sec_address': sec_address,
      'img_url': img_url,
      'main_phone_no': main_phone_no,
      'sec_phone_no': sec_phone_no,
    };
  }

  factory Store2Model.fromMap(Map<String, dynamic> map) {
    return Store2Model(
      id: map['id'] as int,
      name: map['name'] as String,
      user: map['user'] as int,
      main_address: map['main_address'] as String,
      sec_address: map['sec_address'] as String,
      img_url: map['img_url'] as String,
      main_phone_no: map['main_phone_no'] as String,
      sec_phone_no: map['sec_phone_no'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Store2Model.fromJson(String source) => Store2Model.fromMap(json.decode(source) as Map<String, dynamic>);
}
