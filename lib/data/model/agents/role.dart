import '../../../constant/enums.dart';

class Role {
  String uuid;
  DisplayName displayName;
  String description;
  String displayIcon;
  String assetPath;

  Role({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
    required this.assetPath,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    uuid: json["uuid"],
    displayName: displayNameValues.map[json["displayName"]]!,
    description: json["description"],
    displayIcon: json["displayIcon"],
    assetPath: json["assetPath"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "displayName": displayNameValues.reverse[displayName],
    "description": description,
    "displayIcon": displayIcon,
    "assetPath": assetPath,
  };
}

enum DisplayName {
  CONTROLLER,
  DUELIST,
  INITIATOR,
  SENTINEL
}

final displayNameValues = EnumValues({
  "Controller": DisplayName.CONTROLLER,
  "Duelist": DisplayName.DUELIST,
  "Initiator": DisplayName.INITIATOR,
  "Sentinel": DisplayName.SENTINEL
});