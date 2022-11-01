import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExercisesModel {
  final String bodyPart;
  final String equipment;
  final String id;
  final String name;
  final String target;
  final String gifUrl;
  bool isSelected;
  bool isDone;
  ExercisesModel({
    required this.bodyPart,
    required this.equipment,
    required this.id,
    required this.name,
    required this.target,
    required this.gifUrl,
    this.isSelected = false,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bodyPart': bodyPart,
      'equipment': equipment,
      'id': id,
      'name': name,
      'target': target,
    };
  }

  factory ExercisesModel.fromJson(Map<String, dynamic> map) {
    return ExercisesModel(
      bodyPart: map['bodyPart'] as String,
      equipment: map['equipment'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      target: map['target'] as String,
      gifUrl: map['gifUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ExercisesModel(bodyPart: $bodyPart, equipment: $equipment, id: $id, name: $name, target: $target)';
  }
}
