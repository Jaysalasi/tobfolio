import 'package:flutter/material.dart';
import 'package:tob/core/utils/components/app_button.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
      backgroundColor: theme.colorScheme.tertiary,
        title: const Text("Terms and Conditions"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.v",
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
            ,
            Column(
              children: [
                AppButton(title: "I've read and accepted", onPressed: () {
        
                }),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Center(
                      child: GestureDetector(onTap: () {
                        Navigator.pop(context);
                      }, child: Text("Cancel", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),)),
                    )),
                  ],
                ),
                SizedBox(height: 40,),
              ],
            )
          ],
        ),
      ),
    );
  }
}