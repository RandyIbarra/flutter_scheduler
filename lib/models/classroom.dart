final Set<ActivitySchedule> activityScheduleSet = <ActivitySchedule>{
  // '08:00-09:20'
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Monday',
    activitySchedule: '08:00-09:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Tuesday',
    activitySchedule: '08:00-09:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Wednesday',
    activitySchedule: '08:00-09:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Thursday',
    activitySchedule: '08:00-09:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Friday',
    activitySchedule: '08:00-09:20',
  ),
  // '09:30-10:50'
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Monday',
    activitySchedule: '09:30-10:50',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Tuesday',
    activitySchedule: '09:30-10:50',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Wednesday',
    activitySchedule: '09:30-10:50',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Thursday',
    activitySchedule: '09:30-10:50',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Friday',
    activitySchedule: '09:30-10:50',
  ),
  // '11:00-12:20'
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Monday',
    activitySchedule: '11:00-12:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Tuesday',
    activitySchedule: '11:00-12:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Wednesday',
    activitySchedule: '11:00-12:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Thursday',
    activitySchedule: '11:00-12:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Friday',
    activitySchedule: '11:00-12:20',
  ),
  // '12:30-13:50'
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Monday',
    activitySchedule: '12:30-13:50',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Tuesday',
    activitySchedule: '12:30-13:50',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Wednesday',
    activitySchedule: '12:30-13:50',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Thursday',
    activitySchedule: '12:30-13:50',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Friday',
    activitySchedule: '12:30-13:50',
  ),
  // '15:00-16:20'
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Monday',
    activitySchedule: '15:00-16:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Tuesday',
    activitySchedule: '15:00-16:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Wednesday',
    activitySchedule: '15:00-16:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Thursday',
    activitySchedule: '15:00-16:20',
  ),
  ActivitySchedule(
    activity: Activity(),
    classroomId: 'SEMINARIOS',
    activityDay: 'Friday',
    activitySchedule: '15:00-16:20',
  ),
};

class Classroom {
  /// Classroom name
  String id;

  /// List of activity schedules
  Set<ActivitySchedule> activityScheduleSet;

  Classroom({
    required this.id,
    required this.activityScheduleSet,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'activityScheduleSet': [
          for (var activitySchedule in activityScheduleSet)
            activitySchedule.toMap(),
        ],
      };

  Classroom.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        activityScheduleSet =
            List<Map<String, dynamic>>.from(map['activityScheduleSet'])
                .map(
                  (e) => ActivitySchedule.fromMap(e),
                )
                .toSet();

  List<ActivitySchedule> getActivityScheduleListFromDay(String day) {
    final scheduleList = List<ActivitySchedule>.empty(growable: true);
    for (ActivitySchedule activitySchedule in activityScheduleSet) {
      if (activitySchedule.activityDay == day) {
        scheduleList.add(activitySchedule);
      }
    }
    return scheduleList;
  }

  List<ActivitySchedule> getActivityScheduleListFromSchedule(String schedule) {
    final dayList = List<ActivitySchedule>.empty(growable: true);
    for (ActivitySchedule activitySchedule in activityScheduleSet) {
      if (activitySchedule.activitySchedule == schedule) {
        dayList.add(activitySchedule);
      }
    }
    return dayList;
  }

  List<String> getActivityDays() {
    final activityDaysList = List<String>.empty(growable: true);
    for (ActivitySchedule activitySchedule in activityScheduleSet) {
      if (activityDaysList.contains(activitySchedule.activityDay)) continue;
      activityDaysList.add(activitySchedule.activityDay);
    }
    return activityDaysList;
  }

  List<String> getActivitySchedules() {
    final activitySchedulesList = List<String>.empty(growable: true);
    for (ActivitySchedule activitySchedule in activityScheduleSet) {
      if (activitySchedulesList.contains(activitySchedule.activitySchedule)) {
        continue;
      }
      activitySchedulesList.add(activitySchedule.activitySchedule);
    }
    return activitySchedulesList;
  }
}

class ActivitySchedule {
  /// Id of assigned classroom for this activity
  String classroomId;

  /// Activity day for this activity
  String activityDay;

  /// Activity schedule for this activity
  String activitySchedule;

  /// Assigned activity for this schedule
  Activity? activity;

  ActivitySchedule({
    this.activity,
    required this.classroomId,
    required this.activityDay,
    required this.activitySchedule,
  });

  ActivitySchedule.fromMap(Map<String, dynamic> map)
      : activity = map['activity'] != null
            ? Activity.fromMap(Map<String, dynamic>.from(map['activity']))
            : null,
        classroomId = map['classroomId'] as String,
        activityDay = map['activityDay'] as String,
        activitySchedule = map['activitySchedule'] as String;

  Map<String, dynamic> toMap() => {
        'classroomId': classroomId,
        'activityDay': activityDay,
        'activitySchedule': activitySchedule,
        if (activity != null) 'activity': activity!.toMap(),
      };
}

/// Activity class
class Activity {
  /// Activity id
  String id;

  /// Activity name
  String name;

  /// Person in charge
  String personInCharge;

  Activity({
    this.id = 'id',
    this.name = 'Not Assigned yet',
    this.personInCharge = 'person',
  });

  Activity.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        name = map['name'] as String,
        personInCharge = map['personInCharge'] as String;

  Map<String, dynamic>? toMap() => name != 'Not Assigned yet'
      ? {
          'id': id,
          'name': name,
          'personInCharge': personInCharge,
        }
      : null;
}
