import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';

extension AyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      showExceptionAlertDialog(
          context: context, title: 'Error', exception: error);
    }
  }
}
