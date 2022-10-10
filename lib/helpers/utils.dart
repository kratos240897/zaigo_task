import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final mediaQuery = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
final height = mediaQuery.size.height;
final width = mediaQuery.size.width;

SizedBox hSpace(double value) {
  return SizedBox(width: value);
}

SizedBox vSpace(double value) {
  return SizedBox(height: value);
}

MaterialColor getMaterialColorFromColor(Color color) {
  Map<int, Color> colorShades = {
    50: getShade(color, value: 0.5),
    100: getShade(color, value: 0.4),
    200: getShade(color, value: 0.3),
    300: getShade(color, value: 0.2),
    400: getShade(color, value: 0.1),
    500: color, //Primary value
    600: getShade(color, value: 0.1, darker: true),
    700: getShade(color, value: 0.15, darker: true),
    800: getShade(color, value: 0.2, darker: true),
    900: getShade(color, value: 0.25, darker: true),
  };
  return MaterialColor(color.value, colorShades);
}

Color getShade(Color color, {bool darker = false, double value = .1}) {
  assert(value >= 0 && value <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value))
          .clamp(0.0, 1.0));

  return hslDark.toColor();
}

hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

showLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                return SizedBox(
                  height: height * 0.25,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Loading...',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  fontSize: 20.0,
                                  ),
                        ),
                        vSpace(12.0),
                        const CupertinoActivityIndicator(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ));
}

showSnackBar(
    String title, String message, BuildContext context, bool isSucess) async {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(15.0),
      content: SizedBox(
        height: height * 0.080,
        child: Row(children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: isSucess ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(5.0)),
                width: 10.0,
              ),
              hSpace(15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  vSpace(5.0),
                  SizedBox(
                    width: width * 0.70,
                    child: Text(message,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontSize: 14.0,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          )
        ]),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
