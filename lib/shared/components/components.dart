import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  required String? text,
  required VoidCallback? function,
  double width = double.infinity,
  Color color = Colors.blue,
}) =>
    Container(
      width: width,
      color: color,
      child: MaterialButton(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onPressed: function,
      ),
    );

Widget defaultTextFormField({
  required var controller,
  required String text,
  required IconData iconData,
  required TextInputType textInputType,
  FormFieldValidator<String>? validation,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChange,
  bool isSecure = false,
  bool enabled = true,
  IconData? suffix,
  VoidCallback? suffixFunction,
}) =>
    TextFormField(
      controller: controller,
      scrollController: ScrollController(
        initialScrollOffset: 50.0,
      ),
      decoration: InputDecoration(
        labelText: text,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixFunction,
                icon: Icon(suffix),
              )
            : null,
        border:
            OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid)
                // borderRadius: BorderRadius.all(
                //   Radius.circular(50),
                // ),
                ),
        prefixIcon: Icon(iconData),
      ),
      onChanged: onChange,
      onTap: onTap,
      enabled: enabled,
      keyboardType: textInputType,
      validator: validation,
      obscureText: isSecure,
    );

Widget defaultIconButton({
  VoidCallback? function,
  IconData? iconData,
  Color? color,
}) {
  return IconButton(
    onPressed: function,
    icon: Icon(iconData),
    color: color,
  );
}

Widget defaultNews({
  String? image,
  String? title,
  String? history,
  context,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Image.network(
            image.toString(),
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toString(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 10.0),
              Text(
                history.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget newsBuilder({
  required BuildContext context,
  cubit,
}) {
  return ListView.separated(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return defaultNews(
        image: cubit[index]['urlToImage'] ??
            "https://www.gizmohnews.com/assets/images/news.png",
        title: cubit[index]['title'],
        history: cubit[index]['publishedAt'],
        context: context,
      );
    },
    separatorBuilder: (context, index) => Divider(),
    itemCount: cubit.length,
  );
}

//navigation
void navigateTo({
  required context,
  required Widget,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateToRemove({
  required context,
  required Widget,
}) =>
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Widget),
        (Route<dynamic> route) => false);

//toast
enum colorsToast {
  SUCCESS,
  ERROR,
  WARNING,
}

choseColorToaster({
  required colorsToast colorToast,
}) {
  late Color color;
  switch (colorToast) {
    case colorsToast.SUCCESS:
      color = Colors.green;
      break;
    case colorsToast.ERROR:
      color = Colors.red;
      break;
    case colorsToast.WARNING:
      color = Colors.yellowAccent;
      break;
  }
  return color;
}

void defaultToast({
  required String message,
  required colorsToast colorsToaster,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseColorToaster(colorToast: colorsToaster),
      textColor: Colors.white,
      fontSize: 16.0,
    );

Widget defaultLoading() => Center(
      child: CircularProgressIndicator(),
    );

Widget defaultImage({
  required String urlImage,
  double? width,
  double? height,
}) =>
    ExtendedImage.network(
      urlImage,
      width: width,
      height: height,
      cache: true,
      alignment: Alignment.center,
    );
