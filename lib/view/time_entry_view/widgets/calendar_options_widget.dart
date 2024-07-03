import 'package:flutter/material.dart';

import '../../../constants/themes/app_color.dart';
import '../../shared_widgets/symetric_button_widget.dart';
import 'time_entry_dialog.dart';

class CalendarOptionsRow extends StatelessWidget {
  final bool? isWorkOrder;
  final bool isWeekViewChoosed;
  final Function()? onTapDayView;
  final Function()? onTapWeekViewView;
  final void Function()? onTapTimeEntry;
  final void Function()? onTapWorkOrder;

  const CalendarOptionsRow({
    super.key,
    required this.isWorkOrder,
    required this.isWeekViewChoosed,
    this.onTapWorkOrder,
    this.onTapDayView,
    this.onTapTimeEntry,
    this.onTapWeekViewView,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: isWorkOrder == null || !isWorkOrder!
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColor.kPrimaryButtonColor, width: 1.5),
                      ),
                height: 30,
                child: SymmetricButton(
                  elevation: isWorkOrder == null || !isWorkOrder! ? 5 : 2,
                  text: 'Planung',
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  textStyle: isWorkOrder == null || !isWorkOrder!
                      ? null
                      : const TextStyle(color: Colors.black),
                  color: (isWorkOrder == null || !isWorkOrder!) ? null : AppColor.kWhite,
                  onPressed: onTapWorkOrder,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: isWorkOrder == null || isWorkOrder!
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColor.kPrimaryButtonColor, width: 1.5),
                      ),
                height: 30,
                child: SymmetricButton(
                  text: 'Zeiteintrag',
                  elevation: isWorkOrder == null || !isWorkOrder! ? 5 : 2,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  textStyle: isWorkOrder == null || isWorkOrder!
                      ? null
                      : const TextStyle(color: Colors.black),
                  color: (isWorkOrder == null || isWorkOrder!) ? null : AppColor.kWhite,
                  onPressed: onTapTimeEntry,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: isWeekViewChoosed
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColor.kPrimaryButtonColor, width: 1.5),
                      ),
                height: 30,
                child: SymmetricButton(
                  text: 'Tag',
                  elevation: isWeekViewChoosed ? 5 : 2,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  onPressed: onTapDayView,
                  textStyle: isWeekViewChoosed ? null : const TextStyle(color: Colors.black),
                  color: isWeekViewChoosed ? null : AppColor.kWhite,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: !isWeekViewChoosed
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColor.kPrimaryButtonColor, width: 1.5),
                      ),
                height: 30,
                child: SymmetricButton(
                  text: 'Woche',
                  elevation: !isWeekViewChoosed ? 5 : 2,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  onPressed: onTapWeekViewView,
                  textStyle: !isWeekViewChoosed ? null : const TextStyle(color: Colors.black),
                  color: !isWeekViewChoosed ? null : AppColor.kWhite,
                ),
              ),
              SizedBox(
                height: 30,
                child: SymmetricButton(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  text: 'Neuer Termin +',
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              height: MediaQuery.of(context).size.height - 200,
                              width: 500,
                              child: const TimeEntryDialog(),
                            ),
                          )),
                ),
              )
            ],
          ),
        ),
      );
}
