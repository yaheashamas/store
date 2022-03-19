import 'package:store/modules/shop_login/login.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/network/local/cashe_helper.dart';

String token = "";

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

