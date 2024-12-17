// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/profile_dashboard/data/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreenNew extends ConsumerStatefulWidget {
  final String userType; // 'constructor' or 'designer'

  const ProfileScreenNew({
    required this.userType,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ProfileScreenNew> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreenNew> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  bool _isEditing = false;

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _experienceController;
  late TextEditingController _specialityController;
  late TextEditingController _aboutController;
  late TextEditingController _rateController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _experienceController = TextEditingController();
    _specialityController = TextEditingController();
    _aboutController = TextEditingController();
    _rateController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _experienceController.dispose();
    _specialityController.dispose();
    _aboutController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: profile.when(
        data: (profileData) {
          _updateControllers(profileData);
          return CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildProfileImage(profileData['imageUrl']),
                      const SizedBox(height: 24),
                      _buildProfileForm(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.userType == 'constructor'
              ? 'Constructor Profile'
              : 'Designer Profile',
          style: const TextStyle(color: Colors.black87),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade100,
                Colors.blue.shade50,
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(_isEditing ? Icons.save : Icons.edit),
          onPressed: () => _toggleEdit(),
        ),
      ],
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: _imageFile != null
              ? FileImage(_imageFile!)
              : (imageUrl != null
                      ? NetworkImage(imageUrl)
                      : const AssetImage('assets/default_profile.png'))
                  as ImageProvider,
        ),
        if (_isEditing)
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 20,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: _pickImage,
            ),
          ),
      ],
    );
  }

  Widget _buildProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputCard([
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              enabled: _isEditing,
              icon: Icons.person,
            ),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              enabled: _isEditing,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              enabled: false,
              icon: Icons.email,
            ),
          ]),
          const SizedBox(height: 16),
          _buildInputCard([
            _buildTextField(
              controller: _experienceController,
              label: 'Years of Experience',
              enabled: _isEditing,
              icon: Icons.work,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              controller: _specialityController,
              label: widget.userType == 'constructor'
                  ? 'Construction Speciality'
                  : 'Design Speciality',
              enabled: _isEditing,
              icon: Icons.star,
            ),
            _buildTextField(
              controller: _rateController,
              label: 'Hourly Rate (PKR)',
              enabled: _isEditing,
              icon: Icons.monetization_on,
              keyboardType: TextInputType.number,
            ),
          ]),
          const SizedBox(height: 16),
          _buildInputCard([
            _buildTextField(
              controller: _aboutController,
              label: 'About Me',
              enabled: _isEditing,
              icon: Icons.info,
              maxLines: 4,
            ),
          ]),
          if (widget.userType == 'constructor') ...[
            const SizedBox(height: 16),
            _buildInputCard([
              _buildLicenseSection(),
            ]),
          ],
          const SizedBox(height: 24),
          if (_isEditing)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save Changes'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: !enabled,
          fillColor: enabled ? null : Colors.grey[100],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLicenseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'License & Certifications',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (_isEditing)
          ElevatedButton.icon(
            onPressed: () {
              // Implement license upload
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload License'),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _toggleEdit() {
    if (_isEditing) {
      _saveProfile();
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _updateControllers(Map<String, dynamic> profileData) {
    _nameController.text = profileData['name'] ?? '';
    _phoneController.text = profileData['phone'] ?? '';
    _emailController.text = profileData['email'] ?? '';
    _experienceController.text = profileData['experience']?.toString() ?? '';
    _specialityController.text = profileData['speciality'] ?? '';
    _aboutController.text = profileData['about'] ?? '';
    _rateController.text = profileData['hourlyRate']?.toString() ?? '';
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await ref
            .read(profileRepositoryProvider)
            .uploadProfileImage(_imageFile!);
      }

      await ref.read(profileRepositoryProvider).updateProfile({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'experience': int.tryParse(_experienceController.text) ?? 0,
        'speciality': _specialityController.text,
        'about': _aboutController.text,
        'hourlyRate': double.tryParse(_rateController.text) ?? 0,
        if (imageUrl != null) 'imageUrl': imageUrl,
      });

      setState(() {
        _isEditing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }
}
