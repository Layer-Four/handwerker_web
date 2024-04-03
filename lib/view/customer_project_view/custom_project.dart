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

  const CustomeProject(this.customer, this.description, this.status, this.revenue, this.projectNumber,
      this.projectTimeWindow, this.totalTime, this.costItems);
}
