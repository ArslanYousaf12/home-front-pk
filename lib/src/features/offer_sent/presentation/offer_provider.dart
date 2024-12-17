// lib/src/features/offers/presentation/providers/offer_provider.dart
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/offer_sent/data/offer_repo.dart';
import 'package:home_front_pk/src/features/offer_sent/domain/offer_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

final offerRepositoryProvider = Provider<OfferRepository>((ref) {
  return OfferRepository();
});

final sentOffersProvider = StreamProvider<List<Offer>>((ref) {
  final repository = ref.watch(offerRepositoryProvider);
  return repository.getOffersSent();
});

final receivedOffersProvider = StreamProvider<List<Offer>>((ref) {
  final repository = ref.watch(offerRepositoryProvider);
  return repository.getOffersReceived();
});

// Filter provider for offer status
final offerStatusFilterProvider = StateProvider<String>((ref) => 'all');

// Filtered offers provider
final filteredSentOffersProvider = Provider<AsyncValue<List<Offer>>>((ref) {
  final offers = ref.watch(sentOffersProvider);
  final filter = ref.watch(offerStatusFilterProvider);

  return offers.whenData((offerList) {
    if (filter == 'all') return offerList;
    return offerList.where((offer) => offer.status == filter).toList();
  });
});

// Offer controller for actions
final offerControllerProvider = Provider((ref) {
  final repository = ref.watch(offerRepositoryProvider);

  return OfferController(repository);
});

class OfferController {
  final OfferRepository _repository;

  OfferController(this._repository);

  Future<void> updateStatus(String offerId, String status) async {
    await _repository.updateOfferStatus(offerId, status);
  }

  Future<void> updateMilestone(
    String offerId,
    int milestoneIndex,
    String status,
  ) async {
    await _repository.updateMilestoneStatus(offerId, milestoneIndex, status);
  }

  Future<String> createOffer({
    required String jobId,
    required String title,
    required String description,
    required double estimatedCost,
    required int estimatedDays,
    required String location,
    required List<Map<String, dynamic>> milestones,
    required List<String> attachments,
  }) async {
    return _repository.createOffer(
      jobId: jobId,
      title: title,
      description: description,
      estimatedCost: estimatedCost,
      estimatedDays: estimatedDays,
      location: location,
      milestones: milestones,
      attachments: attachments,
    );
  }
}
// lib/src/features/offers/presentation/offer_screen.dart

class OfferScreen extends ConsumerStatefulWidget {
  final String jobId;
  final String userId;

  const OfferScreen({
    required this.jobId,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends ConsumerState<OfferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _estimatedCostController = TextEditingController();
  final _estimatedDaysController = TextEditingController();
  final _locationController = TextEditingController();
  List<Map<String, dynamic>> _milestones = [];
  List<String> _attachments = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _estimatedCostController.dispose();
    _estimatedDaysController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Offer'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'Project Details',
                  children: [
                    _buildTextField(
                      controller: _titleController,
                      label: 'Project Title',
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter a title'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      maxLines: 3,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter a description'
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Cost & Timeline',
                  children: [
                    _buildTextField(
                      controller: _estimatedCostController,
                      label: 'Estimated Cost (PKR)',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Please enter cost';
                        if (double.tryParse(value!) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _estimatedDaysController,
                      label: 'Estimated Days',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter estimated days';
                        }
                        if (int.tryParse(value!) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Location',
                  children: [
                    _buildTextField(
                      controller: _locationController,
                      label: 'Project Location',
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter location'
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildMilestonesSection(),
                const SizedBox(height: 24),
                _buildAttachmentsSection(),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _submitOffer,
                    child: const Text('Submit Offer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }

  Widget _buildMilestonesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Milestones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: _addMilestone,
              icon: const Icon(Icons.add),
              label: const Text('Add Milestone'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _milestones.length,
          itemBuilder: (context, index) {
            return _MilestoneCard(
              milestone: _milestones[index],
              onDelete: () => _removeMilestone(index),
              onEdit: (updated) => _updateMilestone(index, updated),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAttachmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Attachments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: _addAttachment,
              icon: const Icon(Icons.attach_file),
              label: const Text('Add File'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _attachments
              .map((url) => _AttachmentChip(
                    url: url,
                    onDelete: () => _removeAttachment(url),
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _addMilestone() {
    showDialog(
      context: context,
      builder: (context) => _MilestoneDialog(
        onSave: (milestone) {
          setState(() {
            _milestones.add(milestone);
          });
        },
      ),
    );
  }

  void _removeMilestone(int index) {
    setState(() {
      _milestones.removeAt(index);
    });
  }

  void _updateMilestone(int index, Map<String, dynamic> updated) {
    setState(() {
      _milestones[index] = updated;
    });
  }

  Future<void> _addAttachment() async {
    await _pickAndUploadFile();
  }

  void _removeAttachment(String url) {
    setState(() {
      _attachments.remove(url);
    });
  }

  Future<void> _submitOffer() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final offerId = await ref.read(offerControllerProvider).createOffer(
            jobId: widget.jobId,
            title: _titleController.text,
            description: _descriptionController.text,
            estimatedCost: double.parse(_estimatedCostController.text),
            estimatedDays: int.parse(_estimatedDaysController.text),
            location: _locationController.text,
            milestones: _milestones,
            attachments: _attachments,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Offer submitted successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting offer: $e')),
      );
    }
  }
}

class _MilestoneDialog extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? initialData;

  const _MilestoneDialog({
    required this.onSave,
    this.initialData,
  });

  @override
  State<_MilestoneDialog> createState() => _MilestoneDialogState();
}

class _MilestoneDialogState extends State<_MilestoneDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _daysController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _titleController.text = widget.initialData!['title'];
      _descriptionController.text = widget.initialData!['description'];
      _amountController.text = widget.initialData!['amount'].toString();
      _daysController.text = widget.initialData!['daysToComplete'].toString();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.initialData == null ? 'Add Milestone' : 'Edit Milestone'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter description' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount (PKR)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter amount';
                  if (double.tryParse(value!) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _daysController,
                decoration:
                    const InputDecoration(labelText: 'Days to Complete'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter days';
                  if (int.tryParse(value!) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave({
                'title': _titleController.text,
                'description': _descriptionController.text,
                'amount': double.parse(_amountController.text),
                'daysToComplete': int.parse(_daysController.text),
                'status': 'pending',
              });
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  final Map<String, dynamic> milestone;
  final VoidCallback onDelete;
  final Function(Map<String, dynamic>) onEdit;

  const _MilestoneCard({
    required this.milestone,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    milestone['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => _showEditDialog(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(milestone['description']),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PKR ${NumberFormat('#,###').format(milestone['amount'])}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  '${milestone['daysToComplete']} days',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Continuing from previous _MilestoneCard implementation...

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _MilestoneDialog(
        initialData: milestone,
        onSave: onEdit,
      ),
    );
  }
}

class _AttachmentChip extends StatelessWidget {
  final String url;
  final VoidCallback onDelete;

  const _AttachmentChip({
    required this.url,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    String fileName = url.split('/').last;
    if (fileName.length > 20) {
      fileName = '${fileName.substring(0, 17)}...';
    }

    return Chip(
      label: Text(fileName),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: onDelete,
    );
  }
}

// Add a service class for file handling
class FileService {
  static Future<String> uploadFile(File file) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('proposals').child(fileName);

      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }
}

// Add ImagePicker functionality
extension FilePickerExtension on _OfferScreenState {
  Future<void> _pickAndUploadFile() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Show loading indicator
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final file = File(pickedFile.path);
        final downloadUrl = await FileService.uploadFile(file);

        setState(() {
          _attachments.add(downloadUrl);
        });

        // Hide loading indicator
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      // Hide loading indicator
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading file: $e')),
        );
      }
    }
  }
}
