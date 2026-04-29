import 'package:equatable/equatable.dart';
import 'package:tobfolio/features/expenses/model/expenses_model.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object?> get props => [];
}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesLoaded extends ExpensesState {
  final List<ExpensesModel> expenses;

  const ExpensesLoaded(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class ExpensesError extends ExpensesState {
  final String message;

  const ExpensesError(this.message);
}

class CreateExpensesError extends ExpensesState {
  final String message;

  const CreateExpensesError(this.message);
}