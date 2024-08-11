import '../../../constant/enums.dart';

class Ability {
  Slot slot;
  String displayName;
  String description;
  String? displayIcon;

  Ability({
    required this.slot,
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
    slot: slotValues.map[json["slot"]]!,
    displayName: json["displayName"],
    description: json["description"],
    displayIcon: json["displayIcon"],
  );

  Map<String, dynamic> toJson() => {
    "slot": slotValues.reverse[slot],
    "displayName": displayName,
    "description": description,
    "displayIcon": displayIcon,
  };

}

enum Slot {
  ABILITY1,
  ABILITY2,
  GRENADE,
  PASSIVE,
  ULTIMATE
}

final slotValues = EnumValues({
  "Ability1": Slot.ABILITY1,
  "Ability2": Slot.ABILITY2,
  "Grenade": Slot.GRENADE,
  "Passive": Slot.PASSIVE,
  "Ultimate": Slot.ULTIMATE
});