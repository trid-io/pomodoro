import 'package:equatable/equatable.dart';
import 'package:pomodoro/domain/entity/setting_entity.dart';

sealed class PomoEvent extends Equatable {
  const PomoEvent();

  @override
  List<Object?> get props => [];
}

final class PomoStartPressed extends PomoEvent {
  const PomoStartPressed();
}

final class PomoContinuePressed extends PomoEvent {
  const PomoContinuePressed();
}

final class PomoTimeChanged extends PomoEvent {
  const PomoTimeChanged({required this.seconds});

  final int seconds;

  @override
  List<Object?> get props => [seconds];
}

final class PomoPausePressed extends PomoEvent {
  const PomoPausePressed();
}

final class PomoResetPressed extends PomoEvent {
  const PomoResetPressed();
}

final class PomoNextPressed extends PomoEvent {
  const PomoNextPressed();
}

final class PomoSettingChanged extends PomoEvent {
  const PomoSettingChanged({required this.setting});

  final SettingEntity setting;

  @override
  List<Object?> get props => [setting];
}
