import 'package:equatable/equatable.dart';

class SettingEntity extends Equatable {
  const SettingEntity({
    this.focusDuration = const Duration(minutes: 25),
    this.shortBreakDuration = const Duration(minutes: 5),
    this.longBreakDuration = const Duration(minutes: 20),
    this.totalSessions = 4,
    this.autoStart = false,
    this.sendNotification = true,
  });

  final Duration focusDuration;
  final Duration shortBreakDuration;
  final Duration longBreakDuration;
  final int totalSessions;
  final bool autoStart;
  final bool sendNotification;

  SettingEntity copyWith({
    Duration? focusDuration,
    Duration? shortBreakDuration,
    Duration? longBreakDuration,
    int? totalSessions,
    bool? autoStart,
    bool? sendNotification,
  }) =>
      SettingEntity(
        focusDuration: focusDuration ?? this.focusDuration,
        shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
        longBreakDuration: longBreakDuration ?? this.longBreakDuration,
        totalSessions: totalSessions ?? this.totalSessions,
        autoStart: autoStart ?? this.autoStart,
        sendNotification: sendNotification ?? this.sendNotification,
      );

  @override
  List<Object?> get props => [
        focusDuration,
        shortBreakDuration,
        longBreakDuration,
        totalSessions,
        autoStart,
        sendNotification,
      ];

  @override
  String toString() {
    return 'SettingEntity{focusDuration=$focusDuration, shortBreakDuration=$shortBreakDuration, longBreakDuration=$longBreakDuration, totalSessions=$totalSessions, autoStart=$autoStart, sendNotification=$sendNotification}';
  }
}
