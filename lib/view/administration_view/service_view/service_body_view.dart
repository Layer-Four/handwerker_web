// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/service_models/service_vm/service_vm.dart';
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
  bool isCardVisible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchLineHeader(title: 'Leistungsverwaltung'),
                const SizedBox(height: 44),
                buildHeaderRow(),
                ...ref.watch(serviceVMProvider).map((service) => ServiceDataWidget(
                      onDelete: () => deleteService(service),
                      onUpdate: (service) {}, // updateRow(updatedRow), // Now passing onUpdate
                      service: service,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddButton(
                    isOpen: isCardVisible,
                    hideAbleChild: CreateServiceWidget(
                      onSave: (s, d) {},
                      onHideCard: () => setState(() => isCardVisible = false),
                    ),
                  ),
                ),
              ],
            ),
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

  void deleteService(ServiceVM row) async {
    final Api api = Api();

    try {
      final response = await api.deleteService(row.id!);
      print('Received response status code: ${response.statusCode} for row ID: ${row.id}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Successfully deleted row with ID: ${row.id} from the backend.');
        _showSnackBar('Row deleted successfully.');
      } else {
        print(
            'Failed to delete row with ID: ${row.id}. Status code: ${response.statusCode}, Response data: ${response.data}');
        _showSnackBar('Failed to delete the item from the server: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception when trying to delete row with ID: ${row.id}: $e');
      _showSnackBar('Error when attempting to delete the item: $e');
    }
  }

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

  Widget buildHeaderRow() => const Row(
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
      );
}
