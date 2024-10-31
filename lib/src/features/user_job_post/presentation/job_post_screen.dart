// lib/presentation/screens/create_job_post_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/user_job_post_controller.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class CreateJobPostScreen extends ConsumerStatefulWidget {
  const CreateJobPostScreen({super.key});

  @override
  ConsumerState<CreateJobPostScreen> createState() =>
      _CreateJobPostScreenState();
}

class _CreateJobPostScreenState extends ConsumerState<CreateJobPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  List<File> _selectedImages = [];
  String _category = 'constructor';
  double _estimatedCost = 0;
  double _budget = 0;

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _selectedImages
            .addAll(pickedFiles.map((xFile) => File(xFile.path)).toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobPostState = ref.watch(jobPostControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job Post'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: const [
                DropdownMenuItem(
                    value: 'constructor', child: Text('Constructor')),
                DropdownMenuItem(value: 'designer', child: Text('Designer')),
              ],
              onChanged: (value) => setState(() => _category = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            // Estimated Cost Field
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Estimated Cost'),
              onChanged: (value) {
                setState(() {
                  _estimatedCost = double.tryParse(value) ?? 0;
                });
              },
              validator: (value) => (double.tryParse(value ?? '') ?? 0) <= 0
                  ? 'Enter valid cost'
                  : null,
            ),
            const SizedBox(height: 16),
            // Budget Field
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Budget'),
              onChanged: (value) {
                setState(() {
                  _budget = double.tryParse(value) ?? 0;
                });
              },
              validator: (value) {
                final budget = double.tryParse(value ?? '') ?? 0;
                if (budget <= 0) return 'Enter valid budget';
                if (budget < _estimatedCost) {
                  return 'Budget cannot be less than estimated cost';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImages,
              icon: const Icon(Icons.image),
              label: const Text('Select Images'),
            ),
            if (_selectedImages.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          Image.file(_selectedImages[index]),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _selectedImages.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: jobPostState.isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await ref
                            .read(jobPostControllerProvider.notifier)
                            .createJobPost(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              images: _selectedImages,
                              location: _locationController.text,
                              category: _category,
                              estimatedCost: _estimatedCost,
                              budget: _budget,
                            );

                        // ignore: use_build_context_synchronously
                        context.goNamed(AppRoute.userJobs.name);
                      }
                    },
              child: jobPostState.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Create Job Post'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
