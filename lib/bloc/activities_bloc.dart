import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impact_pratama/models/activities_model.dart';
import 'package:impact_pratama/repository/activities_repo.dart';

class ActivitiesEvent {}

abstract class ActivitiesState {}

class ActivitiesUninitialized extends ActivitiesState {}

class GetActivities extends ActivitiesEvent {}

class ActivitiesGetAll extends ActivitiesState {
  final ActivitiesModel activitiesModel;
  ActivitiesGetAll(this.activitiesModel);
}

class ActivitiesById extends ActivitiesEvent {
  final int ActivitiesId;
  ActivitiesById(this.ActivitiesId);
}

class DataActivitiesById extends ActivitiesState {
  final int id;
  final String activityTpe;
  final String institution;
  final String when;
  final String? object;
  final String? remarks;
  DataActivitiesById(
      {required this.id,
      required this.activityTpe,
      required this.institution,
      required this.when,
      this.object,
      this.remarks});
}

class PostActivities extends ActivitiesEvent {
  final int? id;
  final String activityTpe;
  final String institution;
  final String when;
  final String? object;
  final String? remarks;
  PostActivities(
      {this.id,
      required this.activityTpe,
      required this.institution,
      required this.when,
      this.object,
      this.remarks});
}

class UpdateActivities extends ActivitiesEvent {
  final int? id;
  final String activityTpe;
  final String institution;
  final String when;
  final String? object;
  final String? remarks;
  UpdateActivities(
      {this.id,
      required this.activityTpe,
      required this.institution,
      required this.when,
      this.object,
      this.remarks});
}

class MessageState extends ActivitiesState {
  final String? message;
  MessageState({this.message});
}

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final ActivitiesRepository _activitiesRepository = ActivitiesRepository();

  ActivitiesBloc() : super(ActivitiesUninitialized());

  ActivitiesState get initialState => ActivitiesUninitialized();

  @override
  Stream<ActivitiesState> mapEventToState(ActivitiesEvent event) async* {
    if (event is GetActivities) {
      final response = await _activitiesRepository.getAllActivities();
      if (response.statusCode == 200) {
        var res = jsonDecode(response.data);
        yield ActivitiesGetAll(ActivitiesModel.fromJson(res));
      } else {
        yield MessageState(message: 'Failed');
      }
    }

    if (event is ActivitiesById) {
      final response =
          await _activitiesRepository.getActivities(event.ActivitiesId);
      if (response.statusCode == 200) {
        print(response.data);

        yield DataActivitiesById(
            id: response.data['id'],
            activityTpe: response.data['activityType'],
            institution: response.data['institution'],
            when: response.data['when'],
            object: response.data['objective'],
            remarks: response.data['remarks']);
      } else {
        yield MessageState(message: 'Failed');
      }
    }

    if (event is PostActivities) {
      final response = await _activitiesRepository.postActivities(
          event.activityTpe,
          event.institution,
          event.when,
          event.object,
          event.remarks);
      if (response.statusCode == 200) {
        yield MessageState(message: response.data['status'].toString());
      } else {
        yield MessageState(message: 'Failed');
      }
    }

    if (event is UpdateActivities) {
      final response = await _activitiesRepository.updateActivities(
          event.id,
          event.activityTpe,
          event.institution,
          event.when,
          event.object,
          event.remarks);
      if (response.statusCode == 200) {
        yield MessageState(message: response.data['status'].toString());
      } else {
        yield MessageState(message: 'Failed');
      }
    }
  }
}
