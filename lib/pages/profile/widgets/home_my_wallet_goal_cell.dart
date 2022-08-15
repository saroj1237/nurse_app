import 'package:flutter/material.dart';
import 'package:nurse_app/pages/profile/widgets/adaptive_button.dart';
import 'package:nurse_app/pages/profile/widgets/animated_progress_bar.dart';

class HomeMyWalletGoalCell extends StatelessWidget {
  final String title;
  final double goal;
  final double change;
  final int reached;
  final VoidCallback onPressed;

  const HomeMyWalletGoalCell({
    required this.title,
    required this.goal,
    required this.change,
    required this.reached,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveButton(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE8E7EC),
          ),
          borderRadius: BorderRadius.circular(12.0)),
      onPressed: onPressed,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitle(context),
          _buildGoal(context),
          const SizedBox(height: 4.0),
          _buildChange(context),
          const SizedBox(height: 10),
          AnimatedProgressBar(
            currentProgress: reached,
            summary: "Summary",
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      // style: AppTextStyles.caption2().copyWith(
      //   color: AppColors.navy.withOpacity(0.6),
      // ),
    );
  }

  Widget _buildGoal(BuildContext context) {
    return Text(
      'Goal',
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget _buildChange(BuildContext context) {
    return const Text(
      "Change",
      // style: AppTextStyles.caption2().copyWith(
      //   color: CurrencyFormatterUtil.instance.changeColor(
      //     value: change,
      //   ),
      // ),
    );
  }
}
