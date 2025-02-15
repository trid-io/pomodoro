import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/extension.dart';
import 'package:pomodoro/presentation/bloc/settings/setting_cubit.dart';
import 'package:pomodoro/presentation/bloc/settings/setting_state.dart';
import 'package:pomodoro/presentation/widget/pomo_time.dart';

class SettingPage2 extends StatelessWidget {
  const SettingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Set your focus time'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.remove),
                    ),
                    PomoTime(
                      displayTime:
                          state.setting.focusDuration.inSeconds.formatSecond(),
                      color: Colors.red,
                    ),
                    IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    ChoiceChip(
                      onSelected: (selected) {},
                      selected: false,
                      label: const Text('Focus'),
                    ),
                    ChoiceChip(
                      onSelected: (selected) {},
                      selected: false,
                      label: const Text('Short Break'),
                    ),
                    ChoiceChip(
                      onSelected: (selected) {},
                      selected: false,
                      label: const Text('Long Break'),
                    ),
                    ChoiceChip(
                      onSelected: (selected) {},
                      selected: false,
                      label: const Text('Sessions'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton.outlined(
                          onPressed: () {
                            context
                                .read<SettingCubit>()
                                .changeDarkMode(!state.setting.darkMode);
                          },
                          icon: state.setting.darkMode
                              ? const Icon(Icons.dark_mode)
                              : const Icon(Icons.light_mode),
                        ),
                        const Text('Dark Mode')
                      ],
                    ),
                    Column(
                      children: [
                        IconButton.outlined(
                          onPressed: () {
                            context
                                .read<SettingCubit>()
                                .changeAutoStart(!state.setting.autoStart);
                          },
                          icon: state.setting.autoStart
                              ? const Icon(Icons.sync)
                              : const Icon(Icons.sync_disabled),
                        ),
                        const Text('Auto Start')
                      ],
                    ),
                    Column(
                      children: [
                        IconButton.outlined(
                          onPressed: () {
                            context.read<SettingCubit>().changeSendNotification(
                                !state.setting.sendNotification);
                          },
                          icon: state.setting.sendNotification
                              ? const Icon(Icons.notifications)
                              : const Icon(Icons.notifications_off),
                        ),
                        const Text('Notification')
                      ],
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
