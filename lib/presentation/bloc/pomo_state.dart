import 'package:equatable/equatable.dart';
import 'package:pomodoro/domain/entity/setting_entity.dart';
import 'package:pomodoro/extension.dart';

enum PomoStatus { initial, running, paused }

enum PomoMode { focus, shortBreak, longBreak }

final class PomoState extends Equatable {
  PomoState({
    this.setting = const SettingEntity(),
    this.status = PomoStatus.initial,
    this.mode = PomoMode.focus,
    this.currentSession = 1,
    int? seconds,
    this.error,
  }) : seconds = seconds ?? setting.focusDuration.inSeconds;

  final SettingEntity setting;
  final PomoStatus status;
  final PomoMode mode;
  final int currentSession;
  final int seconds;
  final String? error;

  String get displayTime {
    return seconds.formatSecond();
  }

  int get totalSessions {
    return setting.totalSessions;
  }

  PomoState copyWith({
    SettingEntity? setting,
    PomoStatus? status,
    PomoMode? mode,
    int? currentSession,
    int? seconds,
    String? error,
  }) {
    return PomoState(
      setting: setting ?? this.setting,
      status: status ?? this.status,
      mode: mode ?? this.mode,
      currentSession: currentSession ?? this.currentSession,
      seconds: seconds ?? this.seconds,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        setting,
        status,
        mode,
        currentSession,
        seconds,
        error,
      ];
}
