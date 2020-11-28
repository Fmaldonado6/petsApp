import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/services/data_service.dart';

@injectable
class ReportsService extends DataService{
  ReportsService(AppConfig config) : super(config);

   Future<Report> addReport(Report report) async {
    Response response = await dio.post(apiUrl + "/reports", data: report);

    return Report.fromJson(response.data);
  }

}