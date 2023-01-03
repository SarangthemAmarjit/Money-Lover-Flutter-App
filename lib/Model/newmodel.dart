class Categoryname {
  String? name;
  String? type;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': type,
    };
  }
}
