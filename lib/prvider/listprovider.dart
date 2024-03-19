import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo1/model/my-user.dart';

import '../model/model.dart';

class Listprovider extends ChangeNotifier {
  List<Todo> todos = [];
  DateTime selecteddate = DateTime.now();

  void onchangedate(DateTime newdate) {
    selecteddate = newdate;
    gettaskinfiarbase();
    notifyListeners();
  }

  void gettaskinfiarbase() async {
    todos.clear();
    CollectionReference todocollection =
        FirebaseFirestore.instance.collection("todo");
    QuerySnapshot querySnapshot = await todocollection.get();
    var documents = querySnapshot.docs;
    for (var doc in documents) {
      Map jeson = doc.data() as Map;
      Timestamp data = jeson["data"];

      Todo todo = Todo(
          id: jeson["id"],
          titel: jeson["titel"],
          descraption: jeson["descrption"],
          isDone: jeson["isDone"],
          data: data.toDate());
      if(selecteddate.year==todo.data.year&&selecteddate.month==todo.data.month&&selecteddate.day==todo.data.day){
        todos.add(todo);
      }

    }
    notifyListeners();
  }
  Future<void> deleteTodo(Todo todo) async {
    todos.clear();
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("todo");
    DocumentReference todoDoc = collectionReference.doc(todo.id);
    await todoDoc.delete();
    todos.remove(todo);
    notifyListeners();
  }

  Future<void> updateTodo(Todo todo) async {
    todos.clear();
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("todo");
    DocumentReference todoDoc = collectionReference.doc(todo.id);
    await todoDoc.update({
      "title": todo.titel,
      "description": todo.descraption,
      "isDone": todo.isDone,
      "data": todo.data,
    });
    // Assuming you have already updated the local todos list elsewhere if needed.
    notifyListeners();
  }
}