class Tag {
  final int followersCount;
  final int itemsCount;
  final String? iconUrl;
  final String? id;

  Tag ({required this.followersCount, required this.iconUrl, required this.id, required this.itemsCount});

  factory Tag.fromJson(Map<dynamic, dynamic> json) {
    return Tag(
      followersCount: json['followers_count'],
      itemsCount: json['items_count'],
      iconUrl: json['icon_url'],
      id: json['id'],
    );
  }
}