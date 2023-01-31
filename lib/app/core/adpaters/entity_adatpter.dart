abstract class EntityAdatpter<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toMap();
}
