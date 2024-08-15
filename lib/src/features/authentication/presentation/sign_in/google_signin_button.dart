import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/custome_outline_button.dart';
import 'package:home_front_pk/src/features/authentication/presentation/shared/google_signIn_controller.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class GoogleLoginButton extends ConsumerWidget {
  GoogleLoginButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomOutlineButton(
      onTap: onPressed,
      borderColor: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/signin/google.png',
              height: 25,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              "Continue with Google",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
