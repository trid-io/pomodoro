import 'package:bloc/bloc.dart';
import 'package:pomodoro/core/logger.dart';
import 'package:pomodoro/presentation/bloc/settings/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(const SettingState());

  void changeFocusTime(Duration time) {
    emit(state.copyWith(
      setting: state.setting.copyWith(focusDuration: time),
    ));
  }

  void changeShortBreakTime(Duration time) {
    emit(state.copyWith(
      setting: state.setting.copyWith(shortBreakDuration: time),
    ));
  }

  void changeLongBreakTime(Duration time) {
    emit(state.copyWith(
      setting: state.setting.copyWith(longBreakDuration: time),
    ));
  }

  void changeSessions(int totalSessions) {
    emit(state.copyWith(
      setting: state.setting.copyWith(totalSessions: totalSessions),
    ));
  }

  void changeAutoStart(bool enable) {
    emit(state.copyWith(
      setting: state.setting.copyWith(autoStart: enable),
    ));
  }

  void changeDarkMode(bool enable) {
    logger.d('changeDarkMode $enable');
    emit(state.copyWith(
      setting: state.setting.copyWith(darkMode: enable),
    ));
  }

  void changeSendNotification(bool enable) {
    emit(state.copyWith(
      setting: state.setting.copyWith(sendNotification: enable),
    ));
  }
}
