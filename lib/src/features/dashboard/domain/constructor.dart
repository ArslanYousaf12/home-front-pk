// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ConstructorIslamabad {
  const ConstructorIslamabad(
      {required this.id,
      required this.title,
      required this.icon,
      required this.detail,
      required this.name,
      required this.imageUrl});
  final String id;
  final String title;
  final IconData icon;
  final String detail;
  final String name;
  final String imageUrl;

  @override
  String toString() {
    return 'ConstructorIslamabad(id: $id, title: $title, icon: $icon, detail: $detail, name: $name, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant ConstructorIslamabad other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.icon == icon &&
        other.detail == detail &&
        other.name == name &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        icon.hashCode ^
        detail.hashCode ^
        name.hashCode ^
        imageUrl.hashCode;
  }
}
