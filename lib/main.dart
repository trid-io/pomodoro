import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/core/bloc_observer.dart';
import 'package:pomodoro/core/logger.dart';
import 'package:pomodoro/core/router.dart';
import 'package:pomodoro/core/theme.dart';
import 'package:pomodoro/presentation/bloc/settings/setting_cubit.dart';

import 'presentation/bloc/settings/setting_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocBuilder<SettingCubit, SettingState>(
        buildWhen: (previous, current) =>
            previous.setting.darkMode != current.setting.darkMode,
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Pomodoro',
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode:
                state.setting.darkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
