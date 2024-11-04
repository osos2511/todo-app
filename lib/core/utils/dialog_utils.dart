import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoadingDialog(context, {bool isDismissible = false,String? message}){
     showDialog(
       barrierDismissible: isDismissible,
         context: context,
         builder: (context) {
       return CupertinoAlertDialog(
         content: Row(
           children: [
             Text(message??''),
             const Spacer(),
             const CircularProgressIndicator(),
           ],
         ),
       );
     });
  }
static  hideDialog(context){
    Navigator.pop(context);
}
static Future<bool?> messagingDialog(context,
    {
      String? title, String? content,
      String?posActionTitle, String?negActionTitle,
      Function?posAction, Function?negAction}){

    return showDialog(context: context, builder: (context) => CupertinoAlertDialog(
      title:title!=null?Text(title):null,
      content: content!=null?Text(content):null,
      actions: [
        if(posActionTitle!=null)
          TextButton(onPressed: (){
            Navigator.pop(context);
            posAction?.call();//is null,not call
          }, child: Text(posActionTitle)),
        if(negActionTitle!=null)
          TextButton(onPressed: (){
            Navigator.pop(context);
           negAction?.call();//is null,not call
          }, child: Text(negActionTitle))
      ],
    ),);

}
}