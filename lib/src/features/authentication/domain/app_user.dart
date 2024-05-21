// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

/// Simple class representing the user UID and email.
class AppUser {
  const AppUser({
    required this.uid,
    this.email,
  });
  final String uid;
  final String? email;

  @override
  String toString() => 'AppUser(uid: $uid, email: $email)';

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid && other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;
}
