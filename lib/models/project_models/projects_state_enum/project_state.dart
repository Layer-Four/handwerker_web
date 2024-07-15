enum ProjectState {
  finished(3),
  start(5),
  paused(6),
  planning(7);

  final int value;

  const ProjectState(this.value);

  String get title => switch (value) {
        3 => 'Abgeschlossen',
        5 => 'Gestartet',
        6 => 'Pausiert',
        7 => 'Geplant',
        _ => 'Kein Status ',
      };
}

extension ProjectStateExt on ProjectState {
  static ProjectState getStateFromTitle(String title) => switch (title) {
        'Abgeschlossen' => ProjectState.finished,
        'Gestartet' => ProjectState.start,
        'Pausiert' => ProjectState.paused,
        'Geplant' => ProjectState.planning,
        _ => throw UnimplementedError()
      };
  static List<String> get getTitelsList => [
        ProjectState.finished.title,
        ProjectState.start.title,
        ProjectState.paused.title,
        ProjectState.planning.title,
      ];
  static List<ProjectState> get getProjectStates => [
        ProjectState.finished,
        ProjectState.start,
        ProjectState.paused,
        ProjectState.planning,
      ];
}
