// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef DesignerID = String;

class DesignerIslamabad extends Equatable {
  const DesignerIslamabad({
    required this.id,
    required this.title,
    required this.icon,
    required this.detail,
    required this.name,
    required this.imageUrl,
  });
  final DesignerID id;
  final String title;
  final IconData icon;
  final String detail;
  final String name;
  final String imageUrl;

  factory DesignerIslamabad.fromMap(Map<String, dynamic> map) {
    return DesignerIslamabad(
      id: map['id'],
      title: map['title'],
      icon: map['icon'],
      detail: map['detail'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'detail': detail,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  DesignerIslamabad copyWith({
    DesignerID? id,
    String? title,
    IconData? icon,
    String? detail,
    String? name,
    String? imageUrl,
  }) {
    return DesignerIslamabad(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      detail: detail ?? this.detail,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'DesignerIslamabad(id: $id, title: $title, icon: $icon, detail: $detail, name: $name, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant DesignerIslamabad other) {
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

  @override
  List<Object?> get props => [
        id,
        title,
        icon,
        detail,
        name,
        imageUrl,
      ];
}
