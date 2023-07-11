import 'package:flutter/material.dart';
import 'package:listadetarefas/models/ToDo.dart';
import 'package:listadetarefas/repositories/todo_repositorie.dart';
import 'package:listadetarefas/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<ToDo> tasks = [];
  ToDo? deletedTodo;
  int? deletedTodoPos;
  String? errorText;

  @override
  void initState() {
    super.initState();

    todoRepositorie.getTodoList().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  final TextEditingController controllerTask = TextEditingController();
  final TodoRepositorie todoRepositorie = TodoRepositorie();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: controllerTask,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Arrumar a garagem',
                          errorText: errorText,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ToDo newDoto = ToDo(
                          title: controllerTask.text,
                          date: DateTime.now(),
                        );

                        if (newDoto.title.isEmpty) {
                          setState(() {
                            errorText = 'Campo não pode ser vazio';
                          });
                          return;
                        }

                        setState(() {
                          tasks.add(newDoto);
                          errorText = null;
                        });
                        controllerTask.clear();
                        todoRepositorie.saveTodoList(tasks);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (ToDo task in tasks)
                        ToDoListItem(
                          todo: task,
                          onDelete: onDelete,
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child:
                          Text('Você possui ${tasks.length} tarefas pendentes'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: showDeleteAllConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Text('Limpar tudo.'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(ToDo todo) {
    deletedTodo = todo;
    deletedTodoPos = tasks.indexOf(todo);

    setState(() {
      tasks.remove(todo);
    });
    todoRepositorie.saveTodoList(tasks);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso!',
          style:
              const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
        ),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              tasks.insert(deletedTodoPos!, deletedTodo!);
            });
            todoRepositorie.saveTodoList(tasks);
          },
        ),
      ),
    );
  }

  void showDeleteAllConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar Tudo?'),
        content: const Text('Você tem, certeza que quer limpar tudo?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTasks();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'Limpar Tudo',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteAllTasks() {
    setState(() {
      tasks.clear();
    });
    todoRepositorie.saveTodoList(tasks);
  }
}
