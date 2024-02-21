import 'package:e_note_khadem/data/models/user_report_model.dart';

abstract class KhademReportsStates {}

class InitialKhademReportsState extends KhademReportsStates {}

class ReportLoadingReportsState extends KhademReportsStates {}

class ReportSuccessReportsState extends KhademReportsStates {
  late List<UserReportModel> report;

  ReportSuccessReportsState(this.report);
}

class ReportErrorReportsState extends KhademReportsStates {
  late String error;

  ReportErrorReportsState(this.error);
}

class GenerateExcelLoadingReportsState extends KhademReportsStates {}

class GenerateExcelSuccessReportsState extends KhademReportsStates {}

class GenerateExcelErrorReportsState extends KhademReportsStates {
  late String error;

  GenerateExcelErrorReportsState(this.error);
}
