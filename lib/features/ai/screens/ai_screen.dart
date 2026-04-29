import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  final List<String> _actions = [
    "Generate leasing form",
    "Generate contract",
    "Ask questions about your portfolio",
  ];
  
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
     final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
      backgroundColor: theme.colorScheme.tertiary,
        title:  Text(""),
      ),
      body:  Stack(
        children: [
          Expanded(
            child: Center(
              child:
               Text("What can I do for you?", style: theme.textTheme.titleLarge?.copyWith(fontSize: 25),),
            ),
          ),
       
             Positioned(
               bottom: 150,
               left: 20,
               right: 20,
               child: Column(
                spacing: 10,
                 children: _actions.asMap().entries.map((entry) {
                   return Row(
                     children: [
                       Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        // height: 50,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: AppTheme.lightSurfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: appShadow(context)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_actions[entry.key], style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),),
                          SvgPicture.asset(SvgAssets.expand)
                          ],
                        )),
                     ],
                   );
                 }).toList(),
               ),
             ),
             Positioned(
               bottom: 0,
               left: 0,
               right: 0,
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Expanded(
                     child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.grayAltColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text("Our AI Beta feature drops soon", style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),))),
                   ),
                 ],
               ),
             ),
        ],
      ),
    );
  }
}