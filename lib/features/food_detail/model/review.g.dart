// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
  userName: json['userName'] as String,
  comment: json['comment'] as String,
  rating: (json['rating'] as num).toDouble(),
  userAvatar: json['userAvatar'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'comment': instance.comment,
      'rating': instance.rating,
      'userAvatar': instance.userAvatar,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
