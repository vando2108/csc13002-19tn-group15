import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User extends Equatable {
  final String id;
  final String email;
  final String? passwordHashCode;
  final String fullName;
  final String? avatarLink;
  final String? phoneNumber;
  final String? address;
  final double? rate;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    this.passwordHashCode,
    this.address,
    this.avatarLink,
    this.phoneNumber,
    this.rate,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        passwordHashCode,
        address,
        avatarLink,
        phoneNumber,
        rate
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
