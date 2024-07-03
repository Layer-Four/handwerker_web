import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/consumable_models/unit/unit.dart';
import '../../../provider/data_provider/consumeable_proivder/consumable_provider.dart';
import '../../shared_widgets/search_line_header.dart';
import '../../users_view/widgets/add_button_widget.dart';
import 'widgets/consumeabel_row_widget.dart';
import 'widgets/create_material_widget.dart';

class ConsumableBodyView extends ConsumerStatefulWidget {
  final Duration snackbarDuration;

  const ConsumableBodyView({
    super.key,
    this.snackbarDuration = const Duration(seconds: 7),
  });

  @override
  ConsumerState<ConsumableBodyView> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends ConsumerState<ConsumableBodyView> {
  bool _isOpen = false;
  bool _isSnackbarShowed = false;
  late final Duration _snackbarDuration;
  final List<Unit> _units = [];

  @override
  void initState() {
    super.initState();
    _snackbarDuration = widget.snackbarDuration;
    initUnitsConsumable();
  }

  void initUnitsConsumable() async =>
      ref.read(consumableProvider.notifier).loadUnits().then((value) {
        setState(() => _units.addAll(value));
      });

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
    final consumables = ref.watch(consumableProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchLineHeader(title: 'Material Management'),
            buildHeaderRow(),
            _units.isEmpty
                ? Utilitis.waitingMessage(context, 'Lade Material')
                : SizedBox(
                    height: 9 * 60,
                    child: ListView.builder(
                      itemCount: consumables.length,
                      itemBuilder: (context, i) => ConsumebaleDataRow(
                        key: ValueKey(consumables[i]),
                        consumable: consumables[i],
                        units: _units,
                        onDelete: () {
                          ref
                              .read(consumableProvider.notifier)
                              .deleteConsumable(consumables[i].id!)
                              .then((e) {
                            _showSnackBar(e
                                ? 'Eintrag erfolgreich gelöscht'
                                : 'Es ist ein Fehler aufgetreten während dem Löschen');
                          });
                          // Navigator.of(context).pop();
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
  }

  Widget buildHeaderRow() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
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
                'Preis/€',
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
