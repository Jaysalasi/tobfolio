import 'package:flutter_bloc/flutter_bloc.dart';
import 'expenses_event.dart';
import 'expenses_state.dart';
import '../repository/expenses_repository.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpensesRepository _repository;

  ExpensesBloc({required ExpensesRepository repository})
      : _repository = repository,
        super(ExpensesInitial()) {
    on<LoadExpenses>(_loadExpenses);
    on<AddExpense>(_addExpense);
  }

  Future<void> _loadExpenses(
    LoadExpenses event,
    Emitter<ExpensesState> emit,
  ) async {
    emit(ExpensesLoading());
    
      print("expenses loaded one seeeeeee");
    try {
      final expenses = await _repository.getExpenses();
      print("expenses loaded ${expenses}");
      emit(ExpensesLoaded(expenses));
    } catch (e) {
      emit(ExpensesError(e.toString()));
    }
  }

  Future<void> _addExpense(
    AddExpense event,
    Emitter<ExpensesState> emit,
  ) async {
    emit(ExpensesLoading());
    
    try {
       final res = await _repository.createMaintenanceExpense(event.expense);
      print("expense created with status ${res}");
      // Refresh the expenses list after creating a new one
      final expenses = await _repository.getExpenses();
      print("expenses loaded after add ${expenses}");
      emit(ExpensesLoaded(expenses));
      print("expenses loaded after add second gear ${expenses}");
    } catch (e) {
      emit(CreateExpensesError(e.toString()));
    }
  }
}