class Tag {
  final int followersCount;
  final int itemsCount;
  final String iconUrl;
  final String id;

  Tag ({this.followersCount, this.iconUrl, this.id, this.itemsCount});

  factory Tag.fromJson(Map<dynamic, dynamic> json) {
    return Tag(
      followersCount: json['followers_count'],
      itemsCount: json['items_count'],
      iconUrl: json['icon_url'],
      id: json['id'],
    );
  }
}