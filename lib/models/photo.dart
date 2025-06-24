import 'package:json_annotation/json_annotation.dart';
part 'photo.g.dart';

@JsonSerializable()
class Photo {
  final int id;
  @JsonKey(name: 'sol')
  final int sol;
  @JsonKey(name: 'img_src')
  final String imgSrc;
  @JsonKey(name: 'earth_date')
  final String earthDate;
  final Camera camera;

  Photo({
    required this.id,
    required this.sol,
    required this.imgSrc,
    required this.earthDate,
    required this.camera,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable()
class Camera {
  final String name;
  final String fullName;

  Camera({required this.name, required this.fullName});

  factory Camera.fromJson(Map<String, dynamic> json) => _$CameraFromJson(json);
  Map<String, dynamic> toJson() => _$CameraToJson(this);
}