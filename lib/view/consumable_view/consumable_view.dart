import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handwerker_web/models/consumable_models/consumable_vm/consumable_vm.dart';
import 'package:handwerker_web/view/view_widgets/symetric_button_widget.dart';

class ConsumableBody extends StatefulWidget {
  const ConsumableBody({super.key});

  @override
  State<ConsumableBody> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends State<ConsumableBody> {
  final TextEditingController _searchController = TextEditingController();

  final listOfConsumables = [
    const ConsumableVM(
      measurement: Measurement.m,
      priceInCents: 3000,
      title: 'Latte',
      amount: 100,
    ),
    const ConsumableVM(
      measurement: Measurement.stk,
      priceInCents: 7000,
      title: 'Hammer',
      amount: 5,
    ),
    const ConsumableVM(
      measurement: Measurement.stk,
      priceInCents: 500,
      title: 'Eierkocher',
      amount: 50000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final headStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        );
    final contentWidth = MediaQuery.of(context).size.width;
    final contentHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          _searchHeader(context),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Material', style: headStyle),
                Text('Mengeeinheit', style: headStyle),
                Text('Preis/Einheit', style: headStyle),
                SizedBox(
                  width: (contentWidth / 10) * 1.5,
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: (contentWidth / 10) * 7.5,
              height: contentHeight - 600,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: listOfConsumables.length,
                    itemBuilder: (context, i) {
                      final item = listOfConsumables[i];
                      return Card(
                        child: Container(
                          height: 80,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: (contentWidth / 10) * 1.5,
                                  child: Center(child: Text(item.title))),
                              SizedBox(
                                width: (contentWidth / 10) * 1.5,
                                child: Center(
                                  child: Text(
                                    item.measurement.getTitle(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: (contentWidth / 10) * 1.5,
                                  child: Center(child: Text('${item.priceInCents / 100} €'))),
                              SizedBox(
                                width: (contentWidth / 10) * 1.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showAboutDialog(context: context);
                                        },
                                        icon: const Icon(Icons.edit_document)),
                                    // TODO: maybe a checkbox or something else when
                                    IconButton(
                                        onPressed: () {
                                          showAboutDialog(context: context);
                                        },
                                        icon: const Icon(Icons.visibility_sharp)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: contentWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 8.0),
              child: SymmetricButton(
                color: Colors.orange,
                text: '+',
                onPressed: () {
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.amber,
                      margin: const EdgeInsets.all(300),
                      child: const Text(''),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _searchHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            Text(
              '',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600, color: Colors.orange),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      _searchController.text = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      suffixIcon: const Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
