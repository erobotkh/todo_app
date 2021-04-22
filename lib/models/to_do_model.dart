import 'dart:convert';

class ToDoModel {
  final int? id; // DateTime.now().millisecondsSinceEpoch
  final bool prioritized;
  final bool completed;
  final String? name;
  final String? note;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final DateTime? reminder;
  final DateTime? deadline;

  ToDoModel({
    this.reminder,
    this.updatedOn,
    this.deadline,
    required this.id,
    required this.name,
    required this.note,
    required this.createdOn,
    this.prioritized = false,
    this.completed = false,
  });

  ToDoModel copyWith({
    int? id,
    bool? prioritized,
    bool? completed,
    String? name,
    String? note,
    DateTime? createdOn,
    DateTime? updatedOn,
    DateTime? deadline,
    DateTime? reminder,
  }) {
    return ToDoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      reminder: reminder ?? this.reminder,
      completed: completed ?? this.completed,
      prioritized: prioritized ?? this.prioritized,
      deadline: deadline ?? this.deadline,
    );
  }

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    final DateTime? updatedOn =
        json.containsKey("updated_on") && json["updated_on"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['updated_on'])
            : null;

    final DateTime createdOn =
        DateTime.fromMillisecondsSinceEpoch(json['created_on']);

    final DateTime? reminder =
        json.containsKey("reminder") && json["reminder"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['reminder'])
            : null;

    final DateTime? deadline =
        json.containsKey("deadline") && json["deadline"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['deadline'])
            : null;

    return ToDoModel(
      id: json['id'],
      name: json['name'],
      note: json['note'],
      createdOn: createdOn,
      updatedOn: updatedOn,
      reminder: reminder,
      prioritized: json['prioritized'] == 1 ? true : false,
      completed: json['completed'] == 1 ? true : false,
      deadline: deadline,
    );
  }

  Map<String, dynamic> toJson() {
    final createdOn = this.createdOn?.millisecondsSinceEpoch ??
        DateTime.now().millisecondsSinceEpoch;

    final updatedOn =
        this.updatedOn != null ? this.updatedOn!.millisecondsSinceEpoch : null;

    final reminder =
        this.reminder != null ? this.reminder!.millisecondsSinceEpoch : null;

    final deadline =
        this.deadline != null ? this.deadline!.millisecondsSinceEpoch : null;

    return {
      "id": this.id,
      "prioritized": this.prioritized == true ? 1 : 0,
      "completed": this.completed == true ? 1 : 0,
      "name": this.name,
      "note": this.note,
      "reminder": reminder,
      "created_on": createdOn,
      "updated_on": updatedOn,
      "deadline": deadline,
    };
  }
}

List<ToDoModel> todoModelFromJson(String str) {
  return List<ToDoModel>.from(
    json.decode(str).map((x) => ToDoModel.fromJson(x)),
  );
}

String todoModelToJson(List<ToDoModel> data) {
  return json.encode(
    List<dynamic>.from(
      data.map(
        (x) => x.toJson(),
      ),
    ),
  );
}
