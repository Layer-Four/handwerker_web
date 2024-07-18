import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/consumable_models/unit/unit.dart';
import '../../../provider/data_provider/consumeable_proivder/consumable_provider.dart';
import '../../shared_widgets/add_button_widget.dart';
import '../../shared_widgets/search_line_header.dart';
import '../../shared_widgets/waiting_message_widget.dart';
import 'widgets/consumable_header.dart';
import 'widgets/consumeabel_row_widget.dart';
import 'widgets/create_material_widget.dart';

class ConsumableBodyView extends ConsumerStatefulWidget {
  const ConsumableBodyView({super.key});

  @override
  ConsumerState<ConsumableBodyView> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends ConsumerState<ConsumableBodyView> {
  late final ScrollController _controller;
  bool _isOpen = false;
  final List<Unit> _units = [];

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
    initUnits();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initUnits() async => ref.read(consumableProvider.notifier).loadUnits().then((value) {
        setState(() => _units.addAll(value));
      });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchLineHeader(title: 'Material Management'),
                    const ConsumableHeader(),
                    _units.isEmpty
                        ? const WaitingMessageWidget('Lade Material')
                        : SizedBox(
                            height: 11 * 60,
                            child: Scrollbar(
                              controller: _controller,
                              thumbVisibility: true,
                              child: ListView.builder(
                                controller: _controller,
                                itemCount: ref.watch(consumableProvider).length,
                                itemBuilder: (context, i) => ConsumebaleDataRow(
                                  key: ValueKey(ref.watch(consumableProvider)[i]),
                                  consumable: ref.watch(consumableProvider)[i],
                                  units: _units,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 50,
            child: AddButton(
              onTap: () => setState(() => _isOpen = !_isOpen),
              isOpen: _isOpen,
              hideAbleChild: CreateMaterialCard(
                units: _units,
                onReject: () => setState(() => _isOpen = !_isOpen),
              ),
            ),
          ),
        ],
      );
}
