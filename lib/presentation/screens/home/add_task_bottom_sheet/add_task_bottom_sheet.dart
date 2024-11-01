import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static Future show(BuildContext context) {
   return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AddTaskBottomSheet(),
      ),
    );
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime userSelectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).indicatorColor,
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(14),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextFormField(
              controller: titleController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'plz, enter your title';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Enter your task',
                  hintStyle: Theme.of(context).textTheme.displayMedium),
            ),
            TextFormField(
              controller: descriptionController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'plz, enter your description';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Description',
                hintStyle: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Select Date',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).canvasColor,
                  ),
            ),
            InkWell(
                onTap: () {
                  showTaskDatePicker();
                },
                child: Text(
                  userSelectedDate.dateFormatted(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                )),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                addToDoToFireStore();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.blueColor),
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  void showTaskDatePicker() async {
    userSelectedDate = await showDatePicker(
          //selectableDayPredicate: (day)=>day.day!=20,=>this day is holiday
          //barrierDismissible: false,
          context: context,

          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        ) ??
        userSelectedDate;
    setState(() {});
  }

  void addToDoToFireStore() {
    if (formKey.currentState?.validate() == false) return;

    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(TodoDm.collectionName);
    DocumentReference doc = todoCollection.doc();

    TodoDm todo = TodoDm(
      id: doc.id,
      title: titleController.text,
      description: descriptionController.text,
      date: userSelectedDate,
      isDone: false,
    );

    // add data to fireStore
    doc.set(todo.toJson())
        .then(
          (_) {},
        )
        .timeout(const Duration(milliseconds: 500), onTimeout: () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }
}
