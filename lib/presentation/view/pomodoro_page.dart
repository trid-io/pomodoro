// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/presentation/bloc/settings/setting_state.dart';
import 'package:pomodoro/presentation/widget/pomo_buttons.dart';
import 'package:pomodoro/presentation/widget/pomo_sessions.dart';
import 'package:pomodoro/presentation/widget/pomo_time.dart';

import '../bloc/pomodoro/pomo_event.dart';
import '../bloc/pomodoro/pomo_bloc.dart';
import '../bloc/pomodoro/pomo_state.dart';
import '../bloc/settings/setting_cubit.dart';

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
        body: BlocListener<SettingCubit, SettingState>(
          listener: (context, state) {
            context
                .read<PomoBloc>()
                .add(PomoSettingChanged(setting: state.setting));
          },
          child: BlocBuilder<PomoBloc, PomoState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PomoTime(
                    displayTime: state.displayTime,
                    color: Colors.red,
                    size: 100,
                  ),
                  PomoSessions(
                    currentSession: state.currentSession,
                    currentMode: state.mode,
                    totalSessions: state.totalSessions,
                    sessionColor: Colors.red,
                    shortBreakColor: Colors.green,
                    longBreakColor: Colors.yellow,
                  ),
                  const SizedBox(height: 20),
                  PomoButtons(
                    status: state.status,
                    onStartPressed: () =>
                        context.read<PomoBloc>().add(const PomoStartPressed()),
                    onContinuePressed: () => context
                        .read<PomoBloc>()
                        .add(const PomoContinuePressed()),
                    onPausePressed: () =>
                        context.read<PomoBloc>().add(const PomoPausePressed()),
                    onResetPressed: () =>
                        context.read<PomoBloc>().add(const PomoResetPressed()),
                    onNextPressed: () =>
                        context.read<PomoBloc>().add(const PomoNextPressed()),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
