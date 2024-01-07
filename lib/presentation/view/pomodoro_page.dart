// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/presentation/bloc/pomo_bloc.dart';
import 'package:pomodoro/presentation/bloc/pomo_event.dart';

import '../bloc/pomo_state.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomoBloc(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PomoBloc, PomoState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.displayTime,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildButtons(context, state.status),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, PomoStatus status) {
    switch (status) {
      case PomoStatus.initial:
        return InitialButtons(context);
      case PomoStatus.running:
        return RunningButtons(context);
      case PomoStatus.paused:
        return PausedButtons(context);
    }
  }

  Widget InitialButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            context.read<PomoBloc>().add(const PomoResetPressed());
          },
          child: const Text('Reset'),
        ),
        const SizedBox(width: 30),
        OutlinedButton(
          onPressed: () {
            context.read<PomoBloc>().add(const PomoStartPressed());
          },
          child: const Text('Start'),
        )
      ],
    );
  }

  Widget PausedButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            context.read<PomoBloc>().add(const PomoResetPressed());
          },
          child: const Text('Reset'),
        ),
        const SizedBox(width: 30),
        OutlinedButton(
          onPressed: () {
            context.read<PomoBloc>().add(const PomoContinuePressed());
          },
          child: const Text('Continue'),
        )
      ],
    );
  }

  Widget RunningButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            context.read<PomoBloc>().add(const PomoPausePressed());
          },
          child: const Text('Pause'),
        )
      ],
    );
  }
}
