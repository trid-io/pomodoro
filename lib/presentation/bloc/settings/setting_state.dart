import 'package:equatable/equatable.dart';
import 'package:pomodoro/domain/entity/setting_entity.dart';

final class SettingState extends Equatable {
  const SettingState({SettingEntity? setting})
      : setting = setting ?? const SettingEntity();

  final SettingEntity setting;

  SettingState copyWith({SettingEntity? setting}) {
    return SettingState(setting: setting ?? this.setting);
  }

  @override
  List<Object?> get props => [setting];

  @override
  String toString() {
    return 'SettingsState{setting=$setting}';
  }
}
