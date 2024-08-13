// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String imageUrl;

  const ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.imageUrl,
  });

  ProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? imageUrl,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'imageUrl': imageUrl,
    };
  }

  @override
  List<Object> get props {
    return [
      name,
      email,
      phone,
      address,
      imageUrl,
    ];
  }

  @override
  bool get stringify => true;

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
