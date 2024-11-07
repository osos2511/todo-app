import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';

class UpdateTaskBottomSheet extends StatefulWidget {
  UpdateTaskBottomSheet({super.key, this.todoDm});
  TodoDm? todoDm;
  @override
  State<UpdateTaskBottomSheet> createState() => _UpdateTaskBottomSheetState();
}

class _UpdateTaskBottomSheetState extends State<UpdateTaskBottomSheet> {
  DateTime userSelectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> updateTodo = FirebaseFirestore.instance.collection(TodoDm.collectionName).snapshots();
  @override
  Widget build(BuildContext context) {
    titleController.text = widget.todoDm!.title;
    descriptionController.text = widget.todoDm!.description;

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
              'Update Task',
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
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  setState(() {
                    updateToDoToFireStore();
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.blueColor),
              child: const Text('Update Task'),
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

  void updateToDoToFireStore() async {
    var taskCollection = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.userDm!.id)
        .collection(TodoDm.collectionName);
    DocumentReference doc = taskCollection.doc(widget.todoDm!.id);
    TodoDm updateTask = widget.todoDm!.copyWith(
      id: widget.todoDm!.id,
      updatedName: titleController.text,
      updatedDetails: descriptionController.text,
      date: widget.todoDm!.date,
      isDone: widget.todoDm!.isDone,
    );
    await doc.update(updateTask.toJson()).then(
      (value) {
        Navigator.pop(context);
      },
    );
    DialogUtils.messagingDialog(context,
        content: 'Task is update Successfully');
    DialogUtils.hideDialog(context);
    setState(() {});
  }
}
