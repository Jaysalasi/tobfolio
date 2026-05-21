import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/app_button.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/core/utils/toasts.dart';
import 'package:tobfolio/features/add_property/repositories/property_repository.dart';
import 'package:tobfolio/features/add_property/utils/alt_text_field.dart';

class SaveAndAddAnotherPropertyUnitScreen extends StatefulWidget {
  final String propertyName;
  final String propertyType;
  final String propertyAddress;
  final String unitType;
  final List<String> propertyImages;
  final int totalUnits;
  final String unitNumber;
  final String unitDescription;

  const SaveAndAddAnotherPropertyUnitScreen({
    super.key,
    required this.propertyName,
    required this.propertyType,
    required this.unitType,
    required this.propertyAddress,
    required this.propertyImages,
    required this.totalUnits,
    required this.unitNumber,
    required this.unitDescription,
  });

  @override
  State<SaveAndAddAnotherPropertyUnitScreen> createState() =>
      _SaveAndAddAnotherPropertyUnitScreenState();
}

class _SaveAndAddAnotherPropertyUnitScreenState
    extends State<SaveAndAddAnotherPropertyUnitScreen> {
  late final List<Map<String, String>> _savedUnits;
  String _currentUnitName = '';
  String _currentDescription = '';
  int _formResetKey = 0;
  bool _isLoading = false;

  int get _totalUnits => widget.totalUnits + _savedUnits.length;

  @override
  void initState() {
    super.initState();
    _savedUnits = [
      {
        'unitNumber': widget.unitNumber.trim(),
        'description': widget.unitDescription.trim(),
      },
    ];
  }

  void _saveAndAddAnother() {
    if (_currentUnitName.trim().isEmpty) {
      showError('Please enter a unit number');
      return;
    }
    setState(() {
      _savedUnits.add({
        'unitNumber': _currentUnitName.trim(),
        'description': _currentDescription.trim(),
      });
      _currentUnitName = '';
      _currentDescription = '';
      _formResetKey++;
    });
  }

  Future<void> _done() async {
    final allUnits = List<Map<String, String>>.from(_savedUnits);
    if (_currentUnitName.trim().isEmpty) {
      showError('Please enter a unit number');
      return;
    }
    if (_currentUnitName.trim().isNotEmpty) {
      allUnits.add({
        'unitNumber': _currentUnitName.trim(),
        'description': _currentDescription.trim(),
      });
    }
    print(  'allUnits: ${allUnits}');

    if (allUnits.isEmpty) {
      Navigator.pop(context);
      return;
    }

    setState(() => _isLoading = true);

    final repo = context.read<PropertyRepository>();
    try {
      for (final unit in allUnits) {
        await repo.createProperty(
          name: widget.propertyName,
          type: widget.propertyType,
          address: widget.propertyAddress,
          units: allUnits.length,
          propertyImages: widget.propertyImages,
          managementType: 'single_unit',
          unitType: widget.unitType,
          unitNumber: unit['unitNumber'] ?? '',
          totalUnits: _totalUnits,
          unitDescription: unit['description'] ?? '',
        );
      }
      if (mounted) {
        showSuccess('Property units created successfully!');
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        showError('Failed to create units: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.lightSurfaceColor,
                  border: Border.all(color: AppTheme.grayAltColor, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Property Name",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Text(
                          widget.propertyName,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 20, color: AppTheme.grayAltColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Units",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$_totalUnits',
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
                key: ValueKey('unit_name_$_formResetKey'),
                label: "Unit Number",
                hint: "Unit Number",
                onChanged: (v) => _currentUnitName = v,
              ),

              const SizedBox(height: 10),
              AltTextField(
                key: ValueKey('unit_desc_$_formResetKey'),
                label: "Description (Optional)",
                hint: "E.g Modern apartment with city view",
                maxLines: 5,
                type: AltFieldType.multiline,
                onChanged: (v) => _currentDescription = v,
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: _saveAndAddAnother,
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
              AppButton(
                title: _isLoading ? "Saving..." : "Done",
                onPressed: _isLoading ? null : _done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
