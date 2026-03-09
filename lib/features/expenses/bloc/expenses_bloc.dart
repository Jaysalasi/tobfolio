import 'package:flutter_bloc/flutter_bloc.dart';
import 'expenses_event.dart';
import 'expenses_state.dart';
import '../model/expenses_model.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  ExpensesBloc() : super(ExpensesInitial()) {
    on<LoadExpenses>(_load);
    on<AddExpense>(_addExpense);
  }

  final List<Expense> _expenses = [];

  void _load(
    LoadExpenses event,
    Emitter<ExpensesState> emit,
  ) async {
    emit(ExpensesLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    emit(ExpensesLoaded(_expenses));
  }

  void _addExpense(
    AddExpense event,
    Emitter<ExpensesState> emit,
  ) {
    _expenses.add(event.expense);
    emit(ExpensesLoaded(List.from(_expenses)));
  }
}