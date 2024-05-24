import 'package:flutter/material.dart';

import '../../../constants/themes/app_color.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class LeftButtonRow extends StatelessWidget {
  const LeftButtonRow({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        // firstVersion()
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                  text: 'Zeiteintrag',
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  onPressed: () {},
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                width: 100,
                height: 30,
                child: SymmetricButton(
                  text: 'Tag',
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  onPressed: () {},
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                width: 100,
                height: 30,
                child: SymmetricButton(
                  text: 'Woche',
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  onPressed: () {},
                ),
              ),
            ],
          ),
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
              Icon(
                Icons.arrow_left_outlined,
                size: 45,
                color: AppColor.kPrimaryButtonColor,
              ),
            ],
          ),
        ),
      );
}
