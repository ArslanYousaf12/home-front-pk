import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/exceptions/app_exception.dart';
import 'package:home_front_pk/src/exceptions/error_logger.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

//this file has link with main file
class AsyncErrorLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    final errorLogger = container.read(errorLoggerProvider);
    final error = _findError(newValue);
    if (error != null) {
      if (error.error is AppException) {
        // only prints the AppException data
        // debugPrint(error.error.toString());
        errorLogger.logAppException(error.error as AppException);
      } else {
        // prints everything including the stack trace
        // debugPrint(error.toString());
        errorLogger.logError(error.error, error.stackTrace);
      }
    }
  }
}

AsyncError<dynamic>? _findError(Object? value) {
  if (value is EmailPasswordSignInState && value.value is AsyncError) {
    return value.value as AsyncError;
  } else if (value is AsyncError) {
    return value;
  } else {
    return null;
  }
}
