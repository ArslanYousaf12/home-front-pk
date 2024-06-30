import 'package:flutter_test/flutter_test.dart';

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
