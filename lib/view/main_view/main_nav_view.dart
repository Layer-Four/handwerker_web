import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_web/provider/nav_provider.dart';
import 'package:handwerker_web/routes/app_routes.dart';
import 'package:handwerker_web/view/consumable_view/consumable_view.dart';
import 'package:handwerker_web/view/doc_view/doc_view.dart';
import 'package:handwerker_web/view/home_view/home_body.dart';
import 'package:handwerker_web/view/time_entry_view/time_entry_view.dart';
import 'package:handwerker_web/view/users_view/user_view.dart';

class MainViewNavigator extends ConsumerWidget {
  const MainViewNavigator({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final view = ref.watch(mainNavProvider);
    return Scaffold(
      body: Row(
        children: [
          _navToolbar(context),
          SizedBox(
              width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / 5),
              child: switch (view) {
                MainView.home => const HomeBody(),
                MainView.timeEntry => const TimeEntryBody(),
                MainView.docs => const DocumentBody(),
                MainView.consumables => const ConsumableBody(),
                MainView.users => const UserBody(),
                // _ => const HomeBody(),
              }),
        ],
      ),
    );
  }

  Widget _navToolbar(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width / 5,
        color: const Color.fromARGB(255, 208, 207, 207),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/images/img_techtool.png',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.read(mainNavProvider.notifier).state = MainView.home;
              },
              child: Container(
                color: Colors.blue,
                width: double.infinity,
                height: 100,
                margin: const EdgeInsets.all(4),
                child: const Center(child: Text('Home')),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.read(mainNavProvider.notifier).state = MainView.timeEntry;
              },
              child: Container(
                color: Colors.blueAccent,
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.all(4),
                child: const Center(child: Text('Kunden/Projeke')),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.read(mainNavProvider.notifier).state = MainView.docs;
              },
              child: Container(
                color: Colors.blueGrey,
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.all(4),
                child: const Center(child: Text('Berichte')),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.read(mainNavProvider.notifier).state = MainView.consumables;
              },
              child: Container(
                width: double.infinity,
                color: Colors.brown,
                height: 100,
                margin: const EdgeInsets.all(4),
                child: const Center(child: Text('Material')),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.read(mainNavProvider.notifier).state = MainView.users;
              },
              child: Container(
                width: double.infinity,
                color: Colors.cyan,
                height: 100,
                margin: const EdgeInsets.all(4),
                child: const Center(child: Text('Mitarbeiter')),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute);
              },
              child: Container(
                color: Colors.teal,
                alignment: Alignment.bottomLeft,
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(4),
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
