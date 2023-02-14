import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w3cert/models/categoryModel.dart';
import 'package:w3cert/models/employeeModel.dart';
import 'package:w3cert/models/taskModel.dart';

import '../const/const.dart';
import '../models/attendenceModel.dart';
import '../models/notificationModel.dart';
import '../models/projectModel.dart';
import '../models/taskDetailModel.dart';
import '../models/userModel.dart';

class Api {
  final dio = Dio(BaseOptions(
    connectTimeout: 30000,
    baseUrl: BaseUrl.url,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));
  Future authendication(String email, String password) async {
    try {
      var params = {"email": email, "password": password};
      Response response = await dio.post(
        "auth/login",
        data: jsonEncode(params),
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future addTask(String? token, Map<String, dynamic> data) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    final formData = FormData.fromMap({
      "heading": data["heading"],
      "description": data["description"],
      "start_date": data["start_date"],
      "due_date": data["due_date"],
      "without_duedate": data["without_duedate"],
      "project_id": data["project_id"],
      "category_id": data["category_id"],
      "priority": 1,
      "is_private": null,
      "billable": 0,
      "estimate_minutes": 0,
      "estimate_hours": 0,
      // "milestone_id": 0,
      // "repeat": 0,
      // "repeat_count": 0,
      // "repeat_type": 0,
      // "repeat_cycles": 0,
      "user_id[]": data["user_id[]"],
      // "task_labels": ',
    });

    print(formData.fields.toString());

    try {
      Response response = await dio.post("task/store", data: formData);
      print("$response");
      return response;
    } on DioError catch (e) {
      print("${e.response}");

      return e.response;
    }
  }
}

class providerApi {
  final dio = Dio(BaseOptions(
    connectTimeout: 30000,
    baseUrl: BaseUrl.url,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));
  Future<UserModel> user(String email, String password) async {
    try {
      var params = {"email": email, "password": password};
      Response response = await dio.post(
        "auth/login",
        data: jsonEncode(params),
      );
      UserModel user = UserModel.fromJson(response.data["data"]);
      return user;
    } on DioError catch (e) {
      throw e.response!;
    }
  }

  Future<List<AttendenceModel>> attendence(String? token, String? date) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    final formData = FormData.fromMap({"date": date});

    try {
      Response response = await dio.post("attendance/all", data: formData);
      List<AttendenceModel> attendence = [];
      response.data.map((e) {
        attendence.add(AttendenceModel.fromJson(e));
      }).toList();

      return attendence;
    } on DioError catch (e) {
      throw e.response!;
    }
  }

  Future<List<EmployeeModel>> employee(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get("task/list/employees");
      List<EmployeeModel> employee = [];
      response.data.map((e) {
        employee.add(EmployeeModel.fromJson(e));
      }).toList();

      return employee;
    } on DioError catch (e) {
      print("String" + e.toString());
      throw e.response!;
    }
  }

  Future<List<NotificationModel>> notification(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.get("notification");
      List<NotificationModel> notifications = [];
      response.data.map((e) {
        notifications.add(NotificationModel.fromJson(e));
      }).toList();
      return notifications;
    } on DioError catch (e) {
      print("String" + e.toString());
      throw e.response!;
    }
  }

  Future<List<TaskModel>> task(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.get("task");
      List<TaskModel> task = [];
      response.data.map((e) {
        task.add(TaskModel.fromJson(e));
      }).toList();
      return task;
    } on DioError catch (e) {
      throw e.response!;
    }
  }

  Future<List<ProjectModel>> projects(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.get("task/list/projects");
      List<ProjectModel> project = [];
      response.data.map((e) {
        project.add(ProjectModel.fromJson(e));
      }).toList();
      return project;
    } on DioError catch (e) {
      throw e.response!;
    }
  }

  Future<List<CategoryModel>> categories(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.get("task/list/category");
      List<CategoryModel> category = [];
      response.data.map((e) {
        category.add(CategoryModel.fromJson(e));
      }).toList();
      return category;
    } on DioError catch (e) {
      throw e.response!;
    }
  }

  Future<TaskDetailsModel> taskById(String? token, int id) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    print("${id}");
    try {
      Response response = await dio.get("task/${id}");
      print(response.data.toString());
      TaskDetailsModel task = TaskDetailsModel.fromJson(response.data);

      return task;
    } on DioError catch (e) {
      throw e.response!;
    }
  }
}

final provider = Provider<providerApi>((red) => providerApi());
