import 'package:disewainaja/app/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text; // Label pada tombol
  final VoidCallback onPressed; // Aksi saat tombol ditekan
  final Color? color; // Warna background tombol
  final Color? textColor; // Warna teks pada tombol
  final double? width; // Lebar tombol (opsional)
  final double? height; // Tinggi tombol (opsional)
  final double borderRadius; // Radius sudut tombol (default: 8)

  const DefaultButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, // Default tombol full width
      height: height ?? 48.0, // Default tinggi tombol 48
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary, // Warna background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white, // Default warna teks putih
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
