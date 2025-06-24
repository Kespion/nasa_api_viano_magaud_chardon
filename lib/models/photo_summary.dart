import 'package:json_annotation/json_annotation.dart';

part 'photo_summary.g.dart';

@JsonSerializable()
class PhotoSummary {
  final int sol;
  @JsonKey(name: 'earth_date')
  final String earthDate;
  @JsonKey(name: 'total_photos')
  final int totalPhotos;

  PhotoSummary({
    required this.sol,
    required this.earthDate,
    required this.totalPhotos,
  });

  factory PhotoSummary.fromJson(Map<String, dynamic> json) => _$PhotoSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoSummaryToJson(this);
}
