/// Activity class
class Activity {
  String? activityId;

  /// For first semester
  String? group;

  /// Activity id
  String courseId;

  /// Persons in charge
  List<String> teachers;

  Activity({
    this.group,
    this.teachers = const [],
    required this.courseId,
    required this.activityId,
  });

  factory Activity.fromMap(Map<String, dynamic> map) {
    // keys check
    if (!map.containsKey('courseId')) {
      throw 'Missing "courseId" key on Activity';
    }
    if (!map.containsKey('activityId')) {
      throw 'Missing "activityId" key on Activity';
    }
    if (!map.containsKey('teachers')) {
      throw 'Missing "teachers" key on Activity';
    }
    return Activity(
      group: map['group'] as String?,
      activityId: map['activityId'] as String,
      courseId: map['courseId'] as String,
      teachers: List<String>.from(map['teachers']),
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'courseId': courseId,
        'teachers': teachers,
        if (group != null) 'group': group,
        if (activityId != null) 'activityId': activityId,
      };
}
