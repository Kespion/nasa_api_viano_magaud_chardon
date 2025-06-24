// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manifest _$ManifestFromJson(Map<String, dynamic> json) => Manifest(
      roverName: json['name'] as String,
      landingDate: json['landing_date'] as String,
      launchDate: json['launch_date'] as String,
      status: json['status'] as String,
      maxSol: (json['max_sol'] as num).toInt(),
      maxDate: json['max_date'] as String,
      totalPhotos: (json['total_photos'] as num).toInt(),
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManifestToJson(Manifest instance) => <String, dynamic>{
      'name': instance.roverName,
      'landing_date': instance.landingDate,
      'launch_date': instance.launchDate,
      'status': instance.status,
      'max_sol': instance.maxSol,
      'max_date': instance.maxDate,
      'total_photos': instance.totalPhotos,
      'photos': instance.photos,
    };
