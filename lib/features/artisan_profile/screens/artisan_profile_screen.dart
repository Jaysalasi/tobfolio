import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/artisan_profile/screens/widgets/overview_widget.dart';
import 'package:tob/features/artisan_profile/screens/widgets/reviews_widget.dart';

class ArtisanProfileScreen extends StatefulWidget {
  const ArtisanProfileScreen({super.key});

  @override
  State<ArtisanProfileScreen> createState() => _ArtisanProfileScreenState();
}

class _ArtisanProfileScreenState extends State<ArtisanProfileScreen> {
  final List<String> categories = ['Overview', 'Reviews'];
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
  ];

  List images = [
   AppImages.work1,
   AppImages.worker,
   AppImages.worker1,
   AppImages.works,
  ];
List reviews = [
  {
    'name': 'Jane Doe',
    'review': 'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    'rating': 4.5,
    'image': AppImages.house,
  },
  {
    'name': 'John Doe',
    'review': 'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    'rating': 4.5,
    'image': AppImages.house,
  },
  {
    'name': 'Danny Doe',
    'review': 'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    'rating': 4.5,
    'image': AppImages.house,
  },
  {
    'name': 'John Doe',
    'review': 'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    'rating': 4.5,
    'image': AppImages.house,
  },
  {
    'name': 'Danny Doe',
    'review': 'John Doe is a skilled electrician with over 10 years of experience. He is a member of the Association of Electricians and is certified by the Electrical Safety Authority.',
    'rating': 4.5,
    'image': AppImages.house,
  },
];

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
        title: Text(selectedIndex == 0? 'Artisan Profile': 'Reviews'),
        actions: [
          selectedIndex == 0?  IconButton(
            icon: SvgPicture.asset(SvgAssets.shareSend),
            onPressed: () {},
          ): const SizedBox(),
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
          if (selectedIndex == 0)
            overviewMeth(context, theme, guys, images),
          if (selectedIndex == 1)
            reviewsMeth(context, theme, reviews, guys),
        ],
      ),
    );
  }

}
