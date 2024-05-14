import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/contracts/IUserRepository.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository implements IUserRepository {
  UserRepository(this.ref);

  final Ref ref;
  //final String _baseUrl = "http://exopek.azurewebsites.net/api/";

  @override
  Future<ReadUserDto> getUser() async {
    Dio _dio = ref.watch(dioProvider);
    //_dio.options.baseUrl = _baseUrl;
    Response res = await _dio.get("users");
    if (res.statusCode == 200) {
      var user = ReadUserDto.fromJson(res.data as Map<String, dynamic>);
      return user;
    } else {
      throw Exception("Failed to load user");
    }
  }

  @override
  Future<bool> updateUser(UpdateUserDto user) async {
    Dio _dio = ref.watch(dioProvider);
    //_dio.options.baseUrl = _baseUrl;
    var userJson = user.toJson();
    Response res = await _dio.put("users", data: user.toJson());
    print(res.statusCode);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> createUser(CreateUserDto user) async {
    Dio _dio = ref.watch(dioProvider);
    //_dio.options.baseUrl = _baseUrl;
    Response res = await _dio.post("users/register", data: user.toJson());
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<String> login(String email, String password) async {
    Dio _dio = ref.watch(dioProvider);
    Response res = await _dio.post("users/login", data: {"username": email, "password": password});
    if (res.statusCode == 200) {
      //var user = User.fromJson(res.data as Map<String, dynamic>);
      var jwt = res.data["token"] as String;
      return jwt;
    } else {
      throw Exception(res.statusMessage);
    }
  }

  @override
  Future<bool> uploadProfilImage(File image) async {
    Dio _dio = ref.watch(dioProvider);
    var formData = FormData.fromMap({
      "files": await MultipartFile.fromFile(image.path),
      "fileType": 1
    });
    Response res = await _dio.post("files", data: formData);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to upload image");
    }
  }
  
  @override
  Future<bool> resetPassword(String email) async {
    Dio _dio = ref.watch(dioProvider);
    Response res = await _dio.post("users/forget-password", queryParameters: {"email": email});
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to reset password");
    }
  }
  
  @override
  Future<bool> checkUserIsLogedIn() async {
    Dio _dio = ref.watch(dioProvider);
    Response res = await _dio.post("users/check-user-login");
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }}

  