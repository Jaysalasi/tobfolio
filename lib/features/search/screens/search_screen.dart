import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/artisan_profile/screens/artisan_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> categories = [
    'All',
    'Electrician',
    'Plumber',
    'Painter',
    'AC Technician',
  ];
  int selectedIndex = 0;

  final List guys = [
    {
      'name': 'Tucker Nixon',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'Electrician',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
    {
      'name': 'Will Lennon',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'Plumber',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
    {
      'name': 'John Doe',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'Painter',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
    {
      'name': 'John Doe',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'AC Technician',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
    {
      'name': 'John Doe',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'Electrician',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
    {
      'name': 'John Doe',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'Electrician',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
    {
      'name': 'John Doe',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'Electrician',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
    {
      'name': 'John Doe',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'Electrician',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
    {
      'name': 'Sanji Doe',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'Electrician',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
    {
      'name': 'Solo Man',
      'image': AppImages.house,
      'rating': 4.5,
      'category': 'Electrician',
      'likes': 100,
      'price': 100,
      'location': 'Lagos',
      'description':
          'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    },
  ];

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
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
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
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(guys.length, (index) {
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
                                backgroundImage: AssetImage(
                                  guys[index]['image'],
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    guys[index]['name'],
                                    style: theme.textTheme.headlineSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                  ),
                                  Text(
                                    guys[index]['category'],
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
                                        guys[index]['location'],
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
                                Text(guys[index]['rating'].toString(), style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),),
                                Text(" (${guys[index]['likes'].toString()})", style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),),
                              ],
                              ),
                              SizedBox(height: 10),
                              plusButtonMeth(
                                label: 'Connect',
                                theme: theme,
                                isIcon: false,
                                onTap: () {
                                  // Navigator.pushNamed(context, AppRouter.artisanProfile);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => ArtisanProfileScreen(id: "69c56962f4120ef067c31486")),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
