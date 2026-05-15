import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tobfolio/core/utils/components/app_button.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/core/utils/toasts.dart';
import 'package:tobfolio/features/add_property/utils/alt_text_field.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_bloc.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_event.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_state.dart';
import 'package:tobfolio/features/all_properties/model/all_property_model.dart';

class EditPropertyScreen extends StatefulWidget {
  final PropertyModel property;

  const EditPropertyScreen({super.key, required this.property});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  late String _name;
  late String _type;
  late String _unitType;
  late String _address;
  late String _units;
  late String _totalUnits;
  late String _unitNumber;
  late String _unitDescription;

  @override
  void initState() {
    super.initState();
    _name = widget.property.name;
    _type = widget.property.type;
    _unitType = widget.property.unitType ?? '';
    _address = widget.property.address;
    _units = widget.property.units.toString();
    _totalUnits = widget.property.totalUnits?.toString() ?? '';
    _unitNumber = widget.property.unitNumber ?? '';
    _unitDescription = widget.property.unitDescription ?? '';
  }

  void _submit() {
    final fields = <String, dynamic>{};

    if (_name != widget.property.name) fields['name'] = _name;
    if (_type != widget.property.type) fields['type'] = _type;
    if (_address != widget.property.address) fields['address'] = _address;
    if (_unitType != (widget.property.unitType ?? '')) fields['unitType'] = _unitType;
    if (_unitNumber != (widget.property.unitNumber ?? '')) fields['unitNumber'] = _unitNumber;
    if (_unitDescription != (widget.property.unitDescription ?? '')) fields['unitDescription'] = _unitDescription;

    final parsedUnits = int.tryParse(_units);
    if (parsedUnits != null && parsedUnits != widget.property.units) {
      fields['units'] = parsedUnits;
    }

    final parsedTotalUnits = int.tryParse(_totalUnits);
    if (parsedTotalUnits != null && parsedTotalUnits != widget.property.totalUnits) {
      fields['totalUnits'] = parsedTotalUnits;
    }

    if (fields.isEmpty) {
      Navigator.pop(context);
      return;
    }

    context.read<AllPropertyBloc>().add(
          UpdateProperty(propertyId: widget.property.id, fields: fields),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AllPropertyBloc, AllPropertyState>(
      listener: (context, state) {
        if (state is PropertyUpdateSuccess) {
          context.read<AllPropertyBloc>().add(LoadProperties());
          Navigator.pop(context);
        } else if (state is PropertyError) {
          showError(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(SvgAssets.backOutline),
          ),
          backgroundColor: theme.colorScheme.tertiary,
          title: Text(
            "Edit Property",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: BlocBuilder<AllPropertyBloc, AllPropertyState>(
          builder: (context, state) {
            final isLoading = state is PropertyUpdating;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          AltTextField(
                            label: "Property Name",
                            hint: widget.property.name,
                            value: _name,
                            onChanged: (v) => _name = v,
                          ),
                          AltTextField(
                            label: "Property Type",
                            hint: widget.property.type,
                            value: _type,
                            type: AltFieldType.dropdown,
                            items: ["Residential", "Commercial", "Shortlist", "Land"],
                            onChanged: (v) => _type = v,
                          ),
                          AltTextField(
                            label: "Unit Type",
                            hint: widget.property.unitType ?? "Select Unit Type",
                            value: _unitType.isEmpty ? null : _unitType,
                            type: AltFieldType.dropdown,
                            items: ["flat", "room", "villa", "office"],
                            onChanged: (v) => _unitType = v,
                          ),
                          AltTextField(
                            label: "Property Address",
                            hint: widget.property.address,
                            value: _address,
                            onChanged: (v) => _address = v,
                          ),
                          AltTextField(
                            label: "Units",
                            hint: widget.property.units.toString(),
                            value: _units,
                            enabled: widget.property.managementType == "entire_building",
                            onChanged: (v) => _units = v,
                          ),
                          AltTextField(
                            label: "Total Units",
                            hint: widget.property.totalUnits?.toString() ?? "",
                            value: _totalUnits.isEmpty ? null : _totalUnits,
                            onChanged: (v) => _totalUnits = v,
                          ),
                          AltTextField(
                            label: "Unit Number",
                            hint: widget.property.unitNumber ?? "",
                            value: _unitNumber.isEmpty ? null : _unitNumber,
                            onChanged: (v) => _unitNumber = v,
                          ),
                          AltTextField(
                            label: "Unit Description",
                            hint: widget.property.unitDescription ?? "",
                            value: _unitDescription.isEmpty ? null : _unitDescription,
                            onChanged: (v) => _unitDescription = v,
                          ),
                          const SizedBox(height: 30),
                          AppButton(
                            title: isLoading ? "Saving..." : "Save",
                            onPressed: isLoading ? null : _submit,
                          ),
                          const SizedBox(height: 50),     
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
