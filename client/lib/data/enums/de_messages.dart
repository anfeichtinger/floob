import 'package:timeago/timeago.dart';

class DeMessages implements LookupMessages {
  @override
  String prefixAgo() => 'Vor';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'gerade eben';
  @override
  String aboutAMinute(int minutes) => 'ungefähr eine Minute';
  @override
  String minutes(int minutes) => '$minutes Minuten';
  @override
  String aboutAnHour(int hours) => 'ungefähr eine Stunde';
  @override
  String hours(int hours) => '$hours Stunden';
  @override
  String aDay(int hours) => 'ein Tag';
  @override
  String days(int days) => '$days Tagen';
  @override
  String aboutAMonth(int days) => 'ungefähr einen Monat';
  @override
  String months(int months) => '$months Monaten';
  @override
  String aboutAYear(int year) => 'ungefähr ein Jahr';
  @override
  String years(int years) => '$years Jahren';
  @override
  String wordSeparator() => ' ';
}
