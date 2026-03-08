import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/add_property/bloc/add_property_bloc.dart';
import 'package:tob/features/add_property/bloc/add_property_event.dart';
import 'package:tob/features/add_property/bloc/add_property_state.dart';
import 'package:tob/features/add_property/utils/add_property_utils.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final PageController _pageController = PageController();

  String? documentPath;

  void pickDocument() {
    ImagePicker()
        .pickImage(
          source: ImageSource.gallery,
          maxWidth: 3000,
          maxHeight: 3000,
          imageQuality: 50,
        )
        .then((pickedFile) {
          if (pickedFile != null) {
            String path = pickedFile.path;
            String ext = path.split('.').last.toLowerCase();
            if (['png', 'jpg', 'jpeg', 'pdf'].contains(ext)) {
              setState(() {
                documentPath = path;
              });
              context.read<AddPropertyBloc>().add(AddDocument(path));
            } else {}
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => AddPropertyBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (_pageController.page == 0) {
                Navigator.pop(context);
              } else {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
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
                return PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    addPropertyStepOneMeth(context, state, theme),
                    addPropertyStepTwoMeth(context, state, theme, pickDocument),
                  ],
                );
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

        AltTextField(
          label: "Property Name",
          hint: "E.g Lekki House",
          onChanged: (v) => context.read<AddPropertyBloc>().add(UpdateName(v)),
        ),

        AltTextField(
          label: "Property Type",
          hint: state.propertyType != ''
              ? state.propertyType
              : "Select Property",
          value: state.propertyType,
          type: AltFieldType.dropdown,
          items: ["Residential", "Commercial", "Shortlist", "Land"],
          onChanged: (v) =>
              context.read<AddPropertyBloc>().add(UpdatePropertyType(v)),
        ),

        AltTextField(
          label: "Property Address",
          hint: "Address Line",
          onChanged: (v) =>
              context.read<AddPropertyBloc>().add(UpdateAddress(v)),
        ),

        Text("Add Photo", style: theme.textTheme.titleMedium),

        const SizedBox(height: 10),

        const PhotoGrid(),

        const Spacer(),

        AppButton(
          title: "Continue",
          onPressed: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }

  Widget addPropertyStepTwoMeth(
    BuildContext context,
    AddPropertyState state,
    ThemeData theme,
    Function() onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        AltTextField(
          label: "Unit Type",
          hint: state.unitType != '' ? state.unitType : "Select Unit",
          value: state.unitType,
          type: AltFieldType.dropdown,
          items: ["Flat", "Room", "Villa", "Office", "Plot"],
          onChanged: (v) =>
              context.read<AddPropertyBloc>().add(UpdateUnitType(v)),
        ),

        // const SizedBox(height: 20),
        AltTextField(
          label: "Unit Number",
          hint: "E.g 101",
          onChanged: (v) => context.read<AddPropertyBloc>().add(UpdateName(v)),
        ),

        AltTextField(
          label: "Description (Optional)",
          hint: "E.g Modern apartment with city view",
          maxLines: 5,
          type: AltFieldType.multiline,
          onChanged: (v) => context.read<AddPropertyBloc>().add(UpdateName(v)),
        ),

        Text(
          "Upload Documents",
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(6),
                  dashPattern: [2, 2],
                  strokeWidth: 2,
                  color: AppTheme.primaryColor,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFf1f6fe),
                    borderRadius: BorderRadius.circular(6),
                    image: documentPath != null
                        ? DecorationImage(
                            image: FileImage(File(documentPath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  height: 116,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(SvgAssets.upload),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            plusButtonMeth(
                              label: "Upload",
                              theme: theme,
                              onTap: onTap,
                              isIcon: false,
                              textStyle: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.lightSurfaceColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Format: jpeg, doc & Max file size: 25 MB',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Spacer(),
        AppButton(
          title: "Save",
          onPressed: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }
}
