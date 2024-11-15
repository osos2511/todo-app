import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import 'package:todo_app/presentation/screens/home/update_task/update_task_screen.dart';
class TaskItem extends StatefulWidget {
  Function onDeleteClicked;
  TaskItem({super.key, required this.todo, required this.onDeleteClicked});
  TodoDm todo;


  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).indicatorColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                deleteTaskItem();
               // widget.onDeleteClicked();
              },
              borderRadius: BorderRadius.circular(15),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.push( context,MaterialPageRoute(builder: (context) => UpdateTaskScreen(todoDm: widget.todo,),));
              },
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 3,
                  height: 65,
                  color: Theme.of(context).dividerColor,
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  children: [
                    Text(widget.todo.title,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.todo.description,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const Spacer(),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 35,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTaskItem() async {
    var taskCollection = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.userDm!.id)
        .collection(TodoDm.collectionName);
    await DialogUtils.messagingDialog(context,
        content: 'Are You Sure Delete This?',
        negActionTitle: 'NO',
        posActionTitle: 'YES',
        posAction: ()async{
      widget.onDeleteClicked();
      DialogUtils.messagingDialog(context,
          content: 'Your Todo Is Deleted Successfully', posActionTitle: 'OK');
      await taskCollection.doc(widget.todo.id).delete();
        },
    negAction:(){
    }
    );
  }

}
