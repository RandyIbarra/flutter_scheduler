/// Course class from UG
class Course {
  String id;
  String name;

  Course({
    this.id = '',
    this.name = '',
  });

  factory Course.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('id')) {
      throw 'Missing "id" key on Course';
    }
    if (!map.containsKey('name')) {
      throw 'Missing "name" key on Course';
    }
    return Course(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}
