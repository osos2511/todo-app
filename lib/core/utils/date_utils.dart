// import 'package:intl/intl.dart';

// String dateFormatted(DateTime date){
//   final DateFormat formatter=DateFormat("dd/MM/yyyy");
//   return formatter.format(date);
// }

import 'package:intl/intl.dart';
extension FormatDate on DateTime{
 //String dateFormatted()=>'$day/$month/$year';
  String dateFormatted() => DateFormat('d MMMM y').format(this);
}