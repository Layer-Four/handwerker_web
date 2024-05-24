import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/settings_provider/nav_provider.dart';
import '../consumable_view/consumable_view.dart';
import '../customer_project_view/doc_screen.dart';
import '../customer_project_view/leistung_sub.dart';
import '../customers_view/doc_screen.dart';
import '../home_view/home_body.dart';
import '../project_management_view/doc_screen.dart';
import '../time_entry_view/work_assignment.view.dart';
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
    return Scaffold(
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
                      MainView.timeEntry => const WorkAssignmenView(),
                      MainView.projectCustomer => const CustomerProjectMain(),
                      MainView.consumables => const ConsumableBody(),
                      MainView.material => const ConsumableBody(),
                      MainView.customer => const CustomerBody(),
                      MainView.projectManagement => const ProjectManagementBody(),
                      MainView.performance => const ConsumableLeistungBody(),
                      MainView.users => const EmployeeAdministration(),
                      // _ => const TimeEntryBody(),
                    },
                  ),
                ],
              )),
    );
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
                height: 100,
              ),
              const NavButtonWidget(
                icon: Icons.access_time,
                title: 'Zeiteintrag',
                nextView: MainView.timeEntry,
                height: 150,
                subcategories: [
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
                subcategories: ['Kunden/Projekte'],
                subcategoryMainViews: [MainView.projectCustomer],
                height: 100,
              ),
              const NavButtonWidget(
                title: 'Verwaltung',
                nextView: MainView.consumables,
                icon: Icons.folder_open,
                subcategories: ['Material', 'Kunden', 'Projekte', 'Leistungen'],
                height: 200,
                subcategoryMainViews: [
                  MainView.consumables,
                  MainView.customer,
                  MainView.projectManagement,
                  MainView.performance,
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
                subcategoryMainViews: [MainView.users],
                height: 100,
              ),
              // const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
              SizedBox(
                height: (constrains.maxHeight / 10) * 1.5,
              ),
              const NavButtonWidget(
                title: 'Log Out',
                // icon: Icons.power_settings_new_outlined,
                icon: Icons.logout_outlined,
                // color: Colors.teal,
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
                        height: 100,
                      ),
                      const NavButtonWidget(
                        icon: Icons.access_time,
                        title: 'Zeiteintrag',
                        nextView: MainView.timeEntry,
                        height: 100,
                        subcategories: [
                          'Zeiteintrag',
                        ],
                        subcategoryMainViews: [MainView.timeEntry],
                      ),
                      const NavButtonWidget(
                        title: 'Berichte',
                        nextView: MainView.projectCustomer,
                        icon: Icons.signal_cellular_alt_sharp,
                        subcategories: ['Kunden/Projekte'],
                        subcategoryMainViews: [MainView.projectCustomer],
                        height: 100,
                      ),
                      const NavButtonWidget(
                        icon: Icons.folder_open,
                        title: 'Verwaltung',
                        nextView: MainView.consumables,
                        height: 200,
                        subcategories: ['Material', 'Kunden', 'Projekte', 'Leistungen'],
                        subcategoryMainViews: [
                          MainView.consumables,
                          MainView.customer,
                          MainView.projectManagement,
                          MainView.performance,
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
                        icon: Icons.people_outline,
                        subcategories: ['Rechte'],
                        subcategoryMainViews: [MainView.users],
                        height: 100,
                      ),
                      SizedBox(
                        height: (constrains.maxHeight / 10) * 1.5,
                      ),
                      const NavButtonWidget(
                        title: 'Log Out',
                        nextView: MainView.projectCustomer,
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
  final List<String>? subcategories;
  final List<MainView>? subcategoryMainViews; // List of subcategory main views
  final Color? color;
  final double width;
  final double? height;
  final bool isMainCategory; // Indicates whether it's a main category or not
  const NavButtonWidget({
    super.key,
    required this.title,
    this.nextView,
    this.icon,
    this.subcategories,
    this.subcategoryMainViews,
    this.color,
    this.width = 250,
    this.height,
    this.isMainCategory = true, // Default is true
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentView = ref.watch(mainNavProvider);
    final isSelected = nextView != null
        ? currentView == nextView
        : subcategoryMainViews != null && subcategoryMainViews!.contains(currentView);
    final isSubCategory = !isMainCategory && isSelected; // Check if it's a subcategory
    return GestureDetector(
      onTap: () {
        if (nextView != null) {
          ref.read(mainNavProvider.notifier).state = nextView!;
        } else if (isMainCategory) {
          // Update the state only if it's a main category
          ref.read(mainNavProvider.notifier).state = subcategoryMainViews!.first;
        } else if (!isMainCategory) {
          ref.read(mainNavProvider.notifier).state = subcategoryMainViews!.first;
        }
      },
      child: Container(
        color: isSubCategory ? Colors.orange : (isSelected ? Colors.transparent : color),
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
                    color: isSubCategory ? Colors.orange : Colors.black, //|| isSelected
                    size: 24,
                  ),
                ),
                // const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: isSubCategory ? Colors.orange : Colors.black, //|| isSelected
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            if (subcategories != null)
              Row(
                children: [
                  const SizedBox(width: 50),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              //     textAlign: TextAlign.start,
                              style: TextStyle(
                                color: subcategoryMainViews?[index] == currentView
                                    ? Colors.orange
                                    : Colors.black, //isSubCategory || isSelected
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
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
