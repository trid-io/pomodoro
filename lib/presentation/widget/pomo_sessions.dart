import 'package:flutter/material.dart';
import 'package:pomodoro/presentation/bloc/pomodoro/pomo_state.dart';

class PomoSessions extends StatelessWidget {
  const PomoSessions({
    super.key,
    required this.currentSession,
    required this.currentMode,
    required this.totalSessions,
    required this.sessionColor,
    required this.shortBreakColor,
    required this.longBreakColor,
  });

  final int currentSession;
  final PomoMode currentMode;
  final int totalSessions;
  final Color sessionColor;
  final Color shortBreakColor;
  final Color longBreakColor;

  @override
  Widget build(BuildContext context) {
    /* double to include breaks. Eg. 4 sessions should have 4 breaks (3 short breaks and 1 long break) */
    final totalItems = totalSessions * 2;

    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List<Widget>.generate(totalItems, (index) {
        bool isSession = index % 2 == 0;
        bool isLongBreak = index == totalItems - 1;
        bool isShortBreak = !isSession && !isLongBreak;
        int sessionIndex = (currentSession - 1) * 2;
        bool isActiveSession = index <= sessionIndex;
        bool isActiveBreak = (index < sessionIndex) ||
            (currentMode != PomoMode.focus && index == sessionIndex + 1);

        if (isSession) {
          if (isActiveSession) {
            return ActiveSession(color: sessionColor);
          } else {
            return InactiveSession(color: sessionColor);
          }
        }

        if (isShortBreak) {
          if (isActiveBreak) {
            return ActiveShortBreak(color: shortBreakColor);
          } else {
            return InactiveShortBreak(color: shortBreakColor);
          }
        }

        if (isLongBreak) {
          if (isActiveBreak) {
            return ActiveLongBreak(color: longBreakColor);
          } else {
            return InactiveLongBreak(color: longBreakColor);
          }
        }

        return const SizedBox();
      }).toList(),
    );
  }
}

class ActiveSession extends StatelessWidget {
  const ActiveSession({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class InactiveSession extends StatelessWidget {
  const InactiveSession({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: 1),
        shape: BoxShape.circle,
      ),
    );
  }
}

class ActiveShortBreak extends StatelessWidget {
  const ActiveShortBreak({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        shape: BoxShape.rectangle,
      ),
    );
  }
}

class InactiveShortBreak extends StatelessWidget {
  const InactiveShortBreak({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color, width: 1),
        shape: BoxShape.rectangle,
      ),
    );
  }
}

class ActiveLongBreak extends StatelessWidget {
  const ActiveLongBreak({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        shape: BoxShape.rectangle,
      ),
    );
  }
}

class InactiveLongBreak extends StatelessWidget {
  const InactiveLongBreak({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color, width: 1),
        shape: BoxShape.rectangle,
      ),
    );
  }
}
