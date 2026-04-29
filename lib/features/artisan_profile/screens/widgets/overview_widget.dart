import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/handyman/models/handyman.dart';

Expanded overviewMeth(BuildContext context, ThemeData theme, Handyman detail, List images) {
    return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                shadowContainerMeth(
                  context: context,
                  theme: theme,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // CircleAvatar(
                          //   radius: 25,
                          //   backgroundImage: AssetImage(guys[0]['image']),
                          // ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  detail.fullName,
                                  style: theme.textTheme.headlineSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                ),
                                Text(
                                  detail.expertise,
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
                                      detail.location,
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
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        thickness: 2,
                        color: theme.colorScheme.secondary.withValues(
                          alpha: 0.1,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              detail.description,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(images.length, (index) {
                      return Container(
                        width: 126,
                        height: 113,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        
                      );
                    }),
                  ),
                ),
                SizedBox(height: 10),
                shadowContainerMeth(
                  context: context,
                  theme: theme,
                  child: Row(
                    children: [
                      Image.asset(AppImages.timer, width: 35, height: 35),
                      SizedBox(width: 10),
                      Text(
                        "Open 24 hours",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                shadowContainerMeth(
                  context: context,
                  theme: theme,
                  child: Row(
                    children: [
                      Image.asset(AppImages.phone, width: 35, height: 35),
                      SizedBox(width: 10),
                      Text(
                        "+234 000 000 000",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                shadowContainerMeth(
                  context: context,
                  theme: theme,
                  child: Row(
                    children: [
                      Image.asset(AppImages.whatsapp, width: 35, height: 35),
                      SizedBox(width: 10),
                      Text(
                        "Whatsapp",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                shadowContainerMeth(
                  context: context,
                  theme: theme,
                  child: Row(
                    children: [
                      Image.asset(AppImages.mail, width: 35, height: 35),
                      SizedBox(width: 10),
                      Text(
                        "Email",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
  }
