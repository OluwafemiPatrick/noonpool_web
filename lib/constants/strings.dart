import 'package:intl/intl.dart';

const String appName = "NoonPool";
const String manrope = "Manrope";
const String logoLocation = "assets/images/mini_logo.png";
const String fullLogoLocation = "assets/images/logo.png";
const String supportEmailAddress = "support@noonpool.com";

final _numberFormatter = NumberFormat("#,##0.00000", "en_US");

String formatNumber(double number) {
  return _numberFormatter.format(number);
}
