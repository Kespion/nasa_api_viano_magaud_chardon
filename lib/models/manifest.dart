import 'package:json_annotation/json_annotation.dart';
import 'package:nasa_api_viano_magaud_chardon/models/photo_summary.dart';

part 'manifest.g.dart';

@JsonSerializable()
class Manifest {
  @JsonKey(name: 'name')
  final String roverName;

  @JsonKey(name: 'landing_date')
  final String landingDate;

  @JsonKey(name: 'launch_date')
  final String launchDate;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'max_sol')
  final int maxSol;

  @JsonKey(name: 'max_date')
  final String maxDate;

  @JsonKey(name: 'total_photos')
  final int totalPhotos;

  @JsonKey(name: 'photos')
  final List<PhotoSummary> photos;

  Manifest({
    required this.roverName,
    required this.landingDate,
    required this.launchDate,
    required this.status,
    required this.maxSol,
    required this.maxDate,
    required this.totalPhotos,
    required this.photos,
  });

  factory Manifest.fromJson(Map<String, dynamic> json) => _$ManifestFromJson(json);
  Map<String, dynamic> toJson() => _$ManifestToJson(this);
}
