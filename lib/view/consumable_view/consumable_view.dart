import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../models/consumable_models/unit/unit.dart';
import '../../provider/consumeable_proivder/consumable_provider.dart';
import '../shared_view_widgets/search_line_header.dart';
import '../users_view/widgets/add_button_widget.dart';
import 'widgets/creaet_material_widget.dart';
import 'widgets/consumeabel_row_widget.dart';

class ConsumableBody extends ConsumerStatefulWidget {
  final Duration snackbarDuration;

  const ConsumableBody({
    super.key,
    this.snackbarDuration = const Duration(seconds: 7),
  });

  @override
  ConsumerState<ConsumableBody> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends ConsumerState<ConsumableBody> {
  bool _isSnackbarShowed = false;
  late final Duration _snackbarDuration;
  final List<Unit> _units = [];
  List<ConsumableVM> consumableList = [];
  bool isLoading = true;
  bool isCardVisible = false;

  @override
  void initState() {
    super.initState();
    loadUnits();
    _snackbarDuration = widget.snackbarDuration;
  }

  void loadUnits() {
    setState(() => isLoading = true);
    ref.read(consumableProvider.notifier).loadUnits().then((value) {
      loadMaterialList();
      setState(() {
        _units.addAll(value);
      });
    });
  }

  void loadMaterialList() {
    ref.read(consumableProvider.notifier).loadConsumables().then((_) {
      setState(() {
        consumableList = ref.watch(consumableProvider);
        isLoading = false;
      });
    });
  }

  void _showSnackBar(String message) {
    if (_isSnackbarShowed) return;
    setState(() => _isSnackbarShowed = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: _snackbarDuration),
    );
    Future.delayed(_snackbarDuration).then(
      (_) => setState(() => _isSnackbarShowed = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return buildCardContent();
  }

  Widget buildCardContent() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchLineHeader(title: 'Material Management'),
              buildHeaderRow(),
              consumableList.isEmpty && _units.isEmpty
                  ? const Text('No data available')
                  : SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 5 * 74,
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: consumableList.length,
                        itemBuilder: (context, i) {
                          log('consumables-> ${consumableList.length} units-> ${_units.length}');
                          return ConsumebaleDataRow(
                            consumable: consumableList[i],
                            onDelete: () {
                              ref
                                  .read(consumableProvider.notifier)
                                  .deleteConsumable(consumableList[i].id!)
                                  .then((e) {
                                // ignore: unused_result
                                ref.refresh(consumableProvider);
                                e
                                    ? _showSnackBar('Row deleted successfully.')
                                    : _showSnackBar('Error when attempting to delete the item: $e');
                              });
                            },
                            // => deleteService(consumableList[i]),
                            units: _units,
                          );
                        },
                      ),
                    ),
              AddButton(
                onTap: () => setState(() => isCardVisible = !isCardVisible),
              ),
              // const SizedBox(height: 40),
              // buildAddButton(),
              if (isCardVisible)
                CreateMaterialCard(
                  onSave: _addRow,
                  //  ref.read(consumableProvider).createConsumable(_, int amount, Unit unit, double price);
                  onHideCard: () => setState(() => isCardVisible = false),
                  units: _units,
                  onAccept: () {
                    // _createConsumable();
                  },
                ),
            ],
          ),
        ),
      );

  Widget buildHeaderRow() => Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 10 * 2.0,
            child: Text(
              'Material',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 10 * 2.0,
            child: Text(
              'Menge',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 10 * 2.0,
            child: Text(
              'Einheit',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Text(
            'Preis',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      );

  // Widget buildAddButton() => Padding(
  //       padding: const EdgeInsets.only(bottom: 8),
  //       child: Align(
  //         alignment: Alignment.topLeft,
  //         child: FloatingActionButton(
  //           onPressed: () {
  //             setState(() {
  //               isCardVisible = !isCardVisible;
  //             });
  //           },
  //           backgroundColor: Colors.orange,
  //           child: Icon(isCardVisible ? Icons.remove : Icons.add, color: Colors.white),
  //         ),
  //       ),
  //     );

  void _addRow(String materialName, int amount, Unit unit, int price) {
    // setState(() {
    //   consumableList.add(ConsumableVM(
    //     id: consumableList.isNotEmpty ? consumableList.last.id + 1 : 1,
    //     name: materialName,
    //     amount: amount,
    //     unit: unit,
    //     price: price,
    //   ));
    // });
  }

  // void _createConsumable() async {
  //   final String material = _materialController.text.trim();
  //   final int amount = int.parse(_amountController.text.trim());
  //   final Unit unit = _selectedUnit!;
  //   final int price = int.parse(_priceController.text.trim());

  //   if (!_validateInputs()) {
  //     return;
  //   }

  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     await ref
  //         .read(consumableProvider.notifier)
  //         .createService(material, amount, unit, price)
  //         .then((value) {
  //       setState(() {
  //         _priceController.clear();
  //         _selectedUnit = null;
  //         _amountController.clear();
  //         _materialController.clear();
  //       });
  //     });

  //     widget.onSave(material, amount, unit, price);

  //     if (Navigator.canPop(context)) {
  //       Navigator.of(context).pop();
  //     }
  //   } catch (e) {
  //     log('Error on createService: $e');
  //     showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         title: const Text('Fehler beim Speichern'),
  //         content: Text('Ein Fehler ist aufgetreten: $e'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(ctx).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false; // Stop loading after the API call completes
  //     });
  //   }
  // }
}
