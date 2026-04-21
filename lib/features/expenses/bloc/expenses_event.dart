import 'package:equatable/equatable.dart';

abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpensesEvent {}

class AddExpense extends ExpensesEvent {
  final dynamic expense;

  const AddExpense(this.expense);
}

class SelectExpense extends ExpensesEvent {
  final String id;

  const SelectExpense(this.id);
}

