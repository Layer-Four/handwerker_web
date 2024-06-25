import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/utilitis/utilitis.dart';
import '../../../models/consumable_models/customer_overview_dm/customer_overvew_dm.dart';
import '../../../provider/customer_provider/customer_provider.dart';
import '../../shared_widgets/search_line_header.dart';
import '../../users_view/widgets/add_button_widget.dart';
import 'widgets/create_customer.dart';
import 'widgets/customer_card.dart';

class CustomerBody extends ConsumerStatefulWidget {
  const CustomerBody({super.key});

  @override
  ConsumerState<CustomerBody> createState() => _CustomerBodyState();
}

class _CustomerBodyState extends ConsumerState<CustomerBody> {
  bool isAddConsumableOpen = false;
  int editingProjectIndex = -1;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchLineHeader(title: 'Kundenverwaltung'),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width > 600 ? double.infinity : null,
                height: 9 * 60,
                child: ref.watch(customerProvider).isEmpty
                    ? Utilitis.waitingMessage(context, 'Lade Kundendaten')
                    : ListView.builder(
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
              AddButton(
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
            ],
          ),
        ),
      );
}
