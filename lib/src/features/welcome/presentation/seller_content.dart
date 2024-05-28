import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';

import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/constants.dart';

class SellerContent extends StatelessWidget {
  const SellerContent({super.key});

  @override
  Widget build(BuildContext context) {
    Widget orDivider() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
        child: Row(
          children: [
            Flexible(
              child: Container(
                height: 1,
                color: kPrimaryColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: 1,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              'Sell Perfection',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          gapH12,
          Text(
            'Please Select Your role as Seller',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            softWrap: true,
          ),
          gapH20,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionLoadButton(
                  text: 'Constructor',
                  // color: kPrimaryColor,
                  iconData: Icons.construction,
                  onPressed: () {
                    context.goNamed(AppRoute.signInConstructor.name);
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
                orDivider(),
                gapH20,
                ActionLoadButton(
                  text: 'Designer',
                  iconData: Icons.design_services,
                  color: kPrimaryColor,
                  onPressed: () {
                    context.goNamed(AppRoute.signInDesigner.name);
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