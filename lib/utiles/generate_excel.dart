import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../constants/conestant.dart';
import '../data/models/user_report_model.dart';
import 'files.dart';

Future<void> generateExcel(List<UserReportModel> report) async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];

  sheet.enableSheetCalculations();
  final Range headerRange = sheet.getRangeByName('A1:Z2');
  final Range range = sheet.getRangeByName('A3:Z200');
  Style globalStyle = workbook.styles.add('style');
  Style headerStyle = workbook.styles.add('header_style');
  globalStyle.borders.all.lineStyle = LineStyle.thin;
  globalStyle.borders.all.color = '#000000';
  globalStyle.hAlign = HAlignType.center;

  globalStyle.vAlign = VAlignType.center;
  globalStyle.fontSize = 15;

  headerStyle.borders.all.lineStyle = LineStyle.thin;
  headerStyle.borders.all.color = '#000000';
  headerStyle.hAlign = HAlignType.center;
  headerStyle.vAlign = VAlignType.center;
  headerStyle.fontSize = 18;
  headerStyle.bold;
  headerStyle.backColor = '#84ff6b';
  headerStyle.fontColor = '#000000';

  range.cellStyle = globalStyle;
  headerRange.cellStyle = headerStyle;

  sheet.getRangeByName('A1:A2').merge();
  sheet.getRangeByName('B1:D1').merge();
  sheet.getRangeByName('E1:E2').merge();
  sheet.getRangeByName('F1:S1').merge();
  sheet.getRangeByName('A1').setText('الاسم');
  sheet.getRangeByName('B1').setText('الحضور');
  sheet.getRangeByName('B2').setText('اجمالي');
  sheet.getRangeByName('C2').setText('Lec 1');
  sheet.getRangeByName('D2').setText('Lec 2');
  sheet.getRangeByName('E1').setText('ماراثون');
  sheet.getRangeByName('F1').setText('صلوات');
  sheet.getRangeByName('F2').setText('باكر');
  sheet.getRangeByName('G2').setText('تالته');
  sheet.getRangeByName('H2').setText('سادسه');
  sheet.getRangeByName('I2').setText('تاسعه');
  sheet.getRangeByName('J2').setText('غروب');
  sheet.getRangeByName('K2').setText('نوم');
  sheet.getRangeByName('L2').setText('ارتجالي باكر');
  sheet.getRangeByName('M2').setText('ارتجالي نوم');
  sheet.getRangeByName('N2').setText('تناول');
  sheet.getRangeByName('O2').setText('قداس');
  sheet.getRangeByName('P2').setText('اعتراف');
  sheet.getRangeByName('Q2').setText('صوم');
  sheet.getRangeByName('R2').setText('عهد قديم');
  sheet.getRangeByName('S2').setText('عهد جديد');
  for (int i = 0; i < report.length; i++) {
    sheet.getRangeByName('A${i + 3}').setText(report[i].userName);
    sheet.getRangeByName('B${i + 3}').setText(report[i].attendTotal);
    sheet.getRangeByName('C${i + 3}').setText(report[i].attendLec1);
    sheet.getRangeByName('D${i + 3}').setText(report[i].attendLec2);
    sheet.getRangeByName('E${i + 3}').setText(report[i].marathon);
    sheet.getRangeByName('F${i + 3}').setText(report[i].baker);
    sheet.getRangeByName('G${i + 3}').setText(report[i].talta);
    sheet.getRangeByName('H${i + 3}').setText(report[i].sata);
    sheet.getRangeByName('I${i + 3}').setText(report[i].tas3a);
    sheet.getRangeByName('J${i + 3}').setText(report[i].grob);
    sheet.getRangeByName('K${i + 3}').setText(report[i].noom);
    sheet.getRangeByName('L${i + 3}').setText(report[i].ertgalyBaker);
    sheet.getRangeByName('M${i + 3}').setText(report[i].ertgalyNom);
    sheet.getRangeByName('N${i + 3}').setText(report[i].tnawel);
    sheet.getRangeByName('O${i + 3}').setText(report[i].odas);
    sheet.getRangeByName('P${i + 3}').setText(report[i].eatraf);
    sheet.getRangeByName('Q${i + 3}').setText(report[i].soom);
    sheet.getRangeByName('R${i + 3}').setText(report[i].oldBible);
    sheet.getRangeByName('S${i + 3}').setText(report[i].newBible);
  }
  sheet.getRangeByName('A1:Z200').autoFit();
  sheet.getRangeByName('A1:Z200').autoFitColumns();

  final List<int> bytes = workbook.saveAsStream();
  await Files.saveFile(bytes, '$teamId/${startDate}_$endDate.xlsx', 'تقارير');
}
