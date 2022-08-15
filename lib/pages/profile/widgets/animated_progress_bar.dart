import 'package:flutter/material.dart';
import 'package:nurse_app/pages/profile/widgets/progress_bar.dart';

class AnimatedProgressBar extends StatefulWidget {
  // Value between 0 and 100
  final int currentProgress;
  final Duration? duration;
  final String? summary;

  const AnimatedProgressBar({
    required this.currentProgress,
    this.duration,
    this.summary,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with TickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final Animation<int> animation;

  @override
  void initState() {
    super.initState();
    animation = IntTween(
      begin: 0,
      end: widget.currentProgress,
    ).animate(animationController);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => ProgressBar(
        currentProgress: animation.value,
        summary: widget.summary,
      ),
    );
  }
}
