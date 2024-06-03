import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/themes/app_color.dart';
import '../../provider/settings_provider/nav_provider.dart';
import '../../provider/user_provider/user_provider.dart';
import '../../routes/app_routes.dart';
import '../consumable_view/consumable_view.dart';
import '../customer_project_view/doc_screen.dart';
import '../customer_project_view/leistung_sub.dart';
import '../customers_view/doc_screen.dart';
import '../home_view/home_body.dart';
import '../project_management_view/doc_screen.dart';
import '../time_entry_view/work_calendar_view.dart';
import '../users_view/user_view.dart';

class MainViewNavigator extends ConsumerStatefulWidget {
  const MainViewNavigator({super.key});

  @override
  ConsumerState<MainViewNavigator> createState() => _MainViewNavigatorState();
}

class _MainViewNavigatorState extends ConsumerState<MainViewNavigator> {
  @override
  Widget build(BuildContext context) {
    final view = ref.watch(mainNavProvider);
    double width = MediaQuery.of(context).size.width;
    return Builder(
        builder: (context) => Scaffold(
              body: LayoutBuilder(
                  builder: (context, constrains) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: constrains.maxHeight,
                            child: constrains.maxWidth <= 1000
                                ? _buildpopUpNav(context, constrains)
                                : _buildStandartNavBar(context, constrains),
                          ),
                          SizedBox(
                            height: constrains.maxHeight,
                            width: width <= 1000 ? width - 50 : ((width / 10) * 8),
                            child: switch (view) {
                              MainView.home => const HomeBody(),
                              MainView.timeEntry => const WorkCalendarView(),
                              MainView.projectCustomer => const CustomerProjectMain(),
                              MainView.consumables => const ConsumableBody(),
                              MainView.customer => const CustomerBody(),
                              MainView.projectManagement => const ProjectManagementBody(),
                              MainView.performance => const ConsumableLeistungBody(),
                              MainView.users => const EmployeeAdministration(),
                              // _ => const TimeEntryBody(),
                            },
                          ),
                        ],
                      )),
            ));
  }

  Container _buildStandartNavBar(BuildContext context, BoxConstraints constrains) => Container(
        width: (MediaQuery.of(context).size.width / 10) * 2,
        color: const Color.fromARGB(255, 208, 207, 207),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 35, bottom: 35),
                child: SizedBox(
                  height: 40,
                  child: Image.asset(
                    'assets/images/img_techtool.png',
                  ),
                ),
              ),
              const NavButtonWidget(
                title: 'Home',
                nextView: MainView.home,
                icon: Icons.home_outlined,
              ),
              const NavButtonWidget(
                icon: Icons.access_time,
                title: 'Zeiteintrag',
                nextView: MainView.timeEntry,
                subcategoriestitles: [
                  'Zeiteintrag ',
                ],
                subcategoryMainViews: [
                  MainView.timeEntry,
                ],
              ),
              const NavButtonWidget(
                title: 'Berichte',
                nextView: MainView.projectCustomer,
                icon: Icons.signal_cellular_alt_sharp,
                subcategoriestitles: ['Kunden/Projekte'],
                subcategoryMainViews: [MainView.projectCustomer],
              ),
              const NavButtonWidget(
                title: 'Verwaltung',
                nextView: MainView.consumables,
                icon: Icons.folder_open,
                subcategoriestitles: ['Material', 'Kunden', 'Projekte', 'Leistungen'],
                height: 200,
                subcategoryMainViews: [
                  MainView.consumables,
                  MainView.customer,
                  MainView.projectManagement,
                  MainView.performance,
                ],
              ),
              const NavButtonWidget(
                title: 'Mitarbeiter',
                nextView: MainView.users,
                icon: Icons.people_outline,
                subcategoriestitles: ['Rechte'],
                subcategoryMainViews: [MainView.users],
              ),
              SizedBox(
                height: (constrains.maxHeight / 10) * 1.5,
              ),
              const NavButtonWidget(
                title: 'Log Out',
                icon: Icons.logout_outlined,
              ),
            ],
          ),
        ),
      );

  Widget _buildpopUpNav(BuildContext context, BoxConstraints constrains) => Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          onPressed: () => showDialog(
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) => Container(
              height: constrains.maxHeight,
              margin: EdgeInsets.only(right: (MediaQuery.of(context).size.width / 10) * 6),
              child: Material(
                color: const Color.fromARGB(255, 208, 207, 207),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18, top: 35, bottom: 35),
                        child: SizedBox(
                          height: 40,
                          child: Image.asset(
                            'assets/images/img_techtool.png',
                          ),
                        ),
                      ),
                      const NavButtonWidget(
                        icon: Icons.home_outlined,
                        title: 'Home',
                        nextView: MainView.home,
                      ),
                      const NavButtonWidget(
                        icon: Icons.access_time,
                        title: 'Zeiteintrag',
                        nextView: MainView.timeEntry,
                        subcategoriestitles: ['Zeiteintrag'],
                        subcategoryMainViews: [MainView.timeEntry],
                      ),
                      const NavButtonWidget(
                        title: 'Berichte',
                        nextView: MainView.projectCustomer,
                        icon: Icons.signal_cellular_alt_sharp,
                        subcategoriestitles: ['Kunden/Projekte'],
                        subcategoryMainViews: [MainView.projectCustomer],
                      ),
                      const NavButtonWidget(
                        icon: Icons.folder_open,
                        title: 'Verwaltung',
                        nextView: MainView.consumables,
                        height: 200,
                        subcategoriestitles: ['Material', 'Kunden', 'Projekte', 'Leistungen'],
                        subcategoryMainViews: [
                          MainView.consumables,
                          MainView.customer,
                          MainView.projectManagement,
                          MainView.performance,
                        ],
                      ),
                      const NavButtonWidget(
                        title: 'Mitarbeiter',
                        nextView: MainView.users,
                        icon: Icons.people_outline,
                        subcategoriestitles: ['Rechte'],
                        subcategoryMainViews: [MainView.users],
                      ),
                      SizedBox(
                        height: (constrains.maxHeight / 10) * 1.5,
                      ),
                      const NavButtonWidget(
                        title: 'Log Out',
                        icon: Icons.logout_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          icon: const Icon(Icons.menu),
        ),
      );
}

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
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Icon(
                    icon ?? Icons.home,
                    size: 24,
                  ),
                ),
                InkWell(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
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
                ),
              ],
            ),
            if (subcategoriestitles.isNotEmpty)
              Row(
                children: [
                  const SizedBox(width: 50),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        subcategoriestitles.length,
                        (index) => TextButton(
                          onPressed: () {
                            final MainView? next =
                                MainViewExtension.getMainview(subcategoriestitles[index]);
                            if (next != null) ref.read(mainNavProvider.notifier).state = next;
                          },
                          child: Text(
                            subcategoriestitles[index],
                            style: TextStyle(
                              color: subcategoryMainViews[index] == ref.watch(mainNavProvider)
                                  ? AppColor.kPrimaryButtonColor
                                  : Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
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
