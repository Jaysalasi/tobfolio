import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/add_property/bloc/add_property_bloc.dart';
import 'package:tob/features/add_property/bloc/add_property_event.dart';
import 'package:tob/features/add_property/bloc/add_property_state.dart';
import 'package:tob/features/add_property/utils/add_property_utils.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => AddPropertyBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(SvgAssets.backOutline),
          ),
          backgroundColor: theme.colorScheme.tertiary,
          title: Text(
            "Add Property",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.tertiary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: BlocBuilder<AddPropertyBloc, AddPropertyState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const SizedBox(height: 20),

                    AltTextField(
                      label: "Property Name",
                      hint: "E.g Lekki House",
                      onChanged: (v) =>
                          context.read<AddPropertyBloc>().add(UpdateName(v)),
                    ),

                    AltTextField(
                      label: "Property Type",
                      hint: "Select Property",
                      value: state.propertyType,
                      readOnly: true,
                      onTap: () {
                        showPropertyTypeModal(context);
                      },
                    ),

                    AltTextField(
                      label: "Property Address",
                      hint: "Address Line",
                      onChanged: (v) =>
                          context.read<AddPropertyBloc>().add(UpdateAddress(v)),
                    ),

                    const Text("Add Photo"),

                    const SizedBox(height: 10),

                    const PhotoGrid(),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {},
                        child: const Text("Continue"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
