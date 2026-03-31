import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import '../../../core/theme/app_theme.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to TOB',
      description:
          'Move your messy ledgers, spreadsheets, and WhatsApp chats into one sleek dashboard.',
      icon: AppImages.planning,
      color: AppTheme.primaryColor,
    ),
    OnboardingPage(
      title: 'Secure & Fast',
      description: 'Manage your 80+ units in minutes',
      icon: AppImages.glassHome,
      color: AppTheme.secondaryColor,
    ),
    OnboardingPage(
      title: 'Get Started',
      description: 'Send automated rent reminders',
      icon: AppImages.payment,
      color: AppTheme.accentColor,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    context.read<OnboardingCubit>().goToPage(page);
  }

  void _nextPage() {
    final cubit = context.read<OnboardingCubit>();
    if (cubit.state.currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  void _completeOnboarding() async {
    await context.read<OnboardingCubit>().completeOnboarding();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/register');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: size.height * 0.25),
            // Expanded(child: Container()),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    page: _pages[index],
                    currentPage: index,
                  );
                },
              ),
            ),
            // const SizedBox(height: 32),
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: state.currentPage == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: state.currentPage == index
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.tertiaryContainer
                                  : Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: state.currentPage < 2
                            ? Row(
                                children: [
                                  GestureDetector(
                                    onTap: _skipOnboarding,
                                    child: Text(
                                      'Skip',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.lightCardColor,
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: _nextPage,
                                    child: Text(
                                      state.currentPage == _pages.length - 1
                                          ? 'Get Started'
                                          : 'Next',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.accentColor,
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),
                                ],
                              )
                            : AppButton(
                                backgroundColor: AppTheme.accentColor,
                                textColor: AppTheme.darkBackgroundColor,
                                title: "Get Started",
                                onPressed: _skipOnboarding,
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String icon;
  final Color color;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;
  final int currentPage;

  const OnboardingPageWidget({
    super.key,
    required this.page,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentPage > 0)
                SvgPicture.asset(SvgAssets.backwardThree)
              else
                const SizedBox(width: 24),

              Image.asset(
                page.icon,
                // color: Colors.white,
              ),
              if (currentPage < 2)
                SvgPicture.asset(SvgAssets.forwardThree)
              else
                const SizedBox(width: 24),
            ],
          ),
          const SizedBox(height: 48),
          // Text(
          //   page.title,
          //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          //     fontWeight: FontWeight.bold,
          //     color: Theme.of(context).colorScheme.surface,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
          // const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * (currentPage == 0 ? 0.1 : currentPage == 1 ? 0.15 : 0.2),
            ),
            child: Text(
              page.description,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                // height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
