import 'package:dio/dio.dart';

const String url = 'https://impact.free.beeceptor.com/';

class ActivitiesRepository {
  final Dio _dio = Dio();

  getAllActivities() async {
    try {
      Response response;
      response = await _dio.get(
          // _urlAPI + 'user/list?page=' + page + '&limit=10&role=KARYAWAN',
          url + 'activities',
          options: Options());

      return response;
    } on DioError catch (error) {
      return error.response;
    }
  }

  getActivities(id) async {
    try {
      Response response;
      response = await _dio.get(
          // _urlAPI + 'user/list?page=' + page + '&limit=10&role=KARYAWAN',
          url + 'activities/$id',
          options: Options());

      return response;
    } on DioError catch (error) {
      return error.response;
    }
  }

  postActivities(activityType, institution, when, objective, remarks) async {
    Map data = {
      "activityType": activityType,
      "institution": institution,
      "when": when,
      "objective": objective,
      "remarks": remarks
    };
    try {
      Response response;
      response = await _dio.post(
          // _urlAPI + 'user/list?page=' + page + '&limit=10&role=KARYAWAN',
          url + 'activities',
          data: data,
          options: Options());

      return response;
    } on DioError catch (error) {
      return error.response;
    }
  }

  updateActivities(
      activitiedId, activityType, institution, when, objective, remarks) async {
    Map data = {
      "activityType": activityType,
      "institution": institution,
      "when": when,
      "objective": objective,
      "remarks": remarks
    };
    try {
      Response response;
      response = await _dio.put(
          // _urlAPI + 'user/list?page=' + page + '&limit=10&role=KARYAWAN',
          url + 'activities/$activitiedId',
          data: data,
          options: Options());

      return response;
    } on DioError catch (error) {
      return error.response;
    }
  }
}
