import 'package:disewainaja/app/shared/styles/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  final double size;

  const Loading({
    super.key,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: AppColors.primary,
          size: size,
        ),
      ),
    );
  }
}
