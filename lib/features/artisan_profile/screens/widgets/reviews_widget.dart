import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/widgets.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/core/utils/constants/assets/pngs.dart';
import '../../models/review.dart';
import '../../../handyman/models/handyman.dart';
import 'write_review_dialog.dart';

Expanded reviewsMeth(
  BuildContext context,
  ThemeData theme,
  List<Review> reviews,
  Handyman handyman,
) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                buildRatingSummary(theme),
                const SizedBox(height: 25),
                buildDistribution(),
                const SizedBox(height: 25),
                buildReviewHeader(reviews, context, handyman.id),
                SizedBox(height: 10),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 10),
              if (reviews.isEmpty)
                Center(
                  child: Text(
                    'No reviews yet',
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              else
                ...List.generate(reviews.length, (index) {
                  final review = reviews[index];
                  return shadowContainerMeth(
                    context: context,
                    theme: theme,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                AppImages.house,
                              ), // Use default image since no user image in API
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        review.reviewer.name,
                                        style: theme.textTheme.headlineSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                      ),
                                      StarRow(rating: review.rating),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Text(
                                    review.comment,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildRatingSummary(ThemeData theme) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        "4.5",
        style: theme.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
      ),
      const SizedBox(width: 5),
      Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          "OUT OF 5",
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
        ),
      ),
      const Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StarRow(rating: 4),
          SizedBox(height: 6),
          Text(
            "1.7 ratings",
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildDistribution() {
  return Column(
    children: [
      RatingBarRow(star: 5, percentage: 0.67, label: "67%"),
      RatingBarRow(star: 4, percentage: 0.14, label: "14%"),
      RatingBarRow(star: 3, percentage: 0.05, label: "5%"),
      RatingBarRow(star: 2, percentage: 0.03, label: "3%"),
      RatingBarRow(star: 1, percentage: 0.01, label: "1%"),
    ],
  );
}

Widget buildReviewHeader(
  List<Review> reviews,
  BuildContext context,
  String handymanId,
) {
  return Row(
    children: [
      Text("${reviews.length} Reviews", style: TextStyle(fontSize: 16)),
      const Spacer(),
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => WriteReviewDialog(handymanId: handymanId),
          );
        },
        child: const Row(
          children: [
            Text(
              "WRITE A REVIEW",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 6),
            Icon(Icons.edit_outlined, color: Colors.blue, size: 18),
          ],
        ),
      ),
    ],
  );
}

class RatingBarRow extends StatelessWidget {
  final int star;
  final double percentage;
  final String label;

  const RatingBarRow({
    super.key,
    required this.star,
    required this.percentage,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text("$star", style: TextStyle(fontSize: 16)),
          SizedBox(width: 6),
          SvgPicture.asset(SvgAssets.starGold),
          SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percentage,
                minHeight: 6,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }
}

class StarRow extends StatelessWidget {
  final int rating;

  const StarRow({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => SvgPicture.asset(
          SvgAssets.starGold,
          width: 19,
          height: 19,
          colorFilter: ColorFilter.mode(
            index < rating ? AppTheme.goldColor : AppTheme.neutralColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:  0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jane d Doe",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    StarRow(rating: 4),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "I am very satisfied with his electrical services, my sockets function much more better now.",
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
