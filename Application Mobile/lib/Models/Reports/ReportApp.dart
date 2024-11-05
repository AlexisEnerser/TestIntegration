class ReportApp{
  String group = '';
  String name = '';
  String url = '';
  int reportTypeId = 0;
  int reportId = 0;
  String reportType = '';
  bool isFavorite = false;

  ReportApp({
    required this.group,
    required this.name,
    required this.url,
    required this.reportTypeId,
    required this.reportType,
    required this.isFavorite,
    required this.reportId,
  });
}