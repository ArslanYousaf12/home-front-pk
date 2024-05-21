// ignore_for_file: public_member_api_docs, sort_constructors_first
class Request {
  Request(
      {required this.id,
      required this.title,
      required this.location,
      required this.name});
  final String id;
  final String title;
  final String location;

  final String name;

  @override
  String toString() {
    return 'Request(id: $id, title: $title, location: $location, name: $name)';
  }

  @override
  bool operator ==(covariant Request other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.location == location &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ location.hashCode ^ name.hashCode;
  }
}
