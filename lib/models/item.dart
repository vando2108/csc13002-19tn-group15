class Item {
  final String itemId;
  final String title;
  final String category;
  final List<String> photosLink;
  final String description;
  final DateTime? dueDate;
  final String uploadedBy;
  final String status;

  Item({
    required this.itemId,
    this.title = "",
    this.category = "",
    this.photosLink = const [],
    this.description = "",
    this.dueDate,
    this.uploadedBy = "",
    this.status = "",
  });
}
