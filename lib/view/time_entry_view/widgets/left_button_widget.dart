import 'package:flutter/material.dart';

import '../../../../constants/themes/app_color.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class LeftButtonRow extends StatefulWidget {
  const LeftButtonRow({
    super.key,
  });

  @override
  State<LeftButtonRow> createState() => _LeftButtonRowState();
}

class _LeftButtonRowState extends State<LeftButtonRow> {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width / 3.8,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width / 3.8) - 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        width: 100,
                        height: 30,
                        child: SymmetricButton(
                          text: 'Planung',
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        width: 100,
                        height: 30,
                        child: SymmetricButton(
                          text: 'Zeiteinträge',
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        width: 100,
                        height: 30,
                        child: SymmetricButton(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          text: 'Tag',
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        width: 100,
                        height: 30,
                        child: SymmetricButton(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          text: 'Woche',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_left_outlined,
              size: 45,
              color: AppColor.kPrimaryButtonColor,
            ),
          ],
        ),
      );
}
