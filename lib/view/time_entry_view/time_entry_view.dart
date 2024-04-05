import 'package:flutter/material.dart';

import '../shared_view_widgets/search_line_header.dart';
import 'time_entry_widgets/custom_calendar.dart';
import 'time_entry_widgets/time_entry_dialog.dart';

class TimeEntryBody extends StatelessWidget {
  const TimeEntryBody({super.key});

  @override
  Widget build(BuildContext context) => Container(
        // color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SearchLineHeader(),
            Stack(
              children: [
                const CustomCalendar(),
                _addNewAppointment(context),
              ],
            ),
          ],
        ),
      );

  Widget _addNewAppointment(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Positioned(
      right: width / 20.0,
      top: 15,
      child: InkWell(
        onTap: () {
          showDialog(
              // barrierColor: Colors.transparent,
              context: context,
              builder: (context) => Dialog(
                    elevation: 5,
                    // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      height: MediaQuery.of(context).size.height - 200,
                      width: 500,
                      child: const TimeEntryDialog(),
                    ),
                  ));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            alignment: Alignment.center,
            color: Colors.orange,
            height: 30,
            width: 150,
            child: const Text('+ Neuer Termin'),
          ),
        ),
      ),
    );
  }
}
