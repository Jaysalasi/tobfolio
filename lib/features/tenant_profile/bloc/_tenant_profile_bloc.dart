import 'package:flutter_bloc/flutter_bloc.dart';
import 'tenant_profile_event.dart';
import 'tenant_profile_state.dart';
import '../model/tenant_profile_model.dart';
import '../../../features/tenants/repositories/tenant_repository.dart';

class TenantProfileBloc
    extends Bloc<TenantProfileEvent, TenantProfileState> {
  final TenantRepository _repository;
  
  TenantProfileBloc(this._repository) : super(TenantProfileInitial()) {
    on<LoadTenantProfile>(_loadProfile);
    on<UpdateTenant>(_updateTenant);
  }

  Future<void> _loadProfile(
    LoadTenantProfile event,
    Emitter<TenantProfileState> emit,
  ) async {
    emit(TenantProfileLoading());

    try {
      final tenantData = await _repository.getTenantById(event.tenantId);
      
      // Convert API data to Tenant model
      final tenant = Tenant(
        name: tenantData['name'] ?? 'Unknown',
        email: tenantData['email'] ?? 'Unknown',
        phone: tenantData['phone'] ?? 'Unknown',
        property: "Property", // Will be updated when we have property data
        room: tenantData['unitNumber'] ?? 'Unknown',
        rentFee: "\$${tenantData['rentAmount'] ?? 0} / ${tenantData['paymentFrequency'] ?? 'month'}",
        rentFrequency: tenantData['paymentFrequency'] ?? 'Unknown',
        entryDate: _formatDate(tenantData['rentStart']),
        documentName: "Tenancy_Agreement.pdf", // Will be updated when we have documents
        documentSize: "350 KB", // Will be updated when we have documents
        avatar: tenantData['image'] ?? "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
      );

      emit(TenantProfileLoaded(tenant));
    } catch (e) {
      emit(TenantProfileError(e.toString()));
    }
  }

  Future<void> _updateTenant(
    UpdateTenant event,
    Emitter<TenantProfileState> emit,
  ) async {
    print('DEBUG: _updateTenant called');
    print('DEBUG: tenantId: ${event.tenantId}');
    print('DEBUG: updatedData: ${event.updatedData}');
    
    emit(TenantProfileLoading());

    try {
      print('DEBUG: Calling repository.updateTenant');
      await _repository.updateTenant(event.tenantId, event.updatedData);
      print('DEBUG: Repository update completed successfully');
      
      // Show success message or navigate back
      emit(TenantProfileSuccess('Tenant updated successfully'));
    } catch (e) {
      print('DEBUG: Update failed with error: $e');
      emit(TenantProfileError(e.toString()));
    }
  }
  
  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
    } catch (e) {
      return dateString;
    }
  }
}