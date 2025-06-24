// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoSummary _$PhotoSummaryFromJson(Map<String, dynamic> json) => PhotoSummary(
      sol: (json['sol'] as num).toInt(),
      earthDate: json['earth_date'] as String,
      totalPhotos: (json['total_photos'] as num).toInt(),
    );

Map<String, dynamic> _$PhotoSummaryToJson(PhotoSummary instance) =>
    <String, dynamic>{
      'sol': instance.sol,
      'earth_date': instance.earthDate,
      'total_photos': instance.totalPhotos,
    };
