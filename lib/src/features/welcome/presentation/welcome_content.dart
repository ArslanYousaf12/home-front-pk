import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/constants.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          gapH12,
          const Text(
            'Please Select',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapH20,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionLoadButton(
                  text: 'Buy Service',
                  // color: kPrimaryColor,
                  onPressed: () {
                    context.goNamed(AppRoute.signInClient.name);
                  },
                ),
                gapH20,
                // ActionLoadButton(
                //   text: 'Constructor',
                //   color: kBackgroundColor,
                //   textColor: Colors.black,
                //   onPressed: () {
                //     context.goNamed(AppRoute.signInConstructor.name);
                //   },
                // ),
                // gapH20,
                ActionLoadButton(
                  text: 'Sell Service ',
                  iconData: Icons.construction,
                  color: kPrimaryColor,
                  onPressed: () {
                    context.goNamed(AppRoute.seller.name);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
       




// Column(
//         children: [

//           gapH64,
//           
//         ],
//       ),
//     );
//   }
// }