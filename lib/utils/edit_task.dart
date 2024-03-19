import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1/homescreen.dart';
import 'package:todo1/model/model.dart';

import '../prvider/listprovider.dart';
import 'app_colors.dart';
import 'package:todo1/prvider/providerhtem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Editetask extends StatefulWidget {
  const Editetask({Key? key}) : super(key: key);
  static const String routeName = "Edittask";


  @override
  State<Editetask> createState() => _EditetaskState();
}

class _EditetaskState extends State<Editetask> {
  late Todo todo;
  DateTime selcetddate = DateTime.now();
  String titel = "";
  String descraption = "";
  late Listprovider provider;
  late Themprovider themprovider;
  var fromkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    themprovider = Provider.of(context);
    provider=  Provider.of(context);
    return Scaffold(
      backgroundColor: themprovider.colorbottomsheet(),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.todolist,
          style: themprovider.style(),
        ),
        toolbarHeight: 140,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(13.0),
              child: Text(
                AppLocalizations.of(context)!.todolist,
                textAlign: TextAlign.center,
                style: themprovider.stylebottomsheet(),
              ),
            ),
            Form(
              key: fromkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      style: TextStyle(color: themprovider.colorunselectclaender()),
                      onChanged: (text) {
                        titel = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseenterhetitle;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.enteryourtitel,
                        labelStyle: themprovider.stylebottomsheet(),
                        // Change the color of the underline here
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: app_colors.grycolor, // Change this color
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: app_colors.grycolor, // Change this color
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      style: TextStyle(color: themprovider.colorunselectclaender()),
                      onChanged: (text) {
                        descraption = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseenterthetask;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.descraption,
                        labelStyle: themprovider.stylebottomsheet(),
                        // Change the color of the underline here
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue, // Change this color
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: app_colors.grycolor, // Change this color
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      AppLocalizations.of(context)!.slelectdata,
                      textAlign: TextAlign.left,
                      style: themprovider.stylebottomsheet(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: InkWell(
                      onTap: () {
                        showMyDatePicker();
                        setState(() {});
                      },
                      child: Text(
                        "${selcetddate.day}/${selcetddate.month}/${selcetddate.year}",
                        textAlign: TextAlign.center,
                        style: themprovider.stylebottomsheet(),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      if (!fromkey.currentState!.validate()) return;
                      provider.updateTodo(Todo(
                        id: todo.id,
                        titel: titel,
                        descraption: descraption,
                        isDone: todo.isDone,
                        data: selcetddate,
                      ));
                      Navigator.pop(context); // Close the edit screen after updating todo
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: app_colors.primarycolor,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.savechange,
                      style: const TextStyle(color: Color(0xFFA8B8DF)),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showMyDatePicker() async {
    selcetddate = await showDatePicker(
        context: context,
        initialDate: selcetddate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selcetddate;
    setState(() {});
  }
}

