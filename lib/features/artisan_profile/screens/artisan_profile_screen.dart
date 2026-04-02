import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/artisan_profile/screens/widgets/overview_widget.dart';
import 'package:tob/features/artisan_profile/screens/widgets/reviews_widget.dart';
import '../bloc/artisan_profile_bloc.dart';

class ArtisanProfileScreen extends StatefulWidget {
  final String id;

  const ArtisanProfileScreen({super.key, required this.id});

  @override
  State<ArtisanProfileScreen> createState() => _ArtisanProfileScreenState();
}

class _ArtisanProfileScreenState extends State<ArtisanProfileScreen> {
  final List<String> categories = ['Overview', 'Reviews'];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch handyman profile data when screen loads
    context.read<ArtisanProfileBloc>().add(GetArtisanProfile(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        leading: IconButton(
          icon: SvgPicture.asset(SvgAssets.backOutline),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(selectedIndex == 0 ? 'Artisan Profile' : 'Reviews'),
        actions: [
          selectedIndex == 0
              ? IconButton(
                  icon: SvgPicture.asset(SvgAssets.shareSend),
                  onPressed: () {},
                )
              : const SizedBox(),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List<Widget>.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                      // vertical: 5,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? theme.colorScheme.primary
                          : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: selectedIndex != index
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surface,
                      ),
                    ),
                    child: Text(
                      categories[index],
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: selectedIndex == index
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<ArtisanProfileBloc, ArtisanProfileState>(
              builder: (context, state) {
                if (state.status == ArtisanProfileStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == ArtisanProfileStatus.error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error loading profile',
                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.errorMessage ?? 'Unknown error',
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ArtisanProfileBloc>().add(
                              GetArtisanProfile(widget.id),
                            );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state.handyman == null) {
                  return const Center(child: Text('No profile data available'));
                }

                final handyman = state.handyman!;
                final List<String> images = handyman.images.isNotEmpty
                    ? handyman.images
                    : [];
                print("mages    0------ ${handyman.images}");
                if (selectedIndex == 0) {
                  return overviewMeth(context, theme, handyman, images);
                }

                // For reviews tab, use actual reviews from API response
                return reviewsMeth(context, theme, state.reviews, [handyman]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
