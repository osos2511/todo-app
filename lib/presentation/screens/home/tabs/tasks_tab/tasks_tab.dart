import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/reusable_components/task_item.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import '../../../../../database_manager/model/todo_dm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate =
  DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);
  DateFormat dateFormat = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            setState(() {
              calenderSelectedDate = selectedDate;
            });
          },
          headerProps: EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            monthStyle: TextStyle(color: Theme
                .of(context)
                .canvasColor),
            selectedDateStyle: TextStyle(color: Theme
                .of(context)
                .canvasColor),
            dateFormatter: const DateFormatter.fullDateDMY(),
          ),
          dayProps: createDayProps(),
        ),
        const SizedBox(height: 10),
        StreamBuilder<List<TodoDm>?>(
          stream: readTodosFromFireStore(calenderSelectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Error loading tasks');
            } else {
              final data = snapshot.data;
              if (data == null || data.isEmpty) {
                return Text(AppLocalizations.of(context)!.noTasks,
                  style: TextStyle(color: Theme
                      .of(context)
                      .canvasColor),);
              }
              return Expanded(
                flex: 70,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      TaskItem(
                        todo: data[index],
                        onDeleteClicked: () {
                          // Refresh or additional logic on delete
                        },
                      ),
                  itemCount: data.length,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  EasyDayProps createDayProps() =>
      const EasyDayProps(
        dayStructure: DayStructure.dayStrDayNum,
        activeDayStyle: DayStyle(
          dayNumStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorsManager.black),
          dayStrStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: ColorsManager.black),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(colors: [Color(0xff3371FF),
            Color(0xff8426D6)]),
          ),
        ),
        inactiveDayStyle: DayStyle(
          dayNumStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          dayStrStyle: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: ColorsManager.whiteColor,
          ),
        ),
      );

  Stream<List<TodoDm>> readTodosFromFireStore(DateTime selectedDate) async* {
    final CollectionReference<TodoDm> todoCollection =
    FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.userDm?.id) // ensure userDm is not null
        .collection(TodoDm.collectionName)
        .withConverter<TodoDm>(
      fromFirestore: (snapshot, _) =>
          TodoDm.fromJson(snapshot.data() ?? {}),
      toFirestore: (value, _) => value.toJson(),
    );

    final Stream<QuerySnapshot<TodoDm>> querySnapshot = todoCollection
        .where('date', isEqualTo: Timestamp.fromDate(selectedDate))
        .snapshots();

    yield* querySnapshot
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }


  Widget buildCalender() {
    return EasyInfiniteDateTimeLine(
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      focusDate: calenderSelectedDate,
      onDateChange: (selectedDate) {
        //`selectedDate` the new date selected.
      },

      itemBuilder: (context, date, isSelected, onTap) =>
          InkWell(
            onTap: () {
              calenderSelectedDate = date;
              readTodosFromFireStore(calenderSelectedDate); //it gets tasks based on calender selected date.
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Theme
                  .of(context)
                  .colorScheme
                  .onPrimary,
              elevation: 12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.dateFormatted(),
                    style: TextStyle(
                        color: isSelected
                            ? ColorsManager.blueColor
                            : Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                        color: isSelected
                            ? ColorsManager.blueColor
                            : Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

