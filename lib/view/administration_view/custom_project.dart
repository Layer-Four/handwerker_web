class CustomeProject {
  final String customer;
  final String description;

  // final DateTime lastChange;
  final bool status;
  final int projectNumber;
  final String projectTimeWindow;
  final int totalTime;
  final double costItems;
  final double revenue;
  final List<ProjectReport> projectReports;

  const CustomeProject(
    this.customer,
    this.description,
    this.status,
    this.revenue,
    this.projectNumber,
    this.projectTimeWindow,
    this.totalTime,
    this.costItems, [
    this.projectReports = const [],
  ]);
}

class ProjectReport {
  final String projectname;
  final String description;
  final String date;
  final List<String> imagePaths;

  const ProjectReport(this.projectname, this.description, this.date, this.imagePaths);
}
