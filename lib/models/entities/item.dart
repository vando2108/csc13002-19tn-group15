import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Item extends Equatable{
  final String itemId;
  final String? title;
  final String? category;
  final List<String>? photosLink;
  final String? description;
  final DateTime? dueDate;
  final String? uploadedBy;
  final String? status;

  Item({
    required this.itemId,
    this.title,
    this.category,
    this.photosLink,
    this.description,
    this.dueDate,
    this.uploadedBy,
    this.status,
  });

  @override
  List<Object?> get props => [itemId, title, category, photosLink, description, dueDate, uploadedBy, status];

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);  
}
