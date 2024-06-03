// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CardWidget extends StatefulWidget {
  final Function onSave; // Function to be called after the data is successfully posted
  final Function onHideCard;

  const CardWidget({required this.onSave, required this.onHideCard, super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final TextEditingController _leistungController = TextEditingController();
  final TextEditingController _preisController = TextEditingController();

  @override
  void dispose() {
    _leistungController.dispose();
    _preisController.dispose();
    super.dispose();
  }

  void createService() async {
    final String service = _leistungController.text;
    final String price = _preisController.text;
    if (service.isEmpty || price.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Alle Felder müssen ausgefüllt sein!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      const url = 'https://r-wa-happ-be.azurewebsites.net/api/service/create';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': service,
          'hourlyRate': price,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        widget.onSave(); // Notify the UI to update the list or handle UI logic
        Navigator.of(context).pop(); // Optionally close the modal after saving
      } else {
        throw Exception('Failed to create the service.');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: Text('Fehler beim Erstellen des Dienstes: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _leistungController,
                decoration: const InputDecoration(labelText: 'Leistung'),
              ),
              TextField(
                controller: _preisController,
                decoration: const InputDecoration(labelText: 'Preis/std'),
              ),
              TextButton(
                onPressed: createService,
                child: const Text('Speichern'),
              ),
            ],
          ),
        ),
      );
}
