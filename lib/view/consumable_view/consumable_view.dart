import 'package:flutter/material.dart';
import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../shared_view_widgets/symetric_button_widget.dart';

class ConsumableBody extends StatefulWidget {
  const ConsumableBody({super.key});

  @override
  State<ConsumableBody> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends State<ConsumableBody> {
  final TextEditingController _searchController = TextEditingController();
  bool _isAddConsumableOpen = false;

  final listOfConsumables = [
    const ConsumableVM(
      measurement: Measurement.m,
      priceInCents: 3000,
      title: 'Montage Algemein',
      amount: 2,
    ),
    const ConsumableVM(
      measurement: Measurement.m3,
      priceInCents: 9000000,
      title: 'Montage Fenster',
      amount: 2,
    ),
    const ConsumableVM(
      measurement: Measurement.x,
      priceInCents: 3000,
      title: 'Montage Algemeine Meister',
      amount: 20,
    ),
  ];
// table data
  @override
  Widget build(BuildContext context) {
    final headStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.w600);
    final contentWidth = MediaQuery.of(context).size.width - 100;
    final contentHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: contentWidth,
      height: contentHeight,
      child: Column(
        children: [
          _searchHeader(context),
          _tableHead(headStyle, contentWidth),
          SingleChildScrollView(
            child: SizedBox(
              width: contentWidth < 1000
                  ? contentWidth
                  : (contentWidth / 10) * 7.5,
              height: contentHeight - 600,
              child: ListView.builder(
                  itemCount: listOfConsumables.length,
                  itemBuilder: (context, i) {
                    final item = listOfConsumables[i];
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                        ),
                      ),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // this text should be aligned more to right
                          Container(
                              width: (contentWidth / 10) * 1.7,
                              child: Text(item.title)),
                          SizedBox(
                            width: (contentWidth / 10) * 1.5,
                            child: Text(
                              '${item.amount}',
                            ),
                          ),
                          SizedBox(
                              width: (contentWidth / 10) * 1.5,
                              child: Text(
                                item.measurement.getTitle(),
                              )),
                          SizedBox(
                              width: (contentWidth / 10) * 1.5,
                              child: Text('${item.priceInCents / 100} €')),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Handle edit action here
                              // _editItem(context, item);
                            },
                            child: SizedBox(child: const Icon(Icons.edit)),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            // width: contentWidth,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 80, vertical: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Material(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(50),
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          _isAddConsumableOpen ? Icons.remove : Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isAddConsumableOpen = !_isAddConsumableOpen;
                          });
                          // showAdaptiveDialog(
                          //   context: context,
                          //   builder: (context) => const AddNewConsumable(),
                          // );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
              visible: _isAddConsumableOpen, child: const AddNewConsumable())
        ],
      ),
    );
  }
  // table head section

  Padding _tableHead(TextStyle? headStyle, double contentWidth) => Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (contentWidth / 10) * 1.2,
              child: Center(child: Text('Leistung', style: headStyle)),
            ),
            SizedBox(
              width: (contentWidth / 10) * 1.8,
              child: Center(child: Text('Menge', style: headStyle)),
            ),
            SizedBox(
              width: (contentWidth / 10) * 1.5,
              child: Center(child: Text('Einheit', style: headStyle)),
            ),
            Text(
              'Preis/mengeneinheit',
              style: headStyle,
            ),
            // Container(
            //     color: Colors.green,
            //     height: 20,
            //     width: (contentWidth / 10) * 1.5)
          ],
        ),
      );

  Widget _searchHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Text(
                '',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.orange),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        _searchController.text = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
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

class AddNewConsumable extends StatelessWidget {
  const AddNewConsumable({
    super.key,
  });

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    // final contentWidth = MediaQuery.of(context).size.width;
    // final contentHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8.0),
      child: Container(
        // margin: EdgeInsets.symmetric(
        //     horizontal: (contentWidth / 5) * 3,
        //     vertical: (contentHeight / 10) * 2.2),
        child: Card(
          elevation: 9,
          child: Container(
            color: Color.fromARGB(255, 255, 255, 255),
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // const Text('Neues Material Erstellen'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Leistung'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: SizedBox(
                              // width: 400,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: const Color.fromARGB(
                                            255, 220, 217, 217),
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
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 220, 217, 217)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Menge'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SizedBox(
                              // width: 400,
                              // TODO: change to DropDownButton Measurment
                              child: TextField(
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: const Color.fromARGB(
                                            255, 220, 217, 217),
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
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 220, 217, 217)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Einheit'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SizedBox(
                              // width: 400,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: const Color.fromARGB(
                                            255, 220, 217, 217),
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
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 220, 217, 217)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Preis/mengeneinheit'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SizedBox(
                              // width: 400,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: const Color.fromARGB(
                                            255, 220, 217, 217),
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
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 220, 217, 217)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SymmetricButton(
                        color: const Color.fromARGB(255, 241, 241, 241),
                        text: 'Verwerfen',
                        style: const TextStyle(color: Colors.orange),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SymmetricButton(
                        color: Colors.orange,
                        text: 'Speichern',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
