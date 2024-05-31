import 'dart:convert';

import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/contracts/IWorkoutRepository.dart';
import 'package:exopek_workout_app/domain/Models/Comment.dart';
import 'package:exopek_workout_app/domain/Models/Like.dart';
import 'package:exopek_workout_app/domain/Models/WorkoutComplete.dart';
import 'package:exopek_workout_app/presentation/Workouts.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/Models/Workout.dart';

class WorkoutRepository implements IWorkoutRepository {
  WorkoutRepository(this.ref);

  final Ref ref;
  //final String _baseUrl = "http://exopek.azurewebsites.net/api/";

  @override
  Future<List<WorkoutListItem>> getWorkouts({String? query}) async {
    Dio _dio = ref.watch(dioProvider);
    //_dio.options.baseUrl = _baseUrl;
    String queryString = "";
    if (query == "All" || query == null) {
      query = "";
    }
    queryString = query!.isNotEmpty ? "?searchTerm=${query}" : "";
    Response res = await _dio.get("workouts${queryString}");
    if (res.statusCode == 200) {
      //var workouts = Workout.fromJson(res.data);
      var workouts = (res.data as List<dynamic>)
          .map((w) => WorkoutListItem.fromJson(w as Map<String, dynamic>))
          .toList() as List<WorkoutListItem>;
      ;
      return workouts; //compute(_parseWorkouts, res.data);
    } else {
      throw Exception("Failed to load workouts");
    }
  }

  @override
  Future<WorkoutDetails> getWorkout(String id) async {
    Dio _dio = ref.watch(dioProvider);
    //_dio.options.baseUrl = _baseUrl;
    Response res = await _dio.get("workouts/byId?id=$id");
    print(res.data.runtimeType);
    if (res.statusCode == 200) {
      var workout = WorkoutDetails.fromJson(res.data as Map<String, dynamic>);
      return workout;
    } else {
      throw Exception("Failed to load workout");
    }
  }

  @override
  Future<bool> completeWorkout({required String workoutId}) async {
    Dio _dio = ref.watch(dioProvider);

    Response res = await _dio.post("workouts/completes", data: {
      "workoutId": workoutId,
    });
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to complete workout");
    }
  }
  
  @override
  Future<List<CommentReadDto>> getWorkoutComments(String id) async {
    Dio _dio = ref.watch(dioProvider);
    Response res = await _dio.get("workouts/comments?id=$id");
    if (res.statusCode == 200) {
      var comments = (res.data as List<dynamic>)
          .map((c) => CommentReadDto.fromJson(c as Map<String, dynamic>))
          .toList();
      return comments;
    } else {
      throw Exception("Failed to load comments");
    }
  }
  
  @override
  Future<bool> addWorkoutComment({required String workoutId, required String comment, required int rating}) async {
    Dio _dio = ref.watch(dioProvider);
    Response res = await _dio.post("workouts/comments", data: {
      "workoutId": workoutId,
      "comment": comment,
      "rating": rating,
    });
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to add comment");
    }
  }
  
  @override
  Future<LikeReadDto> likeWorkout({required String workoutId}) async {
    Dio _dio = ref.watch(dioProvider);
    Response res = await _dio.post("workouts/likes/$workoutId");
    if (res.statusCode == 200) {
      var like = LikeReadDto.fromJson(res.data as Map<String, dynamic>);
      return like as LikeReadDto;
    } else {
      throw Exception(res.statusMessage);
    }
  }
  
  @override
  Future<List<LikeReadDto>> getWorkoutLikes() async {
    Dio _dio = ref.watch(dioProvider);
    Response res = await _dio.get("workouts/likes");
    if (res.statusCode == 200) {
      var likes = (res.data as List<dynamic>)
          .map((l) => LikeReadDto.fromJson(l as Map<String, dynamic>))
          .toList();
      return likes;
    } else {
      throw Exception("Failed to load likes");
    }
    }
    
      @override
      Future<bool> deleteWorkoutLike({required String workoutLikeId}) async {
        Dio _dio = ref.watch(dioProvider);
        Response res = await _dio.delete("workouts/likes/$workoutLikeId");
        if (res.statusCode == 200) {
          return true;
        } else {
          throw Exception("Failed to delete like");
        }
      }

      @override
      Future<List<WorkoutCompleteReadDto>> getWorkoutCompletes() async {
        Dio _dio = ref.watch(dioProvider);
        Response res = await _dio.get("workouts/completes/me");
        if (res.statusCode == 200) {
          var workouts = (res.data as List<dynamic>)
              .map((w) => WorkoutCompleteReadDto.fromJson(w as Map<String, dynamic>))
              .toList() as List<WorkoutCompleteReadDto>;
          ;
          return workouts; //compute(_parseWorkouts, res.data);
        } else {
          throw Exception("Failed to load workouts");
        }
      }
} 
