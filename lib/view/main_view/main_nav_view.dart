import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/settings_provider/nav_provider.dart';
import '../../routes/app_routes.dart';
import '../consumable_view/consumable_view.dart';
import '../customer_project_view/doc_screen.dart';
import '../customer_project_view/leistung_sub.dart';
import '../customers_view/doc_screen.dart';
import '../home_view/home_body.dart';
import '../project_management_view/doc_screen.dart';
import '../time_entry_view/time_entry_view.dart';
import '../users_view/user_view.dart';

class MainViewNavigator extends ConsumerWidget {
  const MainViewNavigator({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final view = ref.watch(mainNavProvider);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _navToolbar(context),
          SizedBox(
            width: width <= 1000 ? width - 50 : width - width / 7,
            child: switch (view) {
              MainView.home => const HomeBody(),
              MainView.timeEntry => const TimeEntryBody(),
              MainView.projectCustomer => const CustomerProjectMain(),
              MainView.consumables => const ConsumableBody(),
              MainView.customer => const CustomerBody(),
              MainView.projectManagement => const ProjectManagementBody(),
              MainView.material => const ConsumableLeistungBody(),
              MainView.users => const EmployeeAdministration(),
              // _ => const TimeEntryBody(),
            },
          ),
        ],
      ),
    );
  }

  Widget _navToolbar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width <= 1000
        ? IconButton(
            onPressed: () => showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) => Container(
                margin: EdgeInsets.only(
                    right: (MediaQuery.of(context).size.width / 100) * 80),
                height: double.infinity,
                width: MediaQuery.of(context).size.width / 7,
                color: const Color.fromARGB(255, 208, 207, 207),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35),
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
                      width: 200,
                      height: 60,
                    ),
                    const NavButtonWidget(
                      title: 'Zeiteintrag',
                      nextView: MainView.timeEntry,
                      width: 200,
                      height: 60,
                    ),
                    const NavButtonWidget(
                      title: 'Berichte',
                      nextView: MainView.projectCustomer,
                      width: 200,
                      height: 60,
                    ),
                    const NavButtonWidget(
                      title: 'Verwaltung',
                      nextView: MainView.consumables,
                      width: 200,
                      height: 150,
                      subcategories: [
                        'Projekte',
                        'Kunden',
                        'Material',
                        'Leistungen'
                      ],
                      subcategoryMainViews: [
                        MainView.projectManagement,
                        MainView.customer,
                        MainView.material, // Link to ConsumableLeistungBody
                        MainView.consumables
                      ],
                    ),
                    /*const NavButtonWidget(
                title: 'Kunden',
                nextView: MainView.customer,
                width: 200,
                height: 60,
              ),
              const NavButtonWidget(
                title: 'Projekte',
                nextView: MainView.projectManagement,
                width: 200,
                height: 60,
              ),*/
                    const NavButtonWidget(
                      title: 'Mitarbeiter',
                      nextView: MainView.users,
                      width: 200,
                      height: 60,
                    ),
                    const Spacer(),
                    const NavButtonWidget(
                      title: 'Log Out',
                      nextView: MainView.projectCustomer,
                      width: 200,
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
            icon: const Icon(Icons.menu),
          )
        : Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width / 7,
            color: const Color.fromARGB(255, 208, 207, 207),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35),
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
                  width: 200,
                  height: 100,
                ),
                const NavButtonWidget(
                  title: 'Zeiteintrag',
                  nextView: MainView.timeEntry,
                  icon: Icons.access_time,
                  width: 200,
                  height: 100,
                ),
                const NavButtonWidget(
                  title: 'Berichte',
                  nextView: MainView.projectCustomer,
                  icon: Icons.signal_cellular_alt_sharp,
                  subcategories: ['Kunden/Projekte'],
                  width: 200,
                  height: 100,
                ),
                const NavButtonWidget(
                  title: 'Verwaltung',
                  nextView: MainView.consumables,
                  icon: Icons.folder_open,
                  subcategories: [
                    'Projekte',
                    'Kunden',
                    'Material',
                    'Leistungen'
                  ],
                  width: 200,
                  height: 200,
                  subcategoryMainViews: [
                    MainView.projectManagement,
                    MainView.customer,
                    MainView.material,
                    MainView.consumables
                  ],
                ),
                /*const NavButtonWidget(
            title: 'Kunden',
            nextView: MainView.customer,
            width: 200,
            height: 100,
          ),
          const NavButtonWidget(
            title: 'Projekte',
            nextView: MainView.projectManagement,
            width: 200,
            height: 100,
          ),*/
                const NavButtonWidget(
                  title: 'Mitarbeiter',
                  nextView: MainView.users,
                  icon: Icons.people_outline,
                  subcategories: ['Rechte'],
                  width: 200,
                  height: 100,
                ),
                const Spacer(),
                const NavButtonWidget(
                  title: 'Log Out',
                  // nextView: MainView.docs,
                  // color: Colors.teal,
                  width: 200,
                  height: 100,
                ),
              ],
            ),
          );
  }
}

class NavButtonWidget extends ConsumerWidget {
  final String title;
  final MainView? nextView;
  final IconData? icon;
  final List<String>? subcategories;
  final List<MainView>? subcategoryMainViews; // List of subcategory main views
  final Color? color;
  final double width;
  final double height;
  final bool isMainCategory; // Indicates whether it's a main category or not
  const NavButtonWidget({
    Key? key,
    required this.title,
    this.nextView,
    this.icon,
    this.subcategories,
    this.subcategoryMainViews,
    this.color,
    required this.width,
    required this.height,
    this.isMainCategory = true, // Default is true
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentView = ref.watch(mainNavProvider);
    final isSelected = nextView != null
        ? currentView == nextView
        : subcategoryMainViews != null &&
            subcategoryMainViews!.contains(currentView);
    final isSubCategory =
        !isMainCategory && isSelected; // Check if it's a subcategory
    return GestureDetector(
      onTap: () {
        if (nextView != null) {
          ref.read(mainNavProvider.notifier).state = nextView!;
        } else if (isMainCategory) {
          // Update the state only if it's a main category
          ref.read(mainNavProvider.notifier).state =
              subcategoryMainViews!.first!;
        }
      },
      child: Container(
        color: isSubCategory
            ? Colors.orange
            : (isSelected ? Colors.transparent : color),
        width: width,
        height: height,
        margin: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.home,
                  color: isSubCategory || isSelected
                      ? Colors.orange
                      : Colors.black,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: isSubCategory || isSelected
                        ? Colors.orange
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                  ),
                ),
              ],
            ),
            if (subcategories != null)
              Row(
                children: [
                  SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        subcategories!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(left: 1),
                          child: TextButton(
                            onPressed: () {
                              // Update the state only if it's a subcategory
                              if (isMainCategory &&
                                  subcategoryMainViews != null &&
                                  index < subcategoryMainViews!.length) {
                                ref.read(mainNavProvider.notifier).state =
                                    subcategoryMainViews![index];
                              }
                            },
                            child: Text(
                              subcategories![index],
                              style: TextStyle(
                                color: isSubCategory || isSelected
                                    ? Colors.orange
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
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
      ),
    );
  }
}
