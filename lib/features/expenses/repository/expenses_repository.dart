 

import 'package:dio/dio.dart';
import 'package:flutter/material.dart'; 
import 'package:tobfolio/core/network/api_service.dart';
import 'package:tobfolio/core/utils/toasts.dart';
import '../model/expenses_model.dart';

class ExpensesRepository {
  final ApiService _apiService;

  ExpensesRepository(this._apiService);

  Future  createMaintenanceExpense(Expense expense) async {
    try {
      final response = await _apiService.post(
        '/maintenance',
        data: expense.toJson(),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccess('Expense created successfully!');
               
        return response.statusCode;
      } else {
        throw Exception('Failed to create maintenance expense: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error creating maintenance expense: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<ExpensesModel>> getExpenses() async {
    try {
      final response = await _apiService.get('/maintenance');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        
        if (data is List) {
          final res = data.map((json) => ExpensesModel.fromJson(json)).toList();
          debugPrint("expenses list: $res");
          return res;
        } else {
          throw Exception('Invalid response format: expected List but got ${data.runtimeType}');
        }
      } else {
        throw Exception('Failed to fetch expenses: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching expenses: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
