// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    itemId: json['item_id'] as String,
    title: json['title'] as String?,
    category: json['category'] as String?,
    photosLink: (json['photos_link'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    description: json['description'] as String?,
    dueDate: json['due_date'] == null
        ? null
        : DateTime.parse(json['due_date'] as String),
    uploadedBy: json['uploaded_by'] as String?,
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'item_id': instance.itemId,
      'title': instance.title,
      'category': instance.category,
      'photos_link': instance.photosLink,
      'description': instance.description,
      'due_date': instance.dueDate?.toIso8601String(),
      'uploaded_by': instance.uploadedBy,
      'status': instance.status,
    };
