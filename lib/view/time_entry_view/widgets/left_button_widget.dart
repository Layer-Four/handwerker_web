import 'package:flutter/material.dart';

import '../../../../constants/themes/app_color.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class LeftButtonRow extends StatefulWidget {
  const LeftButtonRow({super.key});

  @override
  State<LeftButtonRow> createState() => _LeftButtonRowState();
}

class _LeftButtonRowState extends State<LeftButtonRow> {
  final List<String> buttonText = ['Planung', 'Zeiteinträge', 'Tag', 'Woche'];
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.amber,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width / 3.8) - 50,
              height: 35,
              child: ListView.builder(
                  // controller: ScrollController(),
                  // physics: const FixedExtentScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: buttonText.length,
                  itemBuilder: (_, i) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        width: 100,
                        height: 30,
                        child: SymmetricButton(
                          text: buttonText[i],
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          onPressed: () {},
                        ),
                      )),
              // firstVersion(),
            ),
            Icon(
              Icons.arrow_left_outlined,
              size: 45,
              color: AppColor.kPrimaryButtonColor,
            ),
          ],
        ),
      );

  SingleChildScrollView firstVersion() => SingleChildScrollView(
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
      );
}
