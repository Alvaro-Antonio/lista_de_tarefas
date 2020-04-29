import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
    title: "Lista de Tarefas",
    home: _Home(),

  ));
}

class _Home extends StatefulWidget {
  @override
  __HomeState createState() => __HomeState();
}

class __HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<File> _getFile() async{
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/data.json");
}

