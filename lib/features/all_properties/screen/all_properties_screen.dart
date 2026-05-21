import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tobfolio/core/router/app_router.dart';
import 'package:tobfolio/core/utils/components/widgets.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/core/utils/toasts.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_bloc.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_event.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_state.dart';
import 'package:tobfolio/features/home/bloc/home_bloc.dart';
import 'package:tobfolio/features/all_properties/model/all_property_model.dart';
import 'package:tobfolio/features/all_properties/repositories/all_properties_repository.dart';
import 'package:tobfolio/features/all_properties/screen/edit_property_screen.dart';
import 'package:tobfolio/features/all_properties/screen/widgets/all_property_card.dart';

class PropertyListScreen extends StatelessWidget {
  const PropertyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AllPropertyBloc(repository: context.read<AllPropertiesRepository>())
            ..add(LoadProperties()),
      child: const _PropertyListView(),
    );
  }
}

class _PropertyListView extends StatefulWidget {
  const _PropertyListView();

  @override
  State<_PropertyListView> createState() => _PropertyListViewState();
}

class _PropertyListViewState extends State<_PropertyListView> {
  bool _deletingDialogOpen = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeData());
  }

  void _closeDeletingDialog() {
    if (_deletingDialogOpen) {
      _deletingDialogOpen = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showDeletingDialog() {
    _deletingDialogOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        title: Text('Deleting Property'),
        content: SizedBox(
          height: 60,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    ).whenComplete(() => _deletingDialogOpen = false);
  }

  void _showDeleteConfirmation(String propertyId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Property'),
        content: const Text(
          'Are you sure you want to delete this property? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AllPropertyBloc>().add(DeleteProperty(propertyId));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: _buildAppBar(theme),
      body: BlocConsumer<AllPropertyBloc, AllPropertyState>(
        listener: _onStateChange,
        builder: _buildBody,
      ),
    );
  }

  AppBar _buildAppBar(ThemeData theme) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: SvgPicture.asset(SvgAssets.backOutline),
      ),
      backgroundColor: theme.colorScheme.tertiary,
      title: Text(
        "Properties",
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        plusButtonMeth(
          label: "Add Property",
          theme: theme,
          onTap: () => Navigator.pushNamed(context, AppRouter.addProperty),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  void _onStateChange(BuildContext context, AllPropertyState state) {
    if (state is PropertyDeleting) {
      _showDeletingDialog();
    } else if (state is PropertyDeleteSuccess) {
      _closeDeletingDialog();
      showSuccess("Property Deleted Successfully");
    } else if (state is PropertyError) {
      _closeDeletingDialog();
      showError("Error Deleting Property");
    }
  }

  Widget _buildBody(BuildContext context, AllPropertyState state) {
    if (state is PropertyLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is PropertyLoaded || state is PropertyDeleting) {
      final properties = state is PropertyLoaded
          ? state.properties
          : (context.read<AllPropertyBloc>().state is PropertyLoaded
              ? (context.read<AllPropertyBloc>().state as PropertyLoaded).properties
              : <PropertyModel>[]);

      if (properties.isEmpty) {
        return const Center(child: Text("No properties"));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: properties.length,
        itemBuilder: (context, index) => PropertyCard(
          property: properties[index],
          onDelete: () => _showDeleteConfirmation(properties[index].id),
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPropertyScreen(property: properties[index]),
              ),
            );
          },
        ),
      );
    }

    return const Center(child: Text("Error"));
  }
}
