import 'package:equatable/equatable.dart';
import 'package:pomodoro/domain/entity/setting_entity.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent({required this.setting});

  final SettingEntity setting;

  @override
  List<Object?> get props => [];
}

final class SettingFocusTimeChanged extends SettingEvent {
  const SettingFocusTimeChanged({required super.setting});
}

final class SettingShortBreakTimeChanged extends SettingEvent {
  const SettingShortBreakTimeChanged({required super.setting});
}

final class SettingLongBreakTimeChanged extends SettingEvent {
  const SettingLongBreakTimeChanged({required super.setting});
}

final class SettingDarkModeChanged extends SettingEvent {
  const SettingDarkModeChanged({required super.setting});
}

final class SettingNotificationChanged extends SettingEvent {
  const SettingNotificationChanged({required super.setting});
}
