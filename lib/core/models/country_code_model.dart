class CountryCode {
  final String dialCode;
  final String flag;

  const CountryCode({
    required this.dialCode,
    required this.flag,
  });
}

const countryCodes = [
  CountryCode(dialCode: "+234", flag: "🇳🇬"),
  CountryCode(dialCode: "+1", flag: "🇺🇸"),
  CountryCode(dialCode: "+44", flag: "🇬🇧"),
];