import 'package:flutter/material.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/utils/constants.dart';

/// Primary button based on [ElevatedButton].
/// Useful for CTAs in the app.
/// @param text - text to display on the button.
/// @param isLoading - if true, a loading indicator will be displayed instead of
/// the text.
/// @param onPressed - callback to be called when the button is pressed.
class ActionLoadButton extends StatelessWidget {
  ActionLoadButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.color,
    this.textColor,
    this.iconData,
    this.width,
  });
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  Color? color;
  final Color? textColor;
  IconData? iconData;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      width: width ?? 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? kSecondaryColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              iconData ?? Icons.person,
              color: textColor ?? Colors.white,
              size: 30,
            ), // Leading icon
            // Button text
            isLoading
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: textColor == null ? Colors.white : textColor!,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
            // const Icon(
            //   Icons.arrow_forward,
            //   color: Color(0xFF182430),
            //   size: 30,
            // ), // Trailing icon
          ],
        ),
      ),
    );
  }
}
