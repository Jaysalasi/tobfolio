import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/features/tenants/bloc/tenant_event.dart';
import 'package:tob/features/tenants/bloc/tenant_state.dart';
import 'package:tob/features/tenants/repositories/tenant_repository.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  final TenantRepository _repository;
  
  TenantBloc(this._repository) : super(TenantState()) {
    
    on<FetchTenants>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      
      try {
        final tenants = await _repository.getTenants();
        emit(state.copyWith(isLoading: false, tenants: tenants));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });

    on<CreateTenant>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      
      try {
        await _repository.createTenant(
          name: event.name,
          email: event.email,
          phone: event.phone,
          propertyId: event.propertyId,
          unitNumber: event.unitNumber,
          rentAmount: event.rentAmount,
          rentStart: event.rentStart,
          rentEnd: event.rentEnd,
          rentDuration: event.rentDuration,
          paymentFrequency: event.paymentFrequency,
          imagePath: event.imagePath,
          notes: event.notes,
        );
        
        emit(state.copyWith(isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });

    on<UpdateRentFrequency>((event, emit) {
      emit(state.copyWith(rentFrequency: event.type));
    });
    
    on<UpdateRentFee>((event, emit) {
      emit(state.copyWith(rentFee: event.rentFee));
    });
  }
}
