import 'dart:async';

import 'package:bloc/bloc.dart';

import 'pomo_event.dart';
import 'pomo_state.dart';

class PomoBloc extends Bloc<PomoEvent, PomoState> {
  PomoBloc() : super(PomoState()) {
    on<PomoStartPressed>(_onStartedPressed);
    on<PomoContinuePressed>(_onContinuePressed);
    on<PomoTimeChanged>(_onTimeChanged);
    on<PomoPausePressed>(_onPausedPressed);
    on<PomoResetPressed>(_onResetPressed);
    on<PomoNextPressed>(_onNextPressed);
    on<PomoSettingChanged>(_onSettingChanged);
  }

  final oneSec = const Duration(seconds: 1);
  Timer? _timer;

  void _onStartedPressed(
    PomoStartPressed event,
    Emitter<PomoState> emit,
  ) {
    switch (state.status) {
      case PomoStatus.initial:
        emit(state.copyWith(
            status: PomoStatus
                .running)); // Update state right await to avoid delayed after timer has run for 1 second
        _startTimer(emit);
      case PomoStatus.paused:
      case PomoStatus.running:
        throw Exception('invalid status, state: $state');
    }
  }

  void _onContinuePressed(
    PomoContinuePressed event,
    Emitter<PomoState> emit,
  ) {
    switch (state.status) {
      case PomoStatus.paused:
        emit(state.copyWith(
            status: PomoStatus
                .running)); // Update state right await to avoid delayed after timer has run for 1 second
        _startTimer(emit);
      case PomoStatus.initial:
      case PomoStatus.running:
        throw Exception('invalid status, state: $state');
    }
  }

  void _onTimeChanged(PomoTimeChanged event, Emitter<PomoState> emit) {
    emit(state.copyWith(status: PomoStatus.running, seconds: event.seconds));
  }

  void _onPausedPressed(
    PomoPausePressed event,
    Emitter<PomoState> emit,
  ) {
    _cancelTimer();
    emit(state.copyWith(status: PomoStatus.paused));
  }

  void _onResetPressed(
    PomoResetPressed event,
    Emitter<PomoState> emit,
  ) {
    _cancelTimer();
    emit(state.copyWith(
      status: PomoStatus.initial,
      seconds: _getDefaultSeconds(state.mode),
    ));
  }

  void _onNextPressed(
    PomoNextPressed event,
    Emitter<PomoState> emit,
  ) {
    _cancelTimer();
    final newMode = _getNewMode();
    emit(state.copyWith(
      status: PomoStatus.initial,
      mode: newMode,
      currentSession: _getNewSession(newMode),
      seconds: _getDefaultSeconds(newMode),
    ));
    if (state.setting.autoStart) add(const PomoStartPressed());
  }

  void _onSettingChanged(
    PomoSettingChanged event,
    Emitter<PomoState> emit,
  ) {
    emit(state.copyWith(setting: event.setting));
  }

  void _startTimer(Emitter<PomoState> emit) {
    _timer = Timer.periodic(oneSec, (timer) {
      // print('timer tick: ${timer.tick}, seconds: ${state.seconds}');
      final newSeconds = state.seconds - 1;
      add(PomoTimeChanged(seconds: newSeconds));
      if (newSeconds <= 0) {
        _cancelTimer();
        add(const PomoNextPressed());
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  int _getDefaultSeconds(PomoMode mode) {
    final int seconds;
    switch (mode) {
      case PomoMode.focus:
        seconds = state.setting.focusDuration.inSeconds;
      case PomoMode.shortBreak:
        seconds = state.setting.shortBreakDuration.inSeconds;
      case PomoMode.longBreak:
        seconds = state.setting.longBreakDuration.inSeconds;
    }
    return seconds;
  }

  PomoMode _getNewMode() {
    switch (state.mode) {
      case PomoMode.focus:
        if (state.currentSession % state.totalSessions == 0) {
          return PomoMode.longBreak;
        } else {
          return PomoMode.shortBreak;
        }
      case PomoMode.shortBreak:
      case PomoMode.longBreak:
        return PomoMode.focus;
    }
  }

  int _getNewSession(PomoMode mode) {
    switch (mode) {
      case PomoMode.focus:
        return (state.currentSession % state.totalSessions) + 1;
      case PomoMode.shortBreak:
      case PomoMode.longBreak:
        return state.currentSession;
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
