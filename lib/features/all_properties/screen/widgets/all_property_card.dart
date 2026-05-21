import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/core/utils/currency_formatter.dart';
import 'package:tobfolio/features/all_properties/model/all_property_model.dart';
import 'package:tobfolio/features/home/bloc/home_bloc.dart';

class PropertyCard extends StatefulWidget {
  final PropertyModel property;
  final Function()? onDelete;
  final Function()? onEdit;

  const PropertyCard({
    super.key,
    required this.property,
    this.onDelete,
    this.onEdit,
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  int currentIndex = 0;
  final PageController controller = PageController();
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final property = widget.property;
    return GestureDetector(
      onTap: () {
        setState(() {
          showDetails = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: appShadow(context),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                /// IMAGE CAROUSEL
                Column(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 90,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: property.propertyImages.length,
                        onPageChanged: (i) {
                          setState(() => currentIndex = i);
                        },
                        itemBuilder: (_, i) {
                          // return Image.asset(property.images[i], fit: BoxFit.contain);
                          return Image.network(
                            property.propertyImages[i],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: List.generate(
                        property.propertyImages.length,
                        (i) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex == i
                                ? AppTheme.accentColor
                                : AppTheme.grayAltColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 16),

                /// DETAILS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TITLE ROW
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              property.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showDetails = true;
                              });
                            },
                            child: const Icon(Icons.more_horiz),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgAssets.location,
                            colorFilter: ColorFilter.mode(
                              AppTheme.darkBackgroundColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              property.address,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 10, color: AppTheme.grayColor),

                      _row("Property Type", property.type),

                      // const SizedBox(height: 6),
                      const Divider(height: 10, color: AppTheme.grayColor),

                      // _row("Total Income", "N${property.income.toStringAsFixed(0)}"),
                      const SizedBox(height: 6),

                      _row(
                        "Total Expenses",
                        CurrencyFormatter.formatCurrency(property.totalRenovationCost.toStringAsFixed(0), currencyCode: context.watch<HomeBloc>().state.user?.currency),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showDetails)
              Positioned(
                left: size.width * 0.4,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: appShadow(context),
                  ),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: widget.onDelete,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Delete property"),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onEdit,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Edit property"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
