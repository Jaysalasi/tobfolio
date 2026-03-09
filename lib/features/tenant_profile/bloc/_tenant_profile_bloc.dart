import 'package:flutter_bloc/flutter_bloc.dart';
import 'tenant_profile_event.dart';
import 'tenant_profile_state.dart';
import '../model/tenant_profile_model.dart';

class TenantProfileBloc
    extends Bloc<TenantProfileEvent, TenantProfileState> {
  TenantProfileBloc() : super(TenantProfileInitial()) {
    on<LoadTenantProfile>(_loadProfile);
  }

  Future<void> _loadProfile(
    LoadTenantProfile event,
    Emitter<TenantProfileState> emit,
  ) async {
    emit(TenantProfileLoading());

    await Future.delayed(const Duration(seconds: 1));

    final tenant = Tenant(
      name: "John Doe",
      email: "johndoe@gmail.com",
      phone: "+234 000 000 000",
      property: "Lekki House",
      room: "Room D5",
      rentFee: "\$800 / month",
      rentFrequency: "Monthly",
      entryDate: "01-05-2025",
      documentName: "Tenancy_Agreement.pdf",
      documentSize: "350 KB",
      avatar:
          "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
    );

    emit(TenantProfileLoaded(tenant));
  }
}