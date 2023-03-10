import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:w3cert/models/attendenceModel.dart';
import 'package:w3cert/models/categoryModel.dart';
import 'package:w3cert/models/employeeModel.dart';
import 'package:w3cert/models/leadAgendModel.dart';
import 'package:w3cert/models/leaveModel.dart';
import 'package:w3cert/models/taskDetailModel.dart';
import 'package:w3cert/models/userModel.dart';

import '../api/api.dart';
import '../models/leadCategoryModel.dart';
import '../models/leadCountryModel.dart';
import '../models/leadModel.dart';
import '../models/leadSourceModel.dart';
import '../models/leadStatusModel.dart';
import '../models/notificationModel.dart';
import '../models/projectModel.dart';
import '../models/taskModel.dart';

final loggedInProvider = StateProvider<bool>((ref) => false);
final attendenceDate = StateProvider<String>(
    (ref) => "${DateFormat("dd-MM-yyyy").format(DateTime.now())}");
final splashProvider = StateProvider<bool>((ref) => true);
final tokenProvider = StateProvider<String>((ref) => "");
final taskIdProvider = StateProvider<int>((ref) => 0);

final email = StateProvider<String>((ref) => "");
final password = StateProvider<String>((ref) => "");

final userDataProvider = FutureProvider<UserModel>((ref) {
  String _email = ref.watch(email);
  String _password = ref.watch(password);

  return ref.watch(provider).user(_email, _password);
});
final attendenceProvider = FutureProvider<List<AttendenceModel>>((ref) {
  String? token = ref.watch(tokenProvider);
  String? date = ref.watch(attendenceDate);

  return ref.watch(provider).attendence(token!, date!);
});
final employeProvider = FutureProvider<List<EmployeeModel>>((ref) {
  String? token = ref.watch(tokenProvider);

  return ref.watch(provider).employee(
        token!,
      );
});
final notificationProvider = FutureProvider<List<NotificationModel>>((ref) {
  String? token = ref.watch(tokenProvider);

  return ref.watch(provider).notification(
        token!,
      );
});
final taskProvider = FutureProvider<List<TaskModel>>((ref) {
  String? token = ref.watch(tokenProvider);

  return ref.watch(provider).task(
        token!,
      );
});
final projectProvider = FutureProvider<List<ProjectModel>>((ref) {
  String? token = ref.watch(tokenProvider);

  return ref.watch(provider).projects(
        token!,
      );
});
final CategoryProvider = FutureProvider<List<CategoryModel>>((ref) {
  String? token = ref.watch(tokenProvider);
  return ref.watch(provider).categories(
        token!,
      );
});
final singleTaskProvider = FutureProvider<TaskDetailsModel>((ref) {
  int? id = ref.watch(taskIdProvider);
  String? token = ref.watch(tokenProvider);
  return ref.watch(provider).taskById(token!, id!);
});
final leaveProvider = FutureProvider<List<LeaveModel>>((ref) {
  String? token = ref.watch(tokenProvider);
  return ref.watch(provider).leaves(token!);
});
final leadProvider = FutureProvider<List<LeadModel>>((ref) {
  String? token = ref.watch(tokenProvider);
  return ref.watch(provider).leads(token!);
});
final leadAgendProvider = FutureProvider<List<LeadAgendModel>>((ref) {
  String? token = ref.watch(tokenProvider);
  return ref.watch(provider).leadsAgend(token!);
});
final leadSourceProvider = FutureProvider<List<LeadSourceModel>>((ref) {
  String? token = ref.watch(tokenProvider);
  return ref.watch(provider).leadSource(token!);
});
final leadStatusProvider = FutureProvider<List<LeadStatusModel>>((ref) {
  String? token = ref.watch(tokenProvider);
  return ref.watch(provider).leadStatus(token!);
});

final leadCategoryProvider = FutureProvider<List<LeadCategoryModel>>((ref) {
  String? token = ref.watch(tokenProvider);
  return ref.watch(provider).leadCategory(token!);
});

final leadCountryProvider = FutureProvider<List<LeadCountryModel>>((ref) {
  String? token = ref.watch(tokenProvider);
  return ref.watch(provider).leadCountry(token!);
});
