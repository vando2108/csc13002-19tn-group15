class Item {
  final String id;
  final String title;
  final String category;
  final List<dynamic> photos_link;
  final String desc;
  final DateTime due_date;
  final String upload_by;
  final String status;

  Item(
      this.id,
      this.title,
      this.category,
      this.photos_link,
      this.desc,
      this.due_date,
      this.upload_by,
      this.status);

  Item.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        category = json["category"],
        photos_link = json["photos_link"],
        desc = json["description"],
        due_date = DateTime.parse(json["due_date"]),
        upload_by = json["upload_by"],
        status = json["status"];
}
