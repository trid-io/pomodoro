import 'package:go_router/go_router.dart';
import 'package:pomodoro/presentation/view/pomodoro_page.dart';
import 'package:pomodoro/presentation/view/settings_page.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) => const PomodoroPage(),
      routes: [
        GoRoute(
          path: 'settings',
          builder: (context, state) => SettingPage(),
        )
      ])
]);
