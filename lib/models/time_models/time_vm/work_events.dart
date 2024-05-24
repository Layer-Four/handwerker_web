// import 'package:calendar_view/calendar_view.dart';
// import 'package:flutter/material.dart';

// import 'time_vm.dart';

// class WorkEvents extends CalendarEventData {
//   // final Color _color;
//   // final DateTime _date;
//   // final String? _description;
//   // final TextStyle? _descriptionStyle;
//   // final int? _duration;
//   // final DateTime _endTime;
//   // final TimeVMAdapter? _event;
//   // final DateTime _startTime;
//   // final String _title;
//   // final String? _headline6;
//   // final TextStyle? _titleStyle;
//   final Color? color;

//   WorkEvents({
//     this.color,
//     required super.date,
//     String? description,
//     TextStyle? descriptionStyle,
//     int? duration,
//     required DateTime endDate,
//     TimeVMAdapter? event,
//     required DateTime startTime,
//     required super.title,
//     TextStyle? titleStyle,
//     String? headLine6,
//   }) {
//     color = color ?? Colors.blue;
//     date = date;
//     endTime = endDate;
//     headline6 = headline6;
//   }
//   // : _color = color ?? Colors.blue,
//   //       _date = date,
//   //       _description = description,
//   //       _descriptionStyle = descriptionStyle,
//   //       _endTime = endDate,
//   //       _event = event,
//   //       _startTime = startTime,
//   //       _title = title,
//   //       _duration = duration,
//   //       _headline6 = headLine6,
//   //       _titleStyle = titleStyle;

//   factory WorkEvents.fromTimeEntry(TimeVMAdapter e, {Color? color}) => WorkEvents(
//         color: color ?? Colors.blue,
//         date: e.date,
//         duration: e.duration,
//         description: e.description,
//         endDate: e.endTime,
//         event: e,
//         startTime: e.startTime,
//         title: e.customerName ?? '${e.projectTitle}/${e.serviceTitle}',
//       );
//   int? get duration => _duration;
//   @override
//   DateTime get date => _date;

//   @override
//   Color get color => _color;

//   get headline6 => headline6;

//   @override
//   CalendarEventData<Object?> copyWith({
//     Color? color,
//     DateTime? date,
//     String? description,
//     TextStyle? descriptionStyle,
//     DateTime? endDate,
//     DateTime? endTime,
//     T? event,
//     String? headline6,
//     DateTime? startTime,
//     String? title,
//     TextStyle? titleStyle,
//   }) =>
//       WorkEvents(
//         color: color ?? this.color,
//         date: date ?? this.date,
//         description: description ?? this.description,
//         descriptionStyle: descriptionStyle ?? this.descriptionStyle,
//         endDate: endTime ?? endDate ?? this.endTime,
//         event: event  ?? this.event,
//         headLine6: headline6 ?? this.headline6,
//         startTime: startTime ?? this.startTime!,
//         title: title ?? this.title,
//         titleStyle: titleStyle ?? this.titleStyle,
//       );

//   @override
//   bool get isFullDayEvent =>
//       startTime != null &&
//       ((endDate.millisecondsSinceEpoch - startTime!.millisecondsSinceEpoch) / 60000 >= 1440);

//   @override
//   bool get isRangingEvent {
//     final diff = endDate.withoutTime.difference(date.withoutTime).inDays;

//     return diff > 0 && !isFullDayEvent;
//   }

//   @override
//   bool occursOnDate(DateTime currentDate) =>
//       currentDate == date ||
//       currentDate == endDate ||
//       (currentDate.isBefore(endDate.withoutTime) && currentDate.isAfter(date.withoutTime));

//   @override
//   Map<String, dynamic> toJson() => {
//         'color': color.toString(),
//         'date': date.toIso8601String(),
//         'description': description,
//         'duration': duration,
//         'endTime': endDate.toIso8601String(),
//         'startTime': startTime?.toIso8601String(),
//         'title': title,
//       };
// }
