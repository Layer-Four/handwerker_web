import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/consumable_models/unit/unit.dart';
import '../../../provider/data_provider/consumeable_proivder/consumable_provider.dart';
import '../../shared_widgets/search_line_header.dart';
import '../../users_view/widgets/add_button_widget.dart';
import 'widgets/consumeabel_row_widget.dart';
import 'widgets/create_material_widget.dart';

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
  bool _isOpen = false;
  bool _isSnackbarShowed = false;
  late final Duration _snackbarDuration;
  final List<Unit> _units = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _snackbarDuration = widget.snackbarDuration;
    initUnitsConsumable();
  }

  void initUnitsConsumable() async {
    setState(() => isLoading = true);
    ref.read(consumableProvider.notifier).loadUnits().then((value) {
      setState(() {
        _units.addAll(value);
        if (_units.isNotEmpty) {
          isLoading = false;
        }
      });
    });
  }

  void loadMaterialList() {
    ref.read(consumableProvider.notifier).loadConsumables().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _showSnackBar(String message) {
    if (_isSnackbarShowed) return;
    setState(() => _isSnackbarShowed = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        duration: _snackbarDuration,
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchLineHeader(title: 'Material Management'),
              buildHeaderRow(),
              _units.isEmpty
                  ? const Text('Keine Daten gefunden')
                  : SizedBox(
                      // width: MediaQuery.of(context).size.width - 50,
                      height: 9 * 60,
                      child: ListView.builder(
                        itemCount: ref.watch(consumableProvider).length,
                        itemBuilder: (context, i) => ConsumebaleDataRow(
                          consumable: ref.watch(consumableProvider)[i],
                          units: _units,
                          onDelete: () {
                            ref
                                .read(consumableProvider.notifier)
                                .deleteConsumable(ref.watch(consumableProvider)[i].id!)
                                .then((e) {
                              // ignore: unused_result
                              // ref.refresh(consumableProvider);
                              e
                                  ? _showSnackBar('Eintrag erfolgreich gelöscht')
                                  : _showSnackBar(
                                      'Es ist ein Fehler aufgetreten wärend dem Löschen von: $e');
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
              AddButton(
                onTap: () => setState(() => _isOpen = !_isOpen),
                isOpen: _isOpen,
                hideAbleChild: CreateMaterialCard(
                    units: _units,
                    onReject: () {
                      setState(() => _isOpen = !_isOpen);
                    }),
              ),
            ],
          ),
        ),
      );

  Widget buildHeaderRow() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 200
                  : MediaQuery.of(context).size.width / 10 * 1.8,
              child: Text(
                'Material',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 200
                  : MediaQuery.of(context).size.width / 10 * 1.8,
              child: Text(
                'Menge',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 200
                  : MediaQuery.of(context).size.width / 10 * 1.8,
              child: Text(
                'Einheit',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 200
                  : MediaQuery.of(context).size.width / 10 * 1.8,
              child: Text(
                'Preis',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
