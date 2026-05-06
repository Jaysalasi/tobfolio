import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/app_button.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/features/add_property/bloc/add_property_bloc.dart';
import 'package:tobfolio/features/add_property/bloc/add_property_event.dart';
import 'package:tobfolio/features/add_property/bloc/add_property_state.dart';
import 'package:tobfolio/features/add_property/repositories/property_repository.dart';
import 'package:tobfolio/features/add_property/utils/alt_text_field.dart';

class SaveAndAddAnotherPropertyUnitScreen extends StatefulWidget {
  const SaveAndAddAnotherPropertyUnitScreen({super.key});

  @override
  State<SaveAndAddAnotherPropertyUnitScreen> createState() =>
      _SaveAndAddAnotherPropertyUnitScreenState();
}

class _SaveAndAddAnotherPropertyUnitScreenState
    extends State<SaveAndAddAnotherPropertyUnitScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => AddPropertyBloc(
        propertyRepository: context.read<PropertyRepository>(),
      ),
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
            "Add Another Unit",
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
                return addPropertyStepOneMeth(context, state, theme);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget addPropertyStepOneMeth(
    BuildContext context,
    AddPropertyState state,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.lightSurfaceColor,
            border: Border.all(color: AppTheme.grayAltColor, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Earned",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Row(
                      children: [
                        Text(
                          "0",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 20, color: AppTheme.grayAltColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Invitation Record",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "10",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        AltTextField(
          label: "Unit Number",
          hint: "Unit Number",
          onChanged: (v) =>
              context.read<AddPropertyBloc>().add(UpdateAddress(v)),
        ),

        const SizedBox(height: 10),
        AltTextField(
          label: "Description (Optional)",
          hint: "E.g Modern apartment with city view",
          maxLines: 5,
          type: AltFieldType.multiline,
          onChanged: (v) =>
              context.read<AddPropertyBloc>().add(UpdateDescription(v)),
        ),

        const Spacer(),

        Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Save & Add Another Unit",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        AppButton(title: "Done", onPressed: () {}),
      ],
    );
  }
}
