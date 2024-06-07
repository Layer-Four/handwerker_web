import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/data_provider/service_provider/service_vm_provider.dart';
import '../../shared_widgets/search_line_header.dart';
import '../../users_view/widgets/add_button_widget.dart';
import 'widgets/create_service_widget.dart';
import 'widgets/service_data_widget.dart';

class ServiceBodyView extends ConsumerStatefulWidget {
  const ServiceBodyView({super.key});

  @override
  ConsumerState<ServiceBodyView> createState() => _ServiceBodyViewState();
}

class _ServiceBodyViewState extends ConsumerState<ServiceBodyView> {
  bool _isCardVisible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchLineHeader(title: 'Leistungsverwaltung'),
              _buildHeaderRow(),
              SizedBox(
                height: 9 * 74,
                child: ListView.builder(
                  itemCount: ref.watch(serviceVMProvider).length,
                  // TODO: View build so fast, after delete Service, Widget was build and length of List did change after that
                  // log(ref.watch(serviceVMProvider)[i].toJson().toString());
                  itemBuilder: (context, i) =>
                      ServiceDataWidget(service: ref.watch(serviceVMProvider)[i]),
                ),
              ),
              // ...ref.watch(serviceVMProvider).map(
              //       (service) =>
              //     ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AddButton(
                  isOpen: _isCardVisible,
                  onTap: () => setState(() => _isCardVisible = !_isCardVisible),
                  hideAbleChild: CreateServiceWidget(
                    onReject: () => setState(() => _isCardVisible = false),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildHeaderRow() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Leistung', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 30),
            Expanded(
              child: Text('Preis/std', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Spacer(),
            SizedBox(width: 110) // Adjust spacing as needed
          ],
        ),
      );
}
