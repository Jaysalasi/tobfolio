import 'package:flutter_svg/flutter_svg.dart';

class SvgAssets {
  SvgAssets._();

static final String apple = "assets/svg/solid_apple.svg";
static final String twitter = "assets/svg/x-twitter.svg";
static final String google = "assets/svg/devicon_google.svg";

static const String offerUp = "assets/svg/offerup.svg";
static const String backOutline = "assets/svg/back-outline.svg";
static const String dropdownArrow = "assets/svg/dropdown.svg";
static const String bell = "assets/svg/bell.svg";
static const String handymen = "assets/svg/handyman.svg";
static const String supportAgent = "assets/svg/support-agent.svg";
static const String pen = "assets/svg/pen.svg";
static const String barChart = "assets/svg/bar_chart.svg";
static const String share = "assets/svg/share.svg";
static const String aiLine = "assets/svg/si_ai-line.svg";
static const String starFade = "assets/svg/star-fade.svg";
static const String starGold = "assets/svg/star-gold.svg";
static const String dollar = "assets/svg/nav/expenses.svg";
static const String search = "assets/svg/search-normal.svg";
static const String shareSend = "assets/svg/ion_share-outline.svg";
static const String location = "assets/svg/ion_location.svg";
static const String tobWhite = "assets/svg/tob-white.svg";
static const String mastercard = "assets/svg/mastercard.svg";
static const String settingsOutline = "assets/svg/settings-outline.svg";
static const String copy = "assets/svg/bi_copy.svg";
static const String edit = "assets/svg/edit.svg";

// bottom navigation
static const String home = "assets/svg/nav/home.svg";
static const String homeOutline = "assets/svg/nav/home-outline.svg";
static const String rentals = "assets/svg/nav/rentals.svg";
static const String rentalsOutline = "assets/svg/nav/rentals-outline.svg";
static const String tenants = "assets/svg/nav/tenants.svg";
static const String tenantsOutline = "assets/svg/nav/tenants-outline.svg";
static const String expenses = "assets/svg/nav/expenses.svg";
static const String expensesOutline = "assets/svg/nav/expenses-outline.svg";
static const String user = "assets/svg/nav/user.svg";
static const String userOutline = "assets/svg/nav/user-outline.svg";
 

  static final List<String> allSvgs = [
    apple,
    twitter,
    google,
    offerUp,
    backOutline,
    dropdownArrow,
    bell,
    handymen,
    supportAgent,
    pen,
    barChart,
    share,
    aiLine,
    starFade,
    starGold,
    dollar,
    search,
    shareSend,
    location,
    tobWhite,
    home,
    homeOutline,
    rentals,
    rentalsOutline,
    expenses,
    expensesOutline,
    tenants,
    tenantsOutline,
    user,
    userOutline,
    mastercard,
    settingsOutline,
    copy,
    edit,
  ];

   static Future<void> preCacheSVGs() async {
    for (final path in allSvgs) {
      final loadSvg = SvgAssetLoader(path);
      await svg.cache.putIfAbsent(
        loadSvg.cacheKey(null),
        () => loadSvg.loadBytes(null),
      );
    }
  }

}