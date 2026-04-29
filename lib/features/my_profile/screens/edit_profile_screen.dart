import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tobfolio/core/utils/components/app_button.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/features/add_property/utils/alt_text_field.dart';
import 'package:tobfolio/features/home/bloc/home_bloc.dart';
import 'package:tobfolio/features/my_profile/bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late String _name;
  late String _email;
  late String _phone;
  late String _about;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(LoadHomeData());
      final user = context.read<HomeBloc>().state.user;
      _name = user?.name ?? '';
      _email = user?.email ?? '';
      _phone = user?.phone ?? '';
      _about = user?.about ?? '';
    });
  }

  void _submit() {
    final currency = context.read<HomeBloc>().state.user?.currency ?? '';
    context.read<ProfileBloc>().add(UpdateProfile(
      name: _name,
      email: _email,
      phone: _phone,
      about: _about,
      currency: currency,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.success) {
          context.read<HomeBloc>().add(LoadHomeData());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
          Navigator.of(context).pop();
        } else if (state.status == ProfileStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Failed to update profile')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.tertiary,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
               Navigator.pop(context);
            },
            icon: SvgPicture.asset(SvgAssets.backOutline),
          ),
          backgroundColor: theme.colorScheme.tertiary,
          title: const Text("Edit Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              AltTextField(
                label: "Name",
                hint: "Enter your name",
                value: _name,
                onChanged: (v) => _name = v,
              ),
              AltTextField(
                label: "Email",
                hint: "Enter your email",
                value: _email,
                onChanged: (v) => _email = v,
              ),
              AltTextField(
                label: "Phone Number",
                hint: "Enter your phone number",
                value: _phone,
                onChanged: (v) => _phone = v,
              ),
              AltTextField(
                label: "About",
                hint: "Tell us about yourself",
                value: _about,
                onChanged: (v) => _about = v,
              ),
              const SizedBox(height: 30),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return AppButton(
                    title: "Update",
                    onPressed: state.status == ProfileStatus.loading ? null : _submit,
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
