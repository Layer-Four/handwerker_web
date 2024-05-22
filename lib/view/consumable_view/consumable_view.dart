import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constants/api/api.dart';
import '../shared_view_widgets/search_line_header.dart';

class ConsumableBody extends StatefulWidget {
  const ConsumableBody({super.key});

  @override
  _ConsumableBodyState createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends State<ConsumableBody> {
  List<Service> rowDataList = [];
  bool isLoading = true;
  bool isCardVisible = false;
  final Dio _dio = Dio();
  Service? currentService;
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const materialUrl = 'https://r-wa-happ-be.azurewebsites.net/api/material/list';

    try {
      var materialData = await _fetchData(materialUrl, 'material data');
      _processFetchedData(materialData);
    } catch (e) {
      _showSnackBar('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<dynamic>> _fetchData(String url, String dataType) async {
    print('Fetching $dataType...');
    var response = await _dio.get(url);
    if (response.statusCode == 200) {
      print('$dataType response: ${response.data}');
      return response.data;
    } else {
      throw Exception('Failed to load $dataType');
    }
  }

  void _processFetchedData(List<dynamic> materialData) {
    List<Service> loadedData = [];
    for (var data in materialData) {
      print('Processing data: $data'); // Add this line to print each item
      loadedData.add(
        Service(
          id: data['id'],
          materialName: data['name'] ?? 'N/A',
          amount: data['amount']?.toString() ?? 'N/A', // Use correct key
          unitName: data['materialUnitName'] ?? 'N/A', // Extract unit name from response
          price: data['price']?.toString() ?? 'N/A', // Use correct key
        ),
      );
    }

    setState(() {
      rowDataList = loadedData;
      isLoading = false;
    });

    print('Loaded data: $loadedData');
  }

  Future<void> updateRow(Service row) async {
    final Api api = Api();
    try {
      print('Making API call to the server...');
      final response = await api.updateProjectConsumableWebEntry(row);

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
        List<dynamic> data = response.data;
        setState(() {
          rowDataList = data.map((item) => Service.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        throw Exception('Failed to load data: HTTP status ${response.statusCode}');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _deleteRow(int index) {
    setState(() {
      rowDataList.removeAt(index);
    });
  }

  void _editRow(int index) {
    setState(() {
      currentService = rowDataList[index];
      currentIndex = index;
      isCardVisible = true;
    });
  }

  void _saveRow(String materialName, String amount, String unitName, String price) async {
    setState(() {
      if (currentIndex != null) {
        rowDataList[currentIndex!] = Service(
          id: currentService!.id,
          materialName: materialName,
          amount: amount,
          unitName: unitName,
          price: price,
        );
        updateRow(rowDataList[currentIndex!]);
        currentService = null;
        currentIndex = null;
      } else {
        rowDataList.add(Service(
          id: rowDataList.isNotEmpty ? rowDataList.last.id + 1 : 1, // Dummy ID generation
          materialName: materialName,
          amount: amount,
          unitName: unitName,
          price: price,
        ));
      }
      isCardVisible = false;
    });

    // Fetch the latest data to refresh the list
    await fetchData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Material Management'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(75, 30, 30, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SearchLineHeader(title: 'Material Management'),
                      const SizedBox(height: 44),
                      buildHeaderRow(),
                      buildDataRows(),
                      const SizedBox(height: 40),
                      buildAddButton(),
                      if (isCardVisible)
                        CardWidget(
                          key: ValueKey(currentService?.id ?? 'new'), // Ensure the widget rebuilds with new data
                          onSave: _saveRow,
                          onHideCard: () {
                            setState(() {
                              isCardVisible = false;
                            });
                          },
                          service: currentService,
                        ),
                    ],
                  ),
                ),
              ),
      );

  Widget buildHeaderRow() => const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('Material', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 22),
          Expanded(
            child: Text('Amount', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 44),
          Expanded(
            child: Text('Einheit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text('Price /mengeneinheit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 110),
        ],
      );

  Widget buildDataRows() {
    List<Widget> rows = [];

    for (int i = 0; i < rowDataList.length; i++) {
      rows.add(Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(rowDataList[i].materialName)),
            Expanded(child: Text(rowDataList[i].amount)),
            Expanded(child: Text(rowDataList[i].unitName)),
            Expanded(child: Text(rowDataList[i].price)),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteRow(i),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editRow(i),
            ),
          ],
        ),
      ));
    }

    return Column(children: rows);
  }

  Widget buildAddButton() => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  currentService = null;
                  currentIndex = null;
                  isCardVisible = !isCardVisible;
                });
              },
              iconSize: 30,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              icon: isCardVisible
                  ? const Icon(Icons.remove, color: Colors.white)
                  : const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      );
}

class Service {
  int id;
  String materialName;
  String amount;
  String unitName;
  String price;

  Service({
    required this.id,
    required this.materialName,
    required this.amount,
    required this.unitName,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['id'],
        materialName: json['name'] ?? 'N/A',
        amount: json['amount']?.toString() ?? 'N/A',
        unitName: json['materialUnitName'] ?? 'N/A',
        price: json['price']?.toString() ?? 'N/A',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': materialName,
        'amount': double.tryParse(amount) ?? 0.0,
        'materialUnitName': unitName,
        'price': double.tryParse(price) ?? 0.0,
      };

  @override
  String toString() =>
      'Service(id: $id, materialName: $materialName, amount: $amount, unitName: $unitName, price: $price)';
}

class CardWidget extends StatefulWidget {
  final Function(String materialName, String amount, String unitName, String price) onSave;
  final Function onHideCard;
  final Service? service;

  const CardWidget({required this.onSave, required this.onHideCard, this.service, super.key});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _measurementController;
  late TextEditingController _priceController;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.service?.materialName ?? '');
    _amountController = TextEditingController(text: widget.service?.amount ?? '');
    _measurementController = TextEditingController(text: widget.service?.unitName ?? '');
    _priceController = TextEditingController(text: widget.service?.price ?? '');
  }

  @override
  void didUpdateWidget(CardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.service != oldWidget.service) {
      _titleController.text = widget.service?.materialName ?? '';
      _amountController.text = widget.service?.amount ?? '';
      _measurementController.text = widget.service?.unitName ?? '';
      _priceController.text = widget.service?.price ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _measurementController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _isLoading
      ? const Center(child: CircularProgressIndicator())
      : SizedBox(
          width: double.maxFinite,
          height: 350,
          child: Card(
            surfaceTintColor: Colors.white,
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 36),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Material',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Expanded(
                                    child: TextField(
                                      controller: _titleController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromARGB(211, 245, 241, 241),
                                        hintText: 'Material',
                                        contentPadding: const EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 0),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 15),
                                  Expanded(
                                    child: TextField(
                                      controller: _amountController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromARGB(211, 245, 241, 241),
                                        hintText: 'Amount',
                                        contentPadding: const EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 0),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Einheit', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 15),
                                  Expanded(
                                    child: TextField(
                                      controller: _measurementController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromARGB(211, 245, 241, 241),
                                        hintText: 'Einheit',
                                        contentPadding: const EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 0),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Price /mengeneinheit',
                                        overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 15),
                                  Expanded(
                                    child: TextField(
                                      controller: _priceController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromARGB(211, 245, 241, 241),
                                        hintText: 'Price /mengeneinheit',
                                        contentPadding: const EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 0),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            _titleController.clear();
                            _amountController.clear();
                            _measurementController.clear();
                            _priceController.clear();
                            widget.onHideCard();
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Color.fromARGB(255, 231, 226, 226), width: 1.0),
                            ),
                          ),
                          child: const Text('Verwerfen', style: TextStyle(color: Colors.orange)),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            final title = _titleController.text;
                            final amount = _amountController.text;
                            final measurement = _measurementController.text;
                            final price = _priceController.text;
                            if (title.isNotEmpty && amount.isNotEmpty && measurement.isNotEmpty && price.isNotEmpty) {
                              widget.onSave(title, amount, measurement, price);
                              _titleController.clear();
                              _amountController.clear();
                              _measurementController.clear();
                              _priceController.clear();
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Fehlende Informationen'),
                                  content: const Text('Bitte füllen Sie alle Felder aus.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Color.fromARGB(255, 231, 226, 226), width: 1.0),
                            ),
                          ),
                          child: const Text('Speichern', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
