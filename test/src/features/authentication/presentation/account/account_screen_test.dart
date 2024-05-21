import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/action_text_button.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen.dart';

import '../../auth_robot.dart';

void main() {
  testWidgets('Cancel Logout', (tester) async {
    // GoRouter.optionURLReflectsImperativeAPIs = true;

    final r = AuthRobot(tester);
    await r.pumpAccountScreen();
    //find the logout Button and tap

    await r.tapLogoutButton();

    //Dialog Appears
    r.expectLogoutDialog();

    //Tap on Cancel button
    await r.tapCancelButton();
// check the cancel button cancel the dialog
    r.expectNoLogoutDialog();
  });
//   testWidgets('confirm Logout success ', (tester) async {
//     // GoRouter.optionURLReflectsImperativeAPIs = true;

//     final r = AuthRobot(tester);
//     await r.pumpAccountScreen();
//     //find the logout Button and tap

//     await r.tapLogoutButton();

//     //Dialog Appears
//     r.expectLogoutDialog();

//     //Tap on logoutDialogButton button
//     await r.tapLogoutDialogButton();
// // check the Logout successful
//     r.expectNoLogoutDialog();
//   });
}
