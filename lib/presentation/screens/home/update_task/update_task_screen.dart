import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import '../../../../core/colors_manager.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../database_manager/model/todo_dm.dart';
import '../../../../database_manager/model/user_dm.dart';

class UpdateTaskScreen extends StatefulWidget {
  UpdateTaskScreen({super.key, this.todoDm});
  TodoDm? todoDm;
  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}
class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  DateTime userSelectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todoDm != null) {
      titleController.text = widget.todoDm!.title;
      descriptionController.text = widget.todoDm!.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 300,
              height: 600,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                
              ),
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
                    Text(
                      'Select Date',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
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
                        if (formKey.currentState?.validate() == true) {
                          setState(() {
                            updateToDoToFireStore();
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.blueColor),
                      child: const Text('Update Task'),
                    ),
                  ],
                ),
              ),
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
      date: userSelectedDate,
      isDone: widget.todoDm!.isDone,
    );
    await doc.update(updateTask.toJson()).then(
          (value) {},
        );
    DialogUtils.messagingDialog(context,
        content: 'Task is update Successfully');
    DialogUtils.hideDialog(context);
    setState(() {});
  }
}
