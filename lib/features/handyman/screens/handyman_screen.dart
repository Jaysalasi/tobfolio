import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/components/widgets.dart';
import 'package:tobfolio/core/utils/constants/assets/pngs.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/features/artisan_profile/screens/artisan_profile_screen.dart';
import '../bloc/handyman_bloc.dart';

class HandymanScreen extends StatefulWidget {
  const HandymanScreen({super.key});

  @override
  State<HandymanScreen> createState() => _HandymanScreenState();
}

class _HandymanScreenState extends State<HandymanScreen> {
  final List<String> categories = [
    'All',
    'Electrician',
    'Plumber',
    'Painter',
    'AC Technician',
  ];
  int selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch all handymen on initial load
    context.read<HandymanBloc>().add(const GetHandymen());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                GestureDetector(
                  child: SvgPicture.asset(SvgAssets.backOutline),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _searchController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        // Trigger search when user types
                        context.read<HandymanBloc>().add(SearchHandymen(value));
                      },
                      decoration: InputDecoration(
                        hintStyle: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          // horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Search artisans',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SvgPicture.asset(
                            SvgAssets.search,
                            width: 15,
                            height: 15,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                SvgPicture.asset(SvgAssets.filter, width: 25, height: 25),
                SizedBox(width: 5),
                SvgPicture.asset(SvgAssets.supportAgent, width: 25, height: 25),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(categories.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      // Filter by expertise when category is selected
                      final expertise = index == 0 ? null : categories[index];
                      context.read<HandymanBloc>().add(FilterHandymen(expertise: expertise));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                        // vertical: 5,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
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
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<HandymanBloc, HandymanState>(
                builder: (context, state) {
                  if (state.status == HandymanStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.status == HandymanStatus.error) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error loading handymen',
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
                              context.read<HandymanBloc>().add(RefreshHandymen());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state.handymen.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No handymen found',
                            style: theme.textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Try adjusting your search or filters',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(state.handymen.length, (index) {
                        final handyman = state.handymen[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            gradient: appGradient(context),
                            boxShadow: appShadow(context),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: handyman.images.isNotEmpty
                                        ? NetworkImage(handyman.images.first)
                                        : AssetImage(AppImages.house) as ImageProvider,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        handyman.fullName.length > 30
                                            ? "${handyman.fullName.substring(0, 25)}..."
                                            : handyman.fullName,
                                        style: theme.textTheme.headlineSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                      ),
                                      Text(
                                        handyman.expertise.length > 30
                                            ? "${handyman.expertise.substring(0, 25)}..."
                                            : handyman.expertise,
                                        style: theme.textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          SvgPicture.asset(SvgAssets.location),
                                          Text(
                                            handyman.location,
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(children: [
                                    SvgPicture.asset(SvgAssets.starGold),
                                    Text(handyman.rating.toStringAsFixed(2), style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),),
                                    Text(" (${handyman.reviewsCount.toString()})", style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),),
                                  ],
                                  ),
                                  SizedBox(height: 10),
                                  plusButtonMeth(
                                    label: 'Connect',
                                    theme: theme,
                                    isIcon: false,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => ArtisanProfileScreen(id: handyman.id)),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
