import 'package:flutter/material.dart';
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
    final contentWidth = MediaQuery.of(context).size.width - 100;
    final contentHeight = MediaQuery.of(context).size.height - 100;
    return SizedBox(
      width: contentWidth,
      height: contentHeight,
      child: Column(
        children: [
          _searchHeader(context),
          _tableHead(headStyle, contentWidth),
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
                    builder: (context) => const AddNewConsumable(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _tableHead(TextStyle? headStyle, double contentWidth) {
    return Padding(
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

class AddNewConsumable extends StatelessWidget {
  const AddNewConsumable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final contentWidth = MediaQuery.of(context).size.width;
    final contentHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: (contentWidth / 10) * 3, vertical: (contentHeight / 10) * 2.2),
      child: Card(
        elevation: 7,
        child: Container(
          color: Colors.white,
          height: 600,
          width: 450,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Neues Material Erstellen'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Name'),
                  ),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: const Color.fromARGB(255, 220, 217, 217),
                            ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 220, 217, 217),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Maßeinheit'),
                  ),
                  SizedBox(
                    width: 400,
                    // TODO: change to DropDownButton Measurment
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: const Color.fromARGB(255, 220, 217, 217),
                            ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 220, 217, 217),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Menge'),
                  ),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: const Color.fromARGB(255, 220, 217, 217),
                            ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 220, 217, 217),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4),
                    child: Text("Preis in Cent's"),
                  ),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: const Color.fromARGB(255, 220, 217, 217),
                            ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 220, 217, 217),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SymmetricButton(
                  color: Colors.orange,
                  text: 'Neues Material',
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
