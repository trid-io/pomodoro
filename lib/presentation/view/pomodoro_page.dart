// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/logger.dart';

import '../bloc/pomodoro/pomo_event.dart';
import '../bloc/pomodoro/pomo_bloc.dart';
import '../bloc/pomodoro/pomo_state.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomoBloc(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => context.go('/settings'),
              icon: Icon(Icons.settings_outlined),
            )
          ],
        ),
        body: BlocBuilder<PomoBloc, PomoState>(
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSessions(BuildContext context, PomoState state) {
    logger.d(
        'build Sessions: totalSession ${state.totalSessions}, currentSession: ${state.currentSession}');

    final children = <Widget>[];

    /* double to include breaks. Eg. 4 sessions should have 4 breaks (3 short breaks and 1 long break) */
    final totalItems = state.totalSessions * 2;

    Color sessionColor = Colors.red;
    Color shortBreakColor = Colors.green;
    Color longBreakColor = Colors.greenAccent;

    List.generate(totalItems, (index) {
      // switch (state.mode) {
      //   case PomoMode.focus:
      //     break;
      //   case PomoMode.shortBreak:
      //     break;
      //   case PomoMode.longBreak:
      //     break;
      // }
      bool isSession = index % 2 == 0;
      bool isLongBreak = index == totalItems - 1;
      bool isShortBreak = !isSession && !isLongBreak;
      int sessionIndex = (state.currentSession - 1) * 2;
      bool isActive = index <= sessionIndex;
      // bool isActiveBreak = index <= ((state.currentSession - 1) * 2 + 1) &&
      //     (isShortBreak || isLongBreak);
      bool isActiveBreak = index < sessionIndex ||
          (state.mode != PomoMode.focus && index == sessionIndex + 1);

      if (isSession) {
        if (isActive) {
          children.add(Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: sessionColor,
                shape: BoxShape.circle,
              )));
        } else {
          children.add(Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: sessionColor, width: 1),
              shape: BoxShape.circle,
            ),
          ));
        }
      }

      if (isShortBreak) {
        if (isActiveBreak) {
          children.add(Container(
            width: 20,
            height: 5,
            decoration: BoxDecoration(
              color: shortBreakColor,
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
            ),
          ));
        } else {
          children.add(Container(
            width: 20,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: shortBreakColor, width: 1),
              shape: BoxShape.rectangle,
            ),
          ));
        }
      }

      if (isLongBreak) {
        if (isActiveBreak) {
          children.add(Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
              color: longBreakColor,
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
            ),
          ));
        } else {
          children.add(Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: longBreakColor, width: 1),
              shape: BoxShape.rectangle,
            ),
          ));
        }
      }

      if (!isLongBreak) {
        children.add(const SizedBox(
          width: 10,
        ));
      }
    });
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
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
