// ignore_for_file: use_build_context_synchronously, avoid_print

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
              ...ref.watch(serviceVMProvider).map((service) => ServiceDataWidget(
                    onDelete: () =>
                        ref.read(serviceVMProvider.notifier).deleteService(service.id!).then((e) {
                      _showSnackBar(
                        e
                            ? 'Leistung erfolgreich gelöscht'
                            : 'Leistung konnte nicht gelöscht werden',
                      );
                    }),
                    onUpdate: (service) {}, // updateRow(updatedRow), // Now passing onUpdate
                    service: service,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AddButton(
                  isOpen: _isCardVisible,
                  onTap: () => setState(() => _isCardVisible = !_isCardVisible),
                  hideAbleChild: CreateServiceWidget(
                    onSave: () {},
                    onReject: () => setState(() => _isCardVisible = false),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  // Future<void> fetchData() async {
  //   final Api api = Api();
  //   try {
  //     print('Making API call to the server...');
  //     final response = await api.getExecuteableServices.timeout(
  //       const Duration(seconds: 10),
  //       onTimeout: () {
  //         throw Exception('The connection has timed out, please try again!');
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       List<dynamic> data = response.data;
  //       setState(() {
  //         rowDataList = data.map((item) => ServiceVM.fromJson(item)).toList();
  //         isLoading = false;
  //       });
  //     } else {
  //       print('Failed to fetch data: ${response.statusCode}');
  //       throw Exception('Failed to load data: HTTP status ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     _showSnackBar('Error: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  void _showSnackBar(String message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(message)),
        ),
      );

  // Future<void> updateRow(Service row) async {
  //   final url = Uri.parse('https://r-wa-happ-be.azurewebsites.net/api/service/update');
  //   try {
  //     final response = await http.put(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer your_access_token',
  //       },
  //       body: jsonEncode(row.toJson()),
  //     );

  //     if (response.statusCode == 200) {
  //       _showSnackBar('Update successful');
  //     } else {
  //       var errMsg = 'Failed to update item: ${response.statusCode}';
  //       if (response.statusCode == 400) {
  //         errMsg += ' - Bad Request, check data';
  //       } else if (response.statusCode == 404) {
  //         errMsg += ' - Item not found';
  //       } else if (response.statusCode == 500) {
  //         errMsg += ' - Server error';
  //       }
  //       _showSnackBar(errMsg);
  //     }
  //   } catch (e) {
  //     _showSnackBar('Network error: $e');
  //   }
  // }

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
