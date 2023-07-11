import 'dart:convert';
import 'dart:ffi';

import 'package:listadetarefas/models/ToDo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const todoListkey = 'list_todo';

class TodoRepositorie {
  TodoRepositorie() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  late SharedPreferences sharedPreferences;

  Future<List<ToDo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListkey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => ToDo.fromJson(e)).toList();
  }

  void saveTodoList(List<ToDo> todoList) {
    String jsonTodoList = json.encode(todoList);
    sharedPreferences.setString(todoListkey, jsonTodoList);
  }
}
