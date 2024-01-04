import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StoreModel {
  final String username;
  final String storeName;
  final String storeMainAddress;
  final String storeSecAddress;
  final String storeLogoUrl;
  final String storeMainPhoneNo;
  final String storeSecPhoneNo;
  StoreModel({
    required this.username,
    required this.storeName,
    required this.storeMainAddress,
    required this.storeSecAddress,
    required this.storeLogoUrl,
    required this.storeMainPhoneNo,
    required this.storeSecPhoneNo,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'storeName': storeName,
      'storeMainAddress': storeMainAddress,
      'storeSecAddress': storeSecAddress,
      'storeLogoUrl': storeLogoUrl,
      'storeMainPhoneNo': storeMainPhoneNo,
      'storeSecPhoneNo': storeSecPhoneNo,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      username: map['username'] as String,
      storeName: map['storeName'] as String,
      storeMainAddress: map['storeMainAddress'] as String,
      storeSecAddress: map['storeSecAddress'] as String,
      storeLogoUrl: map['storeLogoUrl'] as String,
      storeMainPhoneNo: map['storeMainPhoneNo'] as String,
      storeSecPhoneNo: map['storeSecPhoneNo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) => StoreModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
