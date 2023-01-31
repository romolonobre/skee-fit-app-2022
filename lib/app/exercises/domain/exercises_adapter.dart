import 'package:skeefiapp/app/core/adpaters/entity_adatpter.dart';

import '../../core/helper/helper.dart';
import 'entities/exercises_entity.dart';

class ExercisesAdapter implements EntityAdatpter {
  @override
  ExerciseEntity fromJson(Map<String, dynamic> map) {
    return ExerciseEntity(
      bodyPart: Helper.getString(map['bodyPart']),
      equipment: Helper.getString(map['equipment']),
      id: Helper.getString(map['id']),
      name: Helper.getString(map['name']),
      target: Helper.getString(map['target']),
      gifUrl: Helper.getString(map['gifUrl']),
    );
  }

  @override
  Map<String, dynamic> toMap() => {};
}
