// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                  _buildSessions(context, state),
                  _buildButtons(context, state.status),
                  OutlinedButton(
                    onPressed: () =>
                        context.read<PomoBloc>().add(const PomoNextPressed()),
                    child: const Text('Next'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSessions(BuildContext context, PomoState state) {
    print(
        'build Sessions: totalSession ${state.totalSessions}, currentSession: ${state.currentSession}');

    final children = <Widget>[];
    List.generate(state.totalSessions, (index) {
      bool isActiveSession = index <= (state.currentSession - 1);
      children.add(Container(
        width: 10,
        height: 10,
        decoration: isActiveSession
            ? const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              )
            : BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
                shape: BoxShape.circle,
              ),
      ));
      if (index < state.totalSessions - 1) {
        children.add(const SizedBox(
          width: 10,
        ));
      }
    });
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
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
