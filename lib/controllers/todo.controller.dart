import 'package:get/get.dart';
import 'package:todo_list/models/todo.model.dart';

class TodoController extends GetxController {
  RxList<Todo> todoList = <Todo>[].obs;

  TodoController();

  bool addItemInList(Todo todo) {
    try {
      todoList.add(todo);
      todoList.refresh();
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  bool updateItemInList(Todo todo) {
    try {
      int index = todoList.indexWhere((element) => element.id == todo.id);
      todoList[index] = todo;
      todoList.refresh();
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
