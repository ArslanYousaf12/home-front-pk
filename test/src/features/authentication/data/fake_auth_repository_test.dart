import 'package:flutter_test/flutter_test.dart';
import 'package:home_front_pk/src/features/authentication/data/fake_auth_repository.dart';
import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';

void main() {
  const String email = 'test@gmail.com';
  const String password = '12345678';
  final user = AppUser(uid: email.split('').reversed.join(), email: email);

  FakeAuthRepository makeAuthRepo() => FakeAuthRepository(addDelay: false);
  group('Fake Auth Repo', () {
    test('CurrentUser is null', () {
      final authRepo = makeAuthRepo();
      expect(authRepo.currentUser, null);
      expect(authRepo.authStateChange(), emits(null));
    });
    test('CurrentUser is  not null after signIn', () async {
      final authRepo = makeAuthRepo();
      await authRepo.signInWithEmailAndPassword(email, password);
      expect(authRepo.currentUser, user);
      expect(authRepo.authStateChange(), emits(user));
    });

    // test('CurrentUser is   null after signOut', () async {
    //   final authRepo = makeAuthRepo();
    //   await authRepo.signInWithEmailAndPassword(email, password);

    //   expect(
    //       authRepo.authStateChange(),
    //       emitsInOrder([
    //         user,
    //         null,
    //       ]));
    //   await authRepo.signOut();
    //   expect(authRepo.currentUser, null);
    // });

    test('CurrentUser is   null after signOut', () async {
      final authRepo = makeAuthRepo();
      await authRepo.signInWithEmailAndPassword(email, password);
      expect(authRepo.currentUser, user);
      expect(authRepo.authStateChange(), emits(user));
      await authRepo.signOut();
      expect(authRepo.currentUser, null);
      expect(authRepo.authStateChange(), emits(null));
    });
  });
}
