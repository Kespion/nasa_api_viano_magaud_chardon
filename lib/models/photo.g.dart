// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      id: (json['id'] as num).toInt(),
      sol: (json['sol'] as num).toInt(),
      imgSrc: json['img_src'] as String?,
      earthDate: json['earth_date'] as String,
      camera: Camera.fromJson(json['camera'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'sol': instance.sol,
      'img_src': instance.imgSrc,
      'earth_date': instance.earthDate,
      'camera': instance.camera,
    };

Camera _$CameraFromJson(Map<String, dynamic> json) => Camera(
      name: json['name'] as String,
    );

Map<String, dynamic> _$CameraToJson(Camera instance) => <String, dynamic>{
      'name': instance.name,
    };
