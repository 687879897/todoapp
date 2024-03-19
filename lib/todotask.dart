import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo1/prvider/listprovider.dart';
import 'package:todo1/prvider/providerhtem.dart';
import 'package:todo1/utils/app_colors.dart';
import 'package:todo1/utils/edit_task.dart';

import 'model/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Todowidget extends StatefulWidget {
  final Todo todo;

  const Todowidget({Key? key, required this.todo}) : super(key: key);

  @override
  State<Todowidget> createState() => _TodowidgetState();
}

class _TodowidgetState extends State<Todowidget> {
  late Listprovider provider;
  late Themprovider themprovider;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    themprovider = Provider.of(context);
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: .2, // Adjust the action panel width here
      actions: [
        SizedBox(
          height: 82,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)), // Border radius here
            ),
            child: IconSlideAction(
              caption: 'Delete',
              color: app_colors.redcolor,
              icon: Icons.delete,
              onTap: () {
                Provider.of<Listprovider>(context, listen: false).deleteTodo(widget.todo);
                setState(() {});
              },
            ),

          ),
        ),
      ],
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            Editetask.routeName,
            arguments: widget.todo.titel,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 13, bottom: 13, right: 13),
          padding: const EdgeInsets.symmetric(vertical: 0),
          // Adjust vertical padding here
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: themprovider.colorbottomsheet(),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                width: 4,
                height: MediaQuery.of(context).size.height * .08,
                color: isDone ? app_colors.greencolor : app_colors.primarycolor,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.todo.titel,
                      style: TextStyle(
                        color: isDone
                            ? app_colors.greencolor
                            : app_colors.primarycolor,
                      ),
                    ),
                    Text(
                      widget.todo.descraption,
                      style: TextStyle(
                        color: isDone
                            ? app_colors.greencolor
                            : app_colors.primarycolor,
                      ),
                    ),
                  ],
                ),
              ),
              if (isDone)
                const Padding(
                  padding: EdgeInsets.all(13),
                  child: Text(
                    "Done!",
                    style: TextStyle(
                      color: app_colors.greencolor,
                      fontSize: 24,
                    ),
                  ),
                )
              else
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(
                    vertical: .5,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: app_colors.primarycolor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isDone = !isDone;
                      });
                    },
                    icon: Icon(
                      Icons.check,
                      color: isDone ? app_colors.greencolor : app_colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
