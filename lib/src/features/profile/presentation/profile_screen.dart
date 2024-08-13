import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:home_front_pk/src/features/profile/data/profile_image_upload_repository.dart';
import 'package:home_front_pk/src/features/profile/presentation/profile_screen_controller.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

// Add these imports
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Add this provider
final profileImageUploadRepoProvider =
    Provider((ref) => ProfileImageUploadRepo());

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? _imageFile;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage({ImageSource source = ImageSource.gallery}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
    );
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final repo = ref.read(profileImageUploadRepoProvider);
    final userId =
        'xpZ5CzE4MPUSgBuGtQtdOoOO9t33'; // Replace with actual user ID
    final url = await repo.fetchProfileImage(userId);
    if (url != null) {
      setState(() {
        _imageUrl = url;
      });
    }
  }

  Future<void> _selectImage() async {
    File? imageFile = await pickImage();

    final userId =
        'xpZ5CzE4MPUSgBuGtQtdOoOO9t33'; // Replace with actual user ID
    final downloadUrl = await ref
        .read(profileScreenControllerProvider.notifier)
        .uploadImage(userId, imageFile!);

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
        _imageUrl = null; // Clear the previous URL
      });
      // Upload the new image
      final newUrl = downloadUrl;
      if (newUrl != null) {
        setState(() {
          _imageUrl = newUrl;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(routerProvider);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: _selectImage,
                        child: CircleAvatar(
                          maxRadius: 35,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : _imageUrl != null
                                  ? NetworkImage(_imageUrl!)
                                  : const AssetImage('assets/person.jpeg')
                                      as ImageProvider,
                          child: _imageFile == null && _imageUrl == null
                              ? const Icon(Icons.add_a_photo,
                                  color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                    gapW16,
                    const Flexible(
                      flex: 2,
                      child: ListTile(
                        title: Text(
                          'Arslan Yousaf',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        subtitle: Text('Id#12321.USER'),
                      ),
                    ),
                  ],
                ),
              ),
              // ... Rest of the code remains the same
              Expanded(
                  child: Column(
                children: [
                  Card(
                    elevation: 1,
                    color: Colors.white,
                    child: ListTile(
                      leading: const Icon(
                        Icons.attach_money,
                        size: 25,
                      ),
                      title: const Text(
                        'My Balance',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: const Text(
                        '\$1540',
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {},
                    ),
                  ),
                  ProfileCard(
                    icon: Icons.work_history_outlined,
                    title: 'My History',
                    onTap: () {},
                  ),
                  ProfileCard(
                    title: 'Setting',
                    icon: Icons.settings,
                    onTap: () {},
                  ),
                  ProfileCard(
                    title: 'About',
                    icon: Icons.assignment_late_outlined,
                    onTap: () {},
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ActionLoadButton(
                  text: 'Logout',
                  iconData: Icons.logout_outlined,
                  onPressed: () async {
                    final logout = await showAlertDialog(
                      context: context,
                      title: 'Are your Sure'.hardcoded,
                      cancelActionText: 'Cancel'.hardcoded,
                      defaultActionText: 'Logout'.hardcoded,
                    );
                    if (logout == true) {
                      final success = await ref
                          .read(accountScreenControllerProvider.notifier)
                          .signOut();
                      if (success) {
                        goRouter.pop();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ... Rest of the code (ProfileCard class) remains the same
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          icon,
          size: 25,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        onTap: onTap,
        // subtitle: Text(''),
      ),
    );
  }
}
