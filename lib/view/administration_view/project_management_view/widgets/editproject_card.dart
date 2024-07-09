import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../models/project_models/project_entry_dm/project_entry_dm.dart';

class EditProjectCard extends StatefulWidget {
  final ProjectEntryDM project;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onDelete;
  final Function(int?, ProjectEntryDM) onUpdate;

  const EditProjectCard({
    super.key,
    required this.project,
    required this.isFirst,
    required this.isLast,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<EditProjectCard> createState() => _EditProjectCardState();
}

class _EditProjectCardState extends State<EditProjectCard> {
  late TextEditingController _titleController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _statusController;
  late TextEditingController _customerController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.project.title ?? '');
    _startDateController = TextEditingController(text: widget.project.dateOfStart ?? '');
    _endDateController = TextEditingController(text: widget.project.dateOfTermination ?? '');
    _statusController =
        TextEditingController(text: widget.project.projectStatusId?.toString() ?? '');
    _customerController = TextEditingController(text: widget.project.customerId?.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.project.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _statusController.dispose();
    _customerController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.symmetric(vertical: widget.isFirst ? 10 : 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Title', _titleController),
              _buildDetailRow('Start Date', _startDateController),
              _buildDetailRow('End Date', _endDateController),
              _buildDetailRow('Project Status', _statusController),
              _buildDetailRow('Customer Name', _customerController),
              _buildDetailRow('Description', _descriptionController),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: _saveChanges,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildDetailRow(String label, TextEditingController controller) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Text(
              '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
            ),
          ],
        ),
      );

  void _saveChanges() {
    // Prepare updated ProjectEntryVM object with the changed values
    ProjectEntryDM updatedProject = ProjectEntryDM(
      id: widget.project.id,
      title: _titleController.text,
      dateOfStart: _startDateController.text,
      dateOfTermination: _endDateController.text,
      projectStatusId: int.tryParse(_statusController.text),
      customerId: int.tryParse(_customerController.text),
      description: _descriptionController.text,
    );

    log('Updated Project JSON: ${updatedProject.toJson()}');
    // Call the onUpdate callback to save the changes
    widget.onUpdate(widget.project.id, updatedProject);
  }
}
