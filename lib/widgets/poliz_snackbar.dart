import 'package:flutter/material.dart';
import '../themes/color_schema.dart';

class PolizSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        Color? backgroundColor,
        Color? textColor,
        Duration duration = const Duration(seconds: 3),
        IconData? icon,
        SnackBarAction? action,
      }) {
    final bgColor = backgroundColor ?? Colors.black87;
    final txtColor = textColor ?? Colors.white;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: txtColor, size: 24),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: txtColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        action: action,
        elevation: 6,
      ),
    );
  }

  static void showSuccess(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
      }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.green.shade600,
      textColor: Colors.white,
      icon: Icons.check_circle_outline,
      duration: duration,
    );
  }

  static void showError(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 4),
      }) {
    show(
      context,
      message: message,
      backgroundColor: SaintColors.error,
      textColor: Colors.white,
      icon: Icons.error_outline,
      duration: duration,
    );
  }

  static void showWarning(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
      }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.orange.shade600,
      textColor: Colors.white,
      icon: Icons.warning_amber_outlined,
      duration: duration,
    );
  }

  static void showInfo(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
      }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.blue.shade600,
      textColor: Colors.white,
      icon: Icons.info_outline,
      duration: duration,
    );
  }
}