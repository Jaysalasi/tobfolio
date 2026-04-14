import 'package:flutter_svg/flutter_svg.dart';

class SvgAssets {
  SvgAssets._();

static final String apple = "assets/svg/solid_apple.svg";
static final String twitter = "assets/svg/x-twitter.svg";
static final String google = "assets/svg/devicon_google.svg";

static final String backwardThree = "assets/svg/backward-3.svg";
static final String forwardThree = "assets/svg/forward-3.svg";

static const String offerUp = "assets/svg/offerup.svg";
static const String backOutline = "assets/svg/back-outline.svg";
static const String dropdownArrow = "assets/svg/dropdown.svg";
static const String bell = "assets/svg/bell.svg";
static const String handymen = "assets/svg/handyman.svg";
static const String supportAgent = "assets/svg/support-agent.svg";
static const String pen = "assets/svg/pen.svg";
static const String plusFramed = "assets/svg/plus-framed.svg";
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
static const String upload = "assets/svg/upload.svg";
static const String expand = "assets/svg/expand.svg";
static const String userOutline = "assets/svg/nav/user-outline.svg";
static const String plus = "assets/svg/plus.svg";
static const String pokemon = "assets/svg/pokemon.svg";
static const String circle = "assets/svg/circle.svg";
static const String checked = "assets/svg/checked.svg";

static const String twitterX = "assets/svg/twitter.svg";
static const String tiktok = "assets/svg/tiktok.svg";
static const String insta = "assets/svg/insta.svg";
static const String thread = "assets/svg/thread.svg";
static const String filter = "assets/svg/filter.svg";

static const String evict = "assets/svg/evict.svg";

static const String good = "assets/svg/good.svg";

static const String premium = "assets/svg/premium.svg";



 

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
    plusFramed,
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
    upload,
    userOutline,
    mastercard,
    settingsOutline,
    copy,
    edit,
    twitterX,
    tiktok,
    insta,
    thread,
    expand,
    plus,
    pokemon,
    circle,
    checked,
    filter,
    evict,
    backwardThree,
    forwardThree,
    good,
    premium
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