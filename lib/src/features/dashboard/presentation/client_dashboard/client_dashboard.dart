import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/common_widgets/custom_talent_card.dart';
import 'package:home_front_pk/src/common_widgets/cutome_curved_container.dart';
import 'package:home_front_pk/src/common_widgets/home_app_bar.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/constants/ktest_constructor_card.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:home_front_pk/src/features/dashboard/data/fake_constructor_repo.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class ClientDashboard extends ConsumerStatefulWidget {
  const ClientDashboard({super.key});

  @override
  ConsumerState<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends ConsumerState<ClientDashboard> {
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
            titles: 'Client Dashboard',
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
                }
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Welcome Back Section
              CustomCurvedContainer(
                gradientColors: LinearGradient(
                  colors: [
                    Colors.green.shade100,
                    Colors.green.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome Back',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    gapH8,
                    ElevatedButton(
                        onPressed: () {
                          showNotImplementedAlertDialog(context: context);
                        },
                        child: const Text('Cost Calculator'))
                  ],
                ),
              ),
              gapH12,
              //constructor heading
              const Text(
                'Constructors',
                style: TextStyle(
                  fontSize: 25, // Increased font size for emphasis
                  fontWeight: FontWeight.bold, // Bold font weight for impact
                  color: Colors.white, // Example color
                ),
              ),
              gapH12,

              //Slider code

              Consumer(
                builder: (context, ref, child) {
                  // final constructorRepository =
                  //     ref.watch(constructorRepositoryProvider);
                  // final constructors = constructorRepository.getConstructorList();
                  final constructorsValue =
                      ref.watch(constructorsListStreamProvider);
                  return AsyncValueWidget(
                    value: constructorsValue,
                    data: (constructors) => CarouselSlider.builder(
                      itemCount: constructors.length,
                      itemBuilder: (context, index, realIndex) {
                        final constructor = constructors[index];
                        final title = constructor.title;
                        final icon = constructor.icon;
                        final description = constructor.detail;
                        return CustomTalentCard(
                          title: title,
                          icon: icon,
                          description: description,
                          onPressed: () {
                            context.goNamed(AppRoute.constructorDetailed.name,
                                pathParameters: {'id': constructor.id});
                          },
                        );
                      },
                      options: CarouselOptions(
                        height: 250,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        // autoPlayInterval: Duration(seconds: 3),
                        // autoPlayAnimationDuration: Duration(milliseconds: 800),
                        // autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                      ),
                    ),
                  );
                },
              ),
              gapH12,

              //Incoming Jobs button

              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ActionLoadButton(
                        text: 'Incomming Jobs',
                        textColor: Colors.black,
                        color: Colors.green.shade200,
                        onPressed: () {
                          showNotImplementedAlertDialog(context: context);
                        },
                      ),
                      gapH12,

                      //View designer Button

                      ActionLoadButton(
                        text: 'View Designer',
                        color: const Color(0xFFF6F7C4),
                        textColor: Colors.black,
                        onPressed: () {
                          context.goNamed(AppRoute.designerList.name);
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
