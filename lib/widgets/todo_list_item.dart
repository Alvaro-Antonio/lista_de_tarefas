import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:listadetarefas/models/ToDo.dart';

class ToDoListItem extends StatelessWidget {
  const ToDoListItem({
    super.key,
    required this.todo,
    required this.onDelete,
  });

  final ToDo todo;
  final Function(ToDo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(), //estilo da motion
          extentRatio: 0.3, //limita o tamanho da caixa do "deletar"
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(
                  5), //deixa o "deletar" com bordas redondas
              onPressed: (context) {
                onDelete(todo);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
            ),
            // SlidableAction(
            //   borderRadius: BorderRadius.circular(
            //       5), //deixa o "deletar" com bordas redondas
            //   onPressed: null,
            //   backgroundColor: Colors.green,
            //   foregroundColor: Colors.white,
            //   icon: Icons.edit,
            //   label: 'Editar',
            // ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MM/yyyy HH:mm').format(todo.date),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
