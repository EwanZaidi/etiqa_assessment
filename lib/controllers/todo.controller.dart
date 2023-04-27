import 'package:get/get.dart';
import 'package:todo_list/models/todo.model.dart';

class TodoController extends GetxController {
  RxList<Todo> todoList = <Todo>[].obs;

  TodoController();

  addItemInList(Todo todo) async {
    todoList.add(todo);
    todoList.refresh();
  }
}
