import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/reusable_components/task_item.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';

import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../database_manager/model/todo_dm.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  List<TodoDm> todosList = [];
  DateTime calenderSelectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTodosFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            calenderSelectedDate = selectedDate;
            readTodosFromFireStore();
          },
          headerProps: EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            monthStyle: TextStyle(color: Theme.of(context).canvasColor),
            selectedDateStyle: TextStyle(color: Theme.of(context).canvasColor),
            dateFormatter: const DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              dayNumStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.blueColor),
              dayStrStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.blueColor),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: ColorsManager.whiteColor,
                  ),
            ),
            inactiveDayStyle: DayStyle(
              dayNumStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              dayStrStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: ColorsManager.whiteColor),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 70,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => TaskItem(todo: todosList[index],
              onDeleteClicked: (){
              readTodosFromFireStore();
            },),
            itemCount: todosList.length,
          ),
        ),
      ],
    );
  }

  void readTodosFromFireStore() async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.userDm!.id)
        .collection(TodoDm.collectionName);
    QuerySnapshot querySnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todosList = documents.map(
      (docSnapShot) {
        Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
        TodoDm todo = TodoDm.fromJson(json);
        return todo;
      },
    ).toList();
    todosList = todosList
        .where((todo) =>
            todo.date.day == calenderSelectedDate.day &&
            todo.date.month == calenderSelectedDate.month &&
            todo.date.year == calenderSelectedDate.year)
        .toList();
    setState(() {});
  }
}
