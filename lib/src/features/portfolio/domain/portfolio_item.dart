// ignore_for_file: public_member_api_docs, sort_constructors_first
class PortfolioItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  PortfolioItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'PortfolioItem(id: $id, title: $title, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant PortfolioItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        imageUrl.hashCode;
  }
}
