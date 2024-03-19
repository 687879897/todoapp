import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1/list_screen.dart';

import 'package:todo1/prvider/listprovider.dart';

import 'package:todo1/setting_screen.dart';
import 'package:todo1/utils/app_colors.dart';
import 'package:todo1/prvider/providerhtem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int Currentindex = 0;
  DateTime selcetddate = DateTime.now();
  var fromkey = GlobalKey<FormState>();
  String titel = "";
  String descraption = "";
  late Listprovider provider;
  late Themprovider themprovider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    themprovider = Provider.of(context);
    return Scaffold(
      backgroundColor: themprovider.colorscreen(),
      appBar: AppBar(
        elevation: 0,
        title:  Text("Welcome back ",style: themprovider.style(),),
        // toolbarHeight: 140,
        backgroundColor: app_colors.primarycolor,
      ),
      body: (Currentindex == 0) ? Listscreen() : const Settingscreen(),
      bottomNavigationBar: Theme(
        data: ThemeData(
          // Set the background color here
          bottomAppBarTheme: BottomAppBarTheme(
            color: themprovider.colorbottomsheet(), // Change this color to your desired color
          ),
        ),
        child: BottomAppBar(
          notchMargin: 6.0,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ],
            currentIndex: Currentindex,
            selectedItemColor: app_colors.primarycolor,
            unselectedItemColor: themprovider.colorunselect(),
            onTap: (index) {
              Currentindex = index;
              setState(() {});
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viwebottomsheet();
        },
        backgroundColor: app_colors.primarycolor, // Change the color here
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            side: BorderSide(width: 4, color: app_colors.white)
        ),
        child: const Icon(Icons.add, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void viwebottomsheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        side: BorderSide(width: 6),
      ),
      context: context,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          color: themprovider.colorbottomsheet(), // Change the color of the bottom sheet

          child: SingleChildScrollView(
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
                                color: app_colors.grycolor // Change this color
                              ),
                            ),
                          ),
                        ),
                      ),
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
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Addtask();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: app_colors.primarycolor,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.add,
                            style: const TextStyle(color: Color(0xFFA8B8DF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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

  void Addtask() async {
    if(!fromkey.currentState!.validate())return;
    {
      CollectionReference todocollection =
          FirebaseFirestore.instance.collection("todo");
      var docs = todocollection.doc();
      docs.set({
        "id": docs.id,
        "titel": titel,
        "descrption": descraption,
        "isDone": false,
        "data": selcetddate,
      }).timeout(const Duration(milliseconds: 300), onTimeout: () {
        provider.gettaskinfiarbase();
        Navigator.pop(context);
      });
    }
  }
}
