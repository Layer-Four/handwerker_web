import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../models/consumable_models/unit/unit.dart';
import '../../provider/consumeable_proivder/consumable_provider.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'widgets/card_widget.dart';
import 'widgets/consumeabel_row_widget.dart';

class ConsumableBody extends ConsumerStatefulWidget {
  const ConsumableBody({super.key});

  @override
  ConsumerState<ConsumableBody> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends ConsumerState<ConsumableBody> {
  final List<Unit> _units = [Unit(id: 0, name: 'leer')];
  List<ConsumableVM> consumableList = [];
  bool isLoading = true;
  bool isCardVisible = false;

  @override
  void initState() {
    super.initState();
    loadUnits();
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
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void hideCard() {
    setState(() {
      isCardVisible = false;
    });
  }

  void deleteService(ConsumableVM row) async {
    try {
      await ref.read(consumableProvider.notifier).deleteConsumable(row.id);
      // TODO: Sollte View Aktualisieren
      // ignore: unused_result
      ref.refresh(consumableProvider);
      // setState(() {
      //   consumableList = ref.watch(consumableProvider);
      // });
      _showSnackBar('Row deleted successfully.');
    } catch (e) {
      _showSnackBar('Error when attempting to delete the item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return buildCardContent();
  }

  Widget buildCardContent() => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchLineHeader(title: 'Material Management'),
                buildHeaderRow(),
                (consumableList.isEmpty && _units.isEmpty)
                    ? const Text('No data available')
                    : ListView.builder(
                        // shrinkWrap: true,
                        itemCount: consumableList.length,
                        itemBuilder: (context, i) {
                          log('consumables-> ${consumableList.length} units-> ${_units.length}');
                          return ConsumebaleDataRow(
                            consumable: consumableList[i],
                            onDelete: () => deleteService(consumableList[i]),
                            units: _units,
                          );
                        },
                      ),
                const SizedBox(height: 40),
                buildAddButton(),
                if (isCardVisible)
                  CardWidget(
                    onSave: _addRow,
                    onHideCard: hideCard,
                  ),
              ],
            ),
          ),
        ),
      );

  Widget buildHeaderRow() => Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Material',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Menge',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Einheit',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Preis',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      );

  Widget buildAddButton() => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Align(
          alignment: Alignment.topLeft,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                isCardVisible = !isCardVisible;
              });
            },
            backgroundColor: Colors.orange,
            child: Icon(isCardVisible ? Icons.remove : Icons.add, color: Colors.white),
          ),
        ),
      );

  void _addRow(String materialName, int amount, Unit unit, int price) {
    setState(() {
      consumableList.add(ConsumableVM(
        id: consumableList.isNotEmpty ? consumableList.last.id + 1 : 1,
        name: materialName,
        amount: amount,
        unit: unit,
        price: price,
      ));
    });
  }
}
