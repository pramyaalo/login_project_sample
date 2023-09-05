class PairIncomeReportDDl {
  final String WeekDate;
  final String weeks;
  final String Weekno;

  PairIncomeReportDDl(
      {required this.WeekDate, required this.weeks, required this.Weekno});

  factory PairIncomeReportDDl.fromJson(Map<String, dynamic> json) {
    return PairIncomeReportDDl(
      WeekDate: json['WeekDate'].toString(),
      weeks: json['weeks'].toString(),
      Weekno: json['Weekno'].toString(),
    );
  }
}
