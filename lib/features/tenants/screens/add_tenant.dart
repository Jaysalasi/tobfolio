import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tob/core/models/country_code_model.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';
import 'package:tob/features/add_property/utils/phone_text_field.dart';
import 'package:tob/features/tenants/bloc/tenant_bloc.dart';
import 'package:tob/features/tenants/bloc/tenant_state.dart';

class AddTenantScreen extends StatefulWidget {
  const AddTenantScreen({super.key});

  @override
  State<AddTenantScreen> createState() => _AddTenantScreenState();
}

class _AddTenantScreenState extends State<AddTenantScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  CountryCode selectedCountry = countryCodes.first;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


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
              // context.read<AddPropertyBloc>().add(AddDocument(path));
            } else {}
          }
        });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (_currentPage == 0) {
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
          "Add Tenant",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "Step ${_currentPage + 1} of 2",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppTheme.accentColor,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.tertiary,
      body: SafeArea(
        child: BlocBuilder<TenantBloc, TenantState>(
          builder: (context, state) {
            return PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    SizedBox(height: size.height * 0.75,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            addTenantStepOneMeth(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppButton(
                          title: "Continue",
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: size.height * 0.75,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            addTenantStepTwoMeth(theme),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppButton(
                          title: "Save",
                          onPressed: () {
                          },
                        ),
                      ),
                    ],
                  ),
                
              ],
            );
          },
        ),
      ),
    );
  }

  Widget addTenantStepOneMeth() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          /// Avatar
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(SvgAssets.edit),
              ),
            ],
          ),
          SizedBox(height: 20),
          AltTextField(label: "Full name", hint: "James Smith"),
          AltTextField(label: "Email", hint: "james.smith@example.com"),
          PhoneTextField(
            label: "Phone Number",
            hint: "Enter phone number",
            phoneNumber: "",
            countryCode: selectedCountry.dialCode,
            countryCodes: countryCodes.map((e) => e.dialCode).toList(),
            onCountryChanged: (country) {
              setState(() {
                selectedCountry = countryCodes.firstWhere(
                  (e) => e.dialCode == country,
                );
              });
            },
          ),
          PhoneTextField(
            label: "Next of Kin Phone Number",
            hint: "Enter phone number",
            phoneNumber: "",
            countryCode: selectedCountry.dialCode,
            countryCodes: countryCodes.map((e) => e.dialCode).toList(),
            onCountryChanged: (country) {
              setState(() {
                selectedCountry = countryCodes.firstWhere(
                  (e) => e.dialCode == country,
                );
              });
            },
          ),
          AltTextField(
            label: "Property",
            hint: "Select Property",
            type: AltFieldType.dropdown,
            items: ["House 1", "House 2", "House 3"],
          ),
          AltTextField(
            label: "Select Unit",
            hint: "1",
            type: AltFieldType.dropdown,
            items: ["House 1", "House 2", "House 3"],
          ),
        ],
      ),
    );
  }

  Widget addTenantStepTwoMeth(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          
          AltTextField(
            label: "Rent Frequency",
            hint: "Select frequency",
            type: AltFieldType.dropdown,
            items: ["Monthly", "Quarterly", "Annually"],
          ),
          AltTextField(
            label: "Rent Entry Date",
            hint: "Select entry date",
            type: AltFieldType.text,
            enabled: true,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                 
              }
            },
          ),
          AltTextField(
            label: "Rent Expiry Date",
            hint: "Select expiry date",
            type: AltFieldType.text,
            enabled: true,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                 
              }
            },
          ),
           
          AltTextField(
            label: "Rent Fee",
            hint: "Enter rent fee",
            type: AltFieldType.number,
          ),
          AltTextField(
            label: "Late Rent Fee",
            hint: "Enter rent fee",
            type: AltFieldType.number,
          ),

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
                              onTap: pickDocument,
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
        ],
      ),
    );
  }
}
