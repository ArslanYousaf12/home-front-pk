import 'package:home_front_pk/src/localization/string_hardcoded.dart';

//Not Using This file Because
//All the Error not handle using
//Sealed class instead of enum
//sealed classes are introduce in
// dart 3.0 and

//not using this enum due to
//its limitation

/// An exception type to represent all client-side errors that can be generated
/// by the app
enum AppExceptionEnum {
  // Auth
  emailAlreadyInUse('email-already-in-use'),
  //above emailAlreadyInUse is enumeration value type
  //and 'email-already-in-use' use code that send to
  //backend for error logging
  weakPassword('weak-password'),
  wrongPassword('wrong-password'),
  userNotFound('user-not-found'),
  // Cart
  cartSyncFailed('cart-sync-failed'),
  // Checkout
  paymentFailureEmptyCart('payment-failure-empty-cart'),
  // Orders
  parseOrderFailure('parse-order-failure');

  const AppExceptionEnum(this.code);

  /// A value that can be sent to the backend when logging the error
  final String code;

  /// A user-friendly message that can be shown in the UI.
  // * This needs to be a getter variable or a method since the error message
  // * can't be declared as const if it's localized
  String get message {
    switch (this) {
      // Auth
      case emailAlreadyInUse:
        return 'Email already in use'.hardcoded;
      case weakPassword:
        return 'Password is too weak'.hardcoded;
      case wrongPassword:
        return 'Wrong password'.hardcoded;
      case userNotFound:
        return 'User not found'.hardcoded;
      // Cart
      case cartSyncFailed:
        return 'An error has occurred while updating the shopping cart'
            .hardcoded;
      // Checkout
      case paymentFailureEmptyCart:
        return 'Can\'t place an order if the cart is empty'.hardcoded;
      // Orders
      case parseOrderFailure:
        return 'Could not parse order status'.hardcoded;
      default:
        return 'Unknown error'.hardcoded;
    }
  }
}
