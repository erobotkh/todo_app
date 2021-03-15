import 'package:todo_app/examples/examples.dart';

void main() {
  globalToDoList.forEach((e) {
    final String name = e.name;
    final String note = e.note;

    final int prioritized = e.prioritized == true ? 1 : 0;
    final int completed = e.completed == true ? 1 : 0;

    final int reminder =
        e.reminder != null ? e.reminder.millisecondsSinceEpoch : null;

    final int createdOn =
        e.createdOn != null ? e.createdOn.millisecondsSinceEpoch : null;

    final int updatedOn =
        e.updatedOn != null ? e.updatedOn.millisecondsSinceEpoch : null;

    final int deadline =
        e.deadline != null ? e.deadline.millisecondsSinceEpoch : null;

    final int id = e.id;

    print('''
    INSERT INTO "todo" VALUES ($prioritized,"$name",$completed,$reminder,"$note",$createdOn,$updatedOn,$id,$deadline);
    ''');
  });
}
