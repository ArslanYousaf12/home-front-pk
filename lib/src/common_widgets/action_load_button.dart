import 'package:flutter/material.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

/// Primary button based on [ElevatedButton].
/// Useful for CTAs in the app.
/// @param text - text to display on the button.
/// @param isLoading - if true, a loading indicator will be displayed instead of
/// the text.
/// @param onPressed - callback to be called when the button is pressed.
class ActionLoadButton extends StatelessWidget {
  const ActionLoadButton(
      {super.key,
      required this.text,
      this.isLoading = false,
      this.onPressed,
      required this.color});
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.arrow_back,
              color: Color(0xFF182430),
              size: 30,
            ), // Leading icon
            // Button text
            isLoading
                ? const CircularProgressIndicator()
                : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
            const Icon(
              Icons.arrow_forward,
              color: Color(0xFF182430),
              size: 30,
            ), // Trailing icon
          ],
        ),
      ),
    );
  }
}
