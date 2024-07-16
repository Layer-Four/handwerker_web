import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/consumable_models/customer_overview_dm/customer_overvew_dm.dart';
import '../../../provider/customer_provider/customer_provider.dart';
import '../../shared_widgets/add_button_widget.dart';
import '../../shared_widgets/search_line_header.dart';
import '../../shared_widgets/waiting_message_widget.dart';
import 'widgets/create_customer.dart';
import 'widgets/customer_card.dart';
import 'widgets/customer_headline_widget.dart';

class CustomerBody extends ConsumerStatefulWidget {
  const CustomerBody({super.key});

  @override
  ConsumerState<CustomerBody> createState() => _CustomerBodyState();
}

class _CustomerBodyState extends ConsumerState<CustomerBody> {
  late final ScrollController _controller;
  bool isAddConsumableOpen = false;
  int editingProjectIndex = -1;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchLineHeader(title: 'Kundenverwaltung'),
                  const CustomerRowHeadline(),
                  SizedBox(
                    height: 11 * 60,
                    child: ref.watch(customerProvider).isEmpty
                        ? const WaitingMessageWidget('Lade Kundendaten')
                        : Scrollbar(
                            controller: _controller,
                            thumbVisibility: true,
                            child: ListView.builder(
                              controller: _controller,
                              itemCount: ref.watch(customerProvider).length,
                              itemBuilder: (_, index) {
                                final customer = ref.watch(customerProvider)[index];
                                return CustomerCard(
                                  key: ValueKey(index),
                                  customer: customer,
                                  onDelete: () {},
                                  onUpdate: (CustomerOvervewDM value) {},
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 10,
            child: AddButton(
              isOpen: isAddConsumableOpen,
              onTap: () {
                setState(() => isAddConsumableOpen = !isAddConsumableOpen);
              },
              hideAbleChild: CreateCustomerWidget(
                onCancel: () {
                  setState(() => isAddConsumableOpen = !isAddConsumableOpen);
                },
              ),
            ),
          ),
        ],
      );
}
