import 'package:flutter/material.dart';
import 'package:pomodoro/presentation/bloc/pomodoro/pomo_state.dart';

class PomoButtons extends StatelessWidget {
  const PomoButtons({
    super.key,
    required this.status,
    this.onStartPressed,
    this.onContinuePressed,
    this.onPausePressed,
    this.onResetPressed,
    this.onNextPressed,
  });

  final PomoStatus status;
  final VoidCallback? onStartPressed;
  final VoidCallback? onContinuePressed;
  final VoidCallback? onPausePressed;
  final VoidCallback? onResetPressed;
  final VoidCallback? onNextPressed;

  @override
  Widget build(BuildContext context) {
    return _buildButtons(context, status);
  }

  Widget _buildButtons(BuildContext context, PomoStatus status) {
    switch (status) {
      case PomoStatus.initial:
        return InitialButtons(
          onResetPressed: onResetPressed,
          onStartPressed: onStartPressed,
          onNextPressed: onNextPressed,
        );
      case PomoStatus.running:
        return RunningButton(
          onPausePressed: onPausePressed,
        );
      case PomoStatus.paused:
        return PauseButtons(
          onResetPressed: onResetPressed,
          onContinuePressed: onContinuePressed,
          onNextPressed: onNextPressed,
        );
    }
  }
}

class InitialButtons extends StatelessWidget {
  const InitialButtons({
    super.key,
    double? mainIconSize,
    double? subIconSize,
    this.onStartPressed,
    this.onResetPressed,
    this.onNextPressed,
  })  : mainIconSize = mainIconSize ?? 50,
        subIconSize = subIconSize ?? 30;

  final double mainIconSize;
  final double subIconSize;
  final VoidCallback? onResetPressed;
  final VoidCallback? onStartPressed;
  final VoidCallback? onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filledTonal(
          onPressed: onResetPressed,
          icon: const Icon(Icons.replay),
          iconSize: subIconSize,
          tooltip: 'Reset',
        ),
        const SizedBox(width: 8),
        IconButton.filled(
          onPressed: onStartPressed,
          icon: const Icon(Icons.play_arrow),
          iconSize: mainIconSize,
          tooltip: 'Start',
        ),
        const SizedBox(width: 8),
        IconButton.filledTonal(
          onPressed: onNextPressed,
          icon: const Icon(Icons.skip_next),
          iconSize: subIconSize,
          tooltip: 'Next',
        )
      ],
    );
  }
}

class PauseButtons extends StatelessWidget {
  const PauseButtons({
    super.key,
    double? mainIconSize,
    double? subIconSize,
    this.onResetPressed,
    this.onContinuePressed,
    this.onNextPressed,
  })  : mainIconSize = mainIconSize ?? 50,
        subIconSize = subIconSize ?? 30;

  final double mainIconSize;
  final double subIconSize;
  final VoidCallback? onResetPressed;
  final VoidCallback? onContinuePressed;
  final VoidCallback? onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filledTonal(
          onPressed: onResetPressed,
          icon: const Icon(Icons.replay),
          iconSize: subIconSize,
          tooltip: 'Reset',
        ),
        const SizedBox(width: 8),
        IconButton.filled(
          onPressed: onContinuePressed,
          icon: const Icon(Icons.play_arrow),
          iconSize: mainIconSize,
          tooltip: 'Continue',
        ),
        const SizedBox(width: 8),
        IconButton.filledTonal(
          onPressed: onNextPressed,
          icon: const Icon(Icons.skip_next),
          iconSize: subIconSize,
          tooltip: 'Next',
        )
      ],
    );
  }
}

class RunningButton extends StatelessWidget {
  const RunningButton({super.key, double? mainIconSize, this.onPausePressed})
      : mainIconSize = mainIconSize ?? 50;

  final double mainIconSize;
  final VoidCallback? onPausePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filled(
          onPressed: onPausePressed,
          icon: const Icon(Icons.pause),
          iconSize: mainIconSize,
          tooltip: 'Pause',
        )
      ],
    );
  }
}
