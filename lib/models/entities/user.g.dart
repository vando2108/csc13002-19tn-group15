// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userId: json['user_id'] as String,
    email: json['email'] as String,
    fullName: json['full_name'] as String,
    passwordHashCode: json['password_hash_code'] as String?,
    address: json['address'] as String?,
    avatarLink: json['avatar_link'] as String?,
    phoneNumber: json['phone_number'] as String?,
    rate: (json['rate'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.userId,
      'email': instance.email,
      'password_hash_code': instance.passwordHashCode,
      'full_name': instance.fullName,
      'avatar_link': instance.avatarLink,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'rate': instance.rate,
    };
