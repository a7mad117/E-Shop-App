import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/cubit/cubit.dart';
import '../styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = defaultColor,
  required Function() function,
  required String text,
  bool isUpperCase = true,
  double radius = 0.0,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      width: width,
      height: 40,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  void Function(String)? onSubmit,
  void Function(String)? onChang,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?) validator,
  required String labelText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  void Function()? suffixPress,
  bool? showCursor,
  bool readOnly = false,
  bool autofocus = false,
  TextInputAction? textInputAction,
}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: textInputType,
      onFieldSubmitted: onSubmit,
      onChanged: onChang,
      onTap: onTap,
      autofocus: autofocus,
      showCursor: showCursor,
      readOnly: readOnly,
      obscureText: isPassword,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixPress,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget myDivider() {
  return const Divider(
    color: Colors.grey,
    thickness: 1,
    indent: 20,
  );
}

void navigateTo(BuildContext context, Widget screen) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

void navigateAndFinish(BuildContext context, Widget screen) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );

Widget defaultTextButton({
  required Function() onPressed,
  required String text,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(text.toUpperCase()),
  );
}

void showBriefMsg({
  required String msg,
  BuildContext? context,
  BriefMsg state = BriefMsg.CUSTOM,
  bool isShowToast = false,
  bool isShowSnackBar = false,
  Toast? toastLength = Toast.LENGTH_LONG,
  ToastGravity? gravity = ToastGravity.BOTTOM,
  int timeInSecForIosWeb = 3,
  Color? backgroundColor,
  Color? textColor = Colors.white,
  double? fontSize = 16,
}) {
  if (isShowToast || context == null) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseBriefMsgColor(state) ?? backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
  if (isShowSnackBar && context != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Expanded(
            child: Text(
              msg.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize! - 2,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: chooseBriefMsgColor(state) ?? backgroundColor,
      duration: Duration(seconds: timeInSecForIosWeb),
      behavior: SnackBarBehavior.floating,
      elevation: 10.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      width: (msg.toString().length.toDouble() * 11) >=
              MediaQuery.of(context).size.width
          ? (msg.toString().length.toDouble() * 11) - 190
          : (msg.toString().length.toDouble() * 11),
    ));
  }
}

// ignore: constant_identifier_names
enum BriefMsg { SUCCESS, ERROR, WARNING, CUSTOM }

Color? chooseBriefMsgColor(BriefMsg state) {
  Color? color;
  switch (state) {
    case BriefMsg.SUCCESS:
      color = Colors.green;
      break;
    case BriefMsg.ERROR:
      color = Colors.red;
      break;
    case BriefMsg.WARNING:
      color = Colors.amber;
      break;
    case BriefMsg.CUSTOM:
      color = null;
      break;
  }
  return color;
}

Widget buildListProducts(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model!.image),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'SALES',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20, height: 1.3),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.round().toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),

                      ///
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.round().toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                            debugPrint(model.id.toString());
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id] ??
                                        false
                                    ? defaultColor
                                    : Colors.grey,
                            radius: 15,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
