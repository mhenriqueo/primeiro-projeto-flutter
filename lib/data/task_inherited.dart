import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/taskDash.png', 4),
    Task('Aprender Inglês', 'assets/images/taskEnglish.png', 5),
    Task('Andar de Bike', 'assets/images/taskBike.jpg', 1),
    Task('Andar de Skate', 'assets/images/taskSkate.jpg', 3),
    Task('Jogar Videogame', 'assets/images/taskGame.avif', 2),
  ];
  
  void newTask(String name, String photo, int difficulty){
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
