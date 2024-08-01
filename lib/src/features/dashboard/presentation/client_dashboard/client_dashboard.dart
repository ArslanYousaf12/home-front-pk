import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/common_widgets/home_app_bar.dart';
import 'package:home_front_pk/src/common_widgets/persons_card.dart';
import 'package:home_front_pk/src/common_widgets/responsive_center.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/constructor_repository.dart';

import 'package:home_front_pk/src/features/user-management/presentation/sliver_products_grid.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/constants.dart';

class ClientDashboard extends ConsumerStatefulWidget {
  const ClientDashboard({super.key});

  @override
  ConsumerState<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends ConsumerState<ClientDashboard> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  // singleton
  // final constructors = FakeConstructorRepository.instance.getConstructorList();
  @override
  Widget build(BuildContext context) {
    //using popScope to prevent user to goBack to sigin Screen
    // without logout

    return PopScope(
      canPop: false,
      child: Scaffold(
        //AppBar Code

        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: HomeAppBar(
            titles: 'Dashboard ',
            userRole: 'client',
            notificationCallBack: () =>
                showNotImplementedAlertDialog(context: context),
            logOut: () async {
              final goRouter = GoRouter.of(context);
              final logout = await showAlertDialog(
                context: context,
                title: 'Are you sure?'.hardcoded,
                cancelActionText: 'Cancel'.hardcoded,
                defaultActionText: 'Logout'.hardcoded,
              );
              if (logout == true) {
                final success = await ref
                    .read(accountScreenControllerProvider.notifier)
                    .signOut();
                if (success) {
                  goRouter.pop();
                  goRouter.pop();
                }
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      dashboardCard(
                        title: 'Post jobs',
                        iconData: Icons.work,
                      ),
                      gapW16,
                      dashboardCard(
                        title: 'Accept Offers',
                        iconData: Icons.local_offer_rounded,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
              gapH24,
              //constructor heading
              const Padding(
                padding: EdgeInsets.only(left: 50, top: 20),
                child: Text(
                  'Constructors',
                  style: TextStyle(
                    fontSize: 15, // Increased font size for emphasis
                    fontWeight: FontWeight.w600, // Bold font weight for impact
                    color: Colors.black, // Example color
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              gapH12,

              //Slider code

              Consumer(
                builder: (context, ref, child) {
                  final constructorsValue =
                      ref.watch(constructorsListStreamProvider);
                  return AsyncValueWidget(
                      value: constructorsValue,
                      data: (constructors) {
                        if (constructors.isEmpty) {
                          return const Center(
                            child: Text(
                              'No Constructors found',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        } else {
                          return CarouselSlider.builder(
                            itemCount: constructors.length,
                            itemBuilder: (context, index, realIndex) {
                              final constructor = constructors[index];
                              final title = constructor.title;
                              final location = constructor.location;
                              final id = constructor.id;
                              final name = constructor.name;
                              return PersonCard(
                                title: title,
                                id: id,
                                location: location,
                                name: name,
                                contact: () {
                                  context.goNamed(
                                      AppRoute.constructorDetailed.name,
                                      pathParameters: {'id': constructor.id});
                                },
                              );
                            },
                            options: CarouselOptions(
                              height: 320,
                              enableInfiniteScroll: true,
                              // autoPlay: true,
                              // autoPlayInterval: Duration(seconds: 3),
                              // autoPlayAnimationDuration: Duration(milliseconds: 800),
                              // autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              viewportFraction: 0.8,
                            ),
                          );
                        }
                      });
                },
              ),
              gapH32,
              // Padding(
              //   padding: const EdgeInsets.only(left: 50),
              //   child: ActionLoadButton(
              //     text: 'Designer',
              //     onPressed: () {
              //       context.goNamed(AppRoute.designerList.name);
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 26, left: 15, right: 15),
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed(AppRoute.designerList.name);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                      backgroundColor: kSecondaryColor,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  child: const Text('Designers'),
                ),
              ),

              //Incoming Jobs button

              // Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Column(
              //       children: [
              //         ActionLoadButton(
              //           text: 'Jobs',
              //           textColor: Colors.black,
              //           color: Colors.green.shade200,
              //           onPressed: () {
              //             showNotImplementedAlertDialog(context: context);
              //           },
              //         ),
              //         gapH12,

              //         //View designer Button

              //         ActionLoadButton(
              //           text: 'Designer',
              //           color: const Color(0xFFF6F7C4),
              //           textColor: Colors.black,
              //           onPressed: () {
              //             context.goNamed(AppRoute.designerList.name);
              //           },
              //         ),
              //       ],
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}

class dashboardCard extends StatelessWidget {
  const dashboardCard({
    super.key,
    required this.title,
    required this.iconData,
    this.color,
  });
  final String title;
  final IconData iconData;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 150,
      child: Card(
          color: color ?? Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                color: color != null ? Colors.white : Colors.green.shade400,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w100,
                  color: color != null ? Colors.white : Colors.black,
                ),
              ),
            ],
          )),
    );
  }
}
