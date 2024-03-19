import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1/model/model.dart';
import 'package:todo1/prvider/listprovider.dart';
import 'package:todo1/prvider/providerhtem.dart';
import 'package:todo1/todotask.dart';
import 'package:todo1/utils/app_colors.dart';


class Listscreen extends StatefulWidget{

  const Listscreen({super.key});
  static const String routeName = "List";

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  late Listprovider provider;
  late Themprovider themprovider;



  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.gettaskinfiarbase();

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    provider=Provider.of(context);
    themprovider=Provider.of(context);
    return Column(
      children: [
        buildEasyInfiniteDateTimeLine(),
        Expanded(child: ListView.builder(
          itemCount: provider.todos.length,
          itemBuilder: (context, index) {
            return Todowidget(todo:provider.todos[index]);
          },
        )
        )
      ],
    );




  }

  Widget buildEasyInfiniteDateTimeLine() {
    return
      Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(child: Container(color: app_colors.primarycolor,)),
                Spacer(),
              ],
            ),
          ),
          EasyInfiniteDateTimeLine(

            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            focusDate: provider.selecteddate,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateChange: (selectedDate) {
              provider.onchangedate(selectedDate);
            },
            dayProps: EasyDayProps(height: 80,width: 60),
            itemBuilder:(context, dayNumber, dayName, monthName,  fullDate,isSelected){
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:themprovider.colorbottomsheet()
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Text(dayName,style: TextStyle(color: isSelected ? app_colors.primarycolor:themprovider.colorunselectclaender()),),
                    Spacer(),
                    Text(dayNumber,style: TextStyle(color: isSelected ? app_colors.primarycolor:themprovider.colorunselectclaender())),
                    Spacer(),
                  ],
                ),
              );
            },
          ),
        ],
      );
  }



}
