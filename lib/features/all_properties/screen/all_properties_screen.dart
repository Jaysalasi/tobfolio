import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/router/app_router.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/all_properties/bloc/all_properties_bloc.dart';
import 'package:tob/features/all_properties/bloc/all_properties_event.dart';
import 'package:tob/features/all_properties/bloc/all_properties_state.dart';
import 'package:tob/features/all_properties/screen/widgets/all_property_card.dart';

class PropertyListScreen extends StatelessWidget {
  const PropertyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllPropertyBloc()..add(LoadProperties()),
      child: const _PropertyListView(),
    );
  }
}

class _PropertyListView extends StatelessWidget {
  const _PropertyListView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
          backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
               Navigator.pop(context);
            },
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
            plusButtonMeth(label: "Add Property", theme: theme, onTap: () {
              Navigator.pushNamed(context, AppRouter.addProperty);
            },),
            SizedBox(width: 20),
          ],
        ),

      body: BlocBuilder<AllPropertyBloc, AllPropertyState>(
        builder: (context, state) {
          if (state is PropertyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PropertyLoaded) {
            if (state.properties.isEmpty) {
              return const Center(child: Text("No properties"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                return PropertyCard(
                  property: state.properties[index],
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}