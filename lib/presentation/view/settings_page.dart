// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/core/logger.dart';
import 'package:pomodoro/extension.dart';
import 'package:pomodoro/presentation/bloc/settings/setting_cubit.dart';
import 'package:pomodoro/presentation/bloc/settings/setting_state.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final changeValue = Duration(minutes: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red, width: 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: Text('Focus time'),
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      IconButton.filledTonal(
                        onPressed: () {
                          Duration time =
                              state.setting.focusDuration - changeValue;
                          context.read<SettingCubit>().changeFocusTime(time);
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        state.setting.focusDuration.inSeconds.formatSecond(),
                      ),
                      IconButton.filledTonal(
                        onPressed: () {
                          Duration time =
                              state.setting.focusDuration + changeValue;
                          context.read<SettingCubit>().changeFocusTime(time);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 15,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green, width: 1),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  title: Text('Short Break Time'),
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      IconButton.filledTonal(
                          onPressed: () {
                            Duration time =
                                state.setting.shortBreakDuration - changeValue;
                            context
                                .read<SettingCubit>()
                                .changeShortBreakTime(time);
                          },
                          icon: Icon(Icons.remove)),
                      Text(state.setting.shortBreakDuration.inSeconds
                          .formatSecond()),
                      IconButton.filledTonal(
                          onPressed: () {
                            Duration time =
                                state.setting.shortBreakDuration + changeValue;
                            context
                                .read<SettingCubit>()
                                .changeShortBreakTime(time);
                          },
                          icon: Icon(Icons.add)),
                    ],
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 25,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.greenAccent, width: 1),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  title: Text('Long Break Time'),
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      IconButton.filledTonal(
                          onPressed: () {
                            Duration time =
                                state.setting.longBreakDuration - changeValue;
                            context
                                .read<SettingCubit>()
                                .changeLongBreakTime(time);
                          },
                          icon: Icon(Icons.remove)),
                      Text(state.setting.longBreakDuration.inSeconds
                          .formatSecond()),
                      IconButton.filledTonal(
                          onPressed: () {
                            Duration time =
                                state.setting.longBreakDuration + changeValue;
                            context
                                .read<SettingCubit>()
                                .changeLongBreakTime(time);
                          },
                          icon: Icon(Icons.add)),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.more_horiz),
                  title: Text('Sessions'),
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      IconButton.filledTonal(
                          onPressed: () {
                            context.read<SettingCubit>().changeSessions(
                                state.setting.totalSessions - 1);
                          },
                          icon: Icon(Icons.remove)),
                      Text(state.setting.totalSessions.toString()),
                      IconButton.filledTonal(
                          onPressed: () {
                            context.read<SettingCubit>().changeSessions(
                                state.setting.totalSessions + 1);
                          },
                          icon: Icon(Icons.add)),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.autorenew_outlined),
                  title: Text('Auto Start'),
                  trailing: Switch.adaptive(
                      value: state.setting.autoStart,
                      onChanged: (value) {
                        context.read<SettingCubit>().changeAutoStart(value);
                      }),
                ),
                ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text('Dark Mode'),
                  trailing: Switch.adaptive(
                      value: state.setting.darkMode,
                      onChanged: (value) {
                        logger.d('Dark Mode clicked $value');
                        context.read<SettingCubit>().changeDarkMode(value);
                      }),
                ),
                ListTile(
                  leading: Icon(Icons.notifications_outlined),
                  title: Text('Notification'),
                  trailing: Switch.adaptive(
                      value: state.setting.sendNotification,
                      onChanged: (value) {
                        context
                            .read<SettingCubit>()
                            .changeSendNotification(value);
                      }),
                ),
                ListTile(
                  leading: Icon(Icons.star_border_outlined),
                  title: Text('Rate this app!'),
                  trailing: Icon(Icons.navigate_next_outlined),
                  onTap: () {
                    //TODO: implement here
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
