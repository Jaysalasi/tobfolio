import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/features/tenants/bloc/tenant_event.dart';
import 'package:tob/features/tenants/bloc/tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  TenantBloc() : super(TenantState()) {
    

    on<UpdateRentFrequency>((event, emit) {
      emit(state.copyWith(rentFrequency: event.type));
    });
    on<UpdateRentFee>((event, emit) {
      emit(state.copyWith(rentFee: event.rentFee));
    });
  }
}
