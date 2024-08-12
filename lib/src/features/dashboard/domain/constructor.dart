// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef ConstructorID = String;

class ConstructorIslamabad extends Equatable {
  const ConstructorIslamabad({
    required this.id,
    required this.title,
    required this.detail,
    required this.name,
    required this.imageUrl,
    required this.location,
  });
  final ConstructorID id;
  final String title;

  final String detail;
  final String name;
  final String imageUrl;
  final String location;

  factory ConstructorIslamabad.fromMap(Map<String, dynamic> map) {
    return ConstructorIslamabad(
      id: map['id'] as String,
      title: map['title'] ?? '',
      detail: map['detail'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] as String,
      location: map['location'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'name': name,
      'imageUrl': imageUrl,
      'location': location,
    };
  }

  ConstructorIslamabad copyWith({
    ConstructorID? id,
    String? title,
    String? detail,
    String? name,
    String? imageUrl,
    String? location,
  }) {
    return ConstructorIslamabad(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
    );
  }

  @override
  String toString() {
    return 'ConstructorIslamabad(id: $id, title: $title,  detail: $detail, name: $name, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant ConstructorIslamabad other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.detail == detail &&
        other.name == name &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        detail.hashCode ^
        name.hashCode ^
        imageUrl.hashCode;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        detail,
        name,
        imageUrl,
        location,
      ];
}
