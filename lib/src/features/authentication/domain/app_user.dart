import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

/// Simple class representing the user UID and email.
class AppUser {
  const AppUser({
    required this.uid,
    this.email,
  });
  final String uid;
  final String? email;
}
