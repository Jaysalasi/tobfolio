import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/features/tenants/bloc/tenant_event.dart';
import 'package:tobfolio/features/tenants/bloc/tenant_state.dart';
import 'package:tobfolio/features/tenants/repositories/tenant_repository.dart';

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

    on<DeleteTenant>((event, emit) async {
      emit(state.copyWith(isActionLoading: true, isActionSuccess: false, actionError: null));
      try {
        await _repository.deleteTenant(event.tenantId);
        final tenants = await _repository.getTenants();
        emit(state.copyWith(isActionLoading: false, isActionSuccess: true, tenants: tenants));
      } catch (e) {
        emit(state.copyWith(isActionLoading: false, actionError: e.toString()));
      }
    });

    on<RenewTenant>((event, emit) async {
      emit(state.copyWith(isActionLoading: true, isActionSuccess: false, actionError: null));
      try {
        await _repository.renewTenant(
          tenantId: event.tenantId,
          paymentFrequency: event.paymentFrequency,
          rentStart: event.rentStart,
          rentEnd: event.rentEnd,
          rentAmount: event.rentAmount,
        );
        final tenants = await _repository.getTenants();
        emit(state.copyWith(isActionLoading: false, isActionSuccess: true, tenants: tenants));
      } catch (e) {
        emit(state.copyWith(isActionLoading: false, actionError: e.toString()));
      }
    });
  }
}
