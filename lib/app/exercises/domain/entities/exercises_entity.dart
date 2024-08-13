// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExerciseEntity {
  final String id;
  final String name;
  final String bodyPart;
  final String equipment;

  final String target;
  final String gifUrl;
  bool isSelected;
  bool isDone;

  ExerciseEntity({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.target,
    required this.gifUrl,
    this.isSelected = false,
    this.isDone = false,
  });
}
