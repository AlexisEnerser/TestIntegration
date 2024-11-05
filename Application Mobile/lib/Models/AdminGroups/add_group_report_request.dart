class AddGroupReportRequest{
  int id;
  List<int> reports;

  AddGroupReportRequest({required this.id,required this.reports});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reports': reports
    };
  }
}