import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    this.onTap,
    this.buttonTitle = "Go Back",
    this.borderColor = Colors.black,
    this.titleColor = Colors.white,
    this.child,
    this.icon,
  });
  final Function()? onTap;
  final String buttonTitle;
  final Color? borderColor;
  final Color? titleColor;
  final Widget? child;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor!),
      ),
      onPressed: onTap,
      child: child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(
                  width: 12,
                )
              ],
              Text(
                buttonTitle,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: titleColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
    );
  }
}
