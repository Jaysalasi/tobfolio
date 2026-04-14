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
import 'package:tob/features/all_properties/bloc/all_properties_bloc.dart';
import 'package:tob/features/all_properties/bloc/all_properties_event.dart';
import 'package:tob/features/all_properties/bloc/all_properties_state.dart';
import 'package:tob/features/all_properties/model/all_property_model.dart';
import 'package:tob/features/all_properties/repositories/all_properties_repository.dart';
import 'package:tob/features/tenants/bloc/tenant_bloc.dart';
import 'package:tob/features/tenants/bloc/tenant_event.dart';
import 'package:tob/features/tenants/bloc/tenant_state.dart';
import 'package:intl/intl.dart';
import 'package:tob/features/tenants/screens/successful.dart';

class AddTenantScreen extends StatefulWidget {
  const AddTenantScreen({super.key});

  @override
  State<AddTenantScreen> createState() => _AddTenantScreenState();
}

class _AddTenantScreenState extends State<AddTenantScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  CountryCode selectedCountry = countryCodes.first;
  PropertyModel? selectedProperty;
  String? selectedUnit;
  
  // Form data
  String tenantName = '';
  String tenantEmail = '';
  String tenantPhone = '';
  String rentAmount = '';
  String rentFrequency = 'Monthly';
  String rentDuration = '1 year';
  String rentEntryDate = 'Select entry date';
  String rentExpiryDate = 'Select entry date';
  String notes = '';

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
    return BlocProvider(
      create: (context) => AllPropertyBloc(
        repository: context.read<AllPropertiesRepository>(),
      )..add(LoadProperties()),
      child: Scaffold(
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
        child: BlocListener<TenantBloc, TenantState>(
          listener: (context, state) {
            if (state.isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              // Close any loading dialog
              Navigator.of(context, rootNavigator: true).pop();
              
              if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                // Success - navigate to successful screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: const RouteSettings(name: 'successful'),
                    builder: (context) => const Successful(),
                  ),
                );
              }
            }
          },
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
                            // Validate required fields
                            if (tenantName.isEmpty || 
                                tenantEmail.isEmpty || 
                                tenantPhone.isEmpty || 
                                selectedProperty == null || 
                                selectedUnit == null ||
                                rentAmount.isEmpty ||
                                rentEntryDate.isEmpty ||
                                rentExpiryDate.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all required fields'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            // Create tenant
                            context.read<TenantBloc>().add(CreateTenant(
                              name: tenantName,
                              email: tenantEmail,
                              phone: tenantPhone,
                              propertyId: selectedProperty!.id,
                              unitNumber: selectedUnit!,
                              rentAmount: double.tryParse(rentAmount) ?? 0.0,
                              rentStart: rentEntryDate,
                              rentEnd: rentExpiryDate,
                              rentDuration: rentDuration,
                              paymentFrequency: rentFrequency.toLowerCase(),
                              imagePath: documentPath,
                              notes: notes,
                            ));
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
          AltTextField(
            label: "Full name", 
            hint: "James Smith",
            onChanged: (value) {
              setState(() {
                tenantName = value;
              });
            },
          ),
          AltTextField(
            label: "Email", 
            hint: "james.smith@example.com",
            onChanged: (value) {
              setState(() {
                tenantEmail = value;
              });
            },
          ),
          PhoneTextField(
            label: "Phone Number",
            hint: "Enter phone number",
            phoneNumber: tenantPhone,
            countryCode: selectedCountry.dialCode,
            countryCodes: countryCodes.map((e) => e.dialCode).toList(),
            onCountryChanged: (country) {
              setState(() {
                selectedCountry = countryCodes.firstWhere(
                  (e) => e.dialCode == country,
                );
              });
            },
            onChanged: (value) {
              setState(() {
                tenantPhone = value;
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
          BlocBuilder<AllPropertyBloc, AllPropertyState>(
            builder: (context, state) {
              if (state is PropertyLoading) {
                return AltTextField(
                  label: "Property",
                  hint: "Loading properties...",
                  type: AltFieldType.dropdown,
                  items: ["Loading..."],
                );
              }

              if (state is PropertyLoaded) {
                final propertyNames = state.properties.map((p) => p.name).toList();
                
                return AltTextField(
                  label: "Property",
                  hint: selectedProperty?.name ?? "Select Property",
                  type: AltFieldType.dropdown,
                  items: propertyNames,
                  value: selectedProperty?.name,
                  onChanged: (value) {
                    setState(() {
                      selectedProperty = state.properties.firstWhere(
                        (p) => p.name == value,
                        orElse: () => state.properties.first,
                      );
                      selectedUnit = null; // Reset unit when property changes
                    });
                  },
                );
              }

              return AltTextField(
                label: "Property",
                hint: "No properties available",
                type: AltFieldType.dropdown,
                items: ["No properties"],
              );
            },
          ),
          AltTextField(
            label: "Select Unit",
            hint: selectedProperty != null ? "Select Unit" : "Select property first",
            type: AltFieldType.dropdown,
            items: selectedProperty != null 
                ? List.generate(selectedProperty!.units, (index) => "Unit ${index + 1}")
                : ["No property selected"],
            value: selectedUnit,
            onChanged: selectedProperty != null ? (value) {
              setState(() {
                selectedUnit = value;
              });
            } : null,
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
            value: rentFrequency,
            onChanged: (value) {
              setState(() {
                rentFrequency = value;
              });
            },
          ),
          AltTextField(
            label: "Rent Duration",
            hint: "Select duration",
            type: AltFieldType.dropdown,
            items: ["1 year", "2 years", "3 years"],
            value: rentDuration,
            onChanged: (value) {
              setState(() {
                rentDuration = value;
              });
            },
          ),
          AltTextField(
            label: "Rent Entry Date",
            hint: rentEntryDate ,
            type: AltFieldType.text,
            enabled: true,
            value: rentEntryDate,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
                setState(() {
                  rentEntryDate = formattedDate;
                });
              }
            },
          ),
          AltTextField(
            label: "Rent Expiry Date",
            hint: rentExpiryDate,
            type: AltFieldType.text,
            enabled: true,
            value: rentExpiryDate,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 3650)),
              );
              if (picked != null) {
                final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
                setState(() {
                  rentExpiryDate = formattedDate;
                });
              }
            },
          ),
           
          AltTextField(
            label: "Rent Fee",
            hint: "Enter rent fee",
            type: AltFieldType.number,
            value: rentAmount,
            onChanged: (value) {
              setState(() {
                rentAmount = value;
              });
            },
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
       
          AltTextField(
            label: "Notes",
            hint: "Enter notes",
            type: AltFieldType.multiline,
            maxLines: 5,
            onChanged: (value) {
              setState(() {
                notes = value;
              });
            },
          ),

        ],
      ),
    );
  }
}
