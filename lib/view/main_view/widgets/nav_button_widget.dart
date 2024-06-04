import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/themes/app_color.dart';
import '../../../provider/settings_provider/nav_provider.dart';
import '../../../provider/user_provider/user_provider.dart';
import '../../../routes/app_routes.dart';

class NavButtonWidget extends ConsumerWidget {
  final String title;
  final MainView? nextView;
  final IconData? icon;
  final List<String> subcategoriestitles;
  final List<MainView> subcategoryMainViews; // List of subcategory main views
  final Color? color;
  final double width;
  final double? height;
  const NavButtonWidget({
    super.key,
    required this.title,
    this.nextView,
    this.icon,
    this.subcategoriestitles = const <String>[],
    this.subcategoryMainViews = const [],
    this.color,
    this.width = 250,
    this.height = 100,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 0),
                  child: Icon(
                    icon ?? Icons.home,
                    size: 24,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(21),
                  onTap: () {
                    if (nextView == null) {
                      Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute);
                      ref.read(userProvider.notifier).userLogOut();
                      return;
                    }
                    if (subcategoriestitles.isEmpty || subcategoryMainViews.isEmpty) {
                      final MainView? next = MainViewExtension.getMainview(title);
                      if (next != null) ref.read(mainNavProvider.notifier).state = next;
                    } else {
                      ref.read(mainNavProvider.notifier).state = subcategoryMainViews.first;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            if (subcategoriestitles.isNotEmpty)
              Row(
                children: [
                  const SizedBox(width: 45),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        subcategoriestitles.length,
                        (index) => TextButton(
                          style: TextButton.styleFrom(
                            overlayColor: Colors.grey[600],
                          ),
                          onPressed: () {
                            final MainView? next =
                                MainViewExtension.getMainview(subcategoriestitles[index]);
                            if (next != null) ref.read(mainNavProvider.notifier).state = next;
                          },
                          child: Text(
                            subcategoriestitles[index],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: subcategoryMainViews[index] == ref.watch(mainNavProvider)
                                      ? AppColor.kPrimaryButtonColor
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
}
