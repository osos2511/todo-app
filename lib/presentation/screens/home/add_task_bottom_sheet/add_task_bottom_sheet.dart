import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key,this.todoDm});
  TodoDm? todoDm;
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
  DateTime userSelectedDate =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateFormat dateFormat = DateFormat('yyyy/MM/dd');

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
              AppLocalizations.of(context)!.add_new_task,
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
                  hintText:AppLocalizations.of(context)!.add_title,
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
                hintText: AppLocalizations.of(context)!.add_description,
                hintStyle: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              AppLocalizations.of(context)!.select_date,              style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
              child:  Text(AppLocalizations.of(context)!.add_task_button,),
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

    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.userDm!.id)
        .collection(TodoDm.collectionName);
    DocumentReference doc = todoCollection.doc();
    TodoDm todo = TodoDm(
      id: doc.id,
      title: titleController.text,
      description: descriptionController.text,
      date: userSelectedDate,
      isDone: false,
    );
    doc
        .set(todo.toJson())
        .then(
          (value) {
            Navigator.pop(context);
          },
        );
  }
}
