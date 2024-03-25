/// Simple class representing the user UID and email.
class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    required this.role,
  });
  final String uid;
  final String? email;
  final String role;
}
