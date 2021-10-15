import 'package:flutter/material.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';

class DialogService {
  final BuildContext context;

  DialogService(this.context);

  void showSnackbar(
    String content,
    GlobalKey<ScaffoldState> _scaffoldKey, {
    SnackBarType type = SnackBarType.SUCCESS,
    Function() dismiss,
    int milliseconds = 2000,
  }) {
    var backgroundColor = Colors.white;
    switch (type) {
      case SnackBarType.SUCCESS:
        backgroundColor = primaryColor;
        break;
      case SnackBarType.WARING:
        backgroundColor = Colors.orangeAccent;
        break;
      case SnackBarType.INFO:
        backgroundColor = blueColor;
        break;
      case SnackBarType.ERROR:
        backgroundColor = Colors.red;
        break;
      case SnackBarType.PROCESSING:
        backgroundColor = darkBlueColor;
        break;
    }

    _scaffoldKey.currentState
      .showSnackBar(SnackBar(
        content: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(offsetSm)),
          elevation: 1.0,
          child: Container(
            padding: EdgeInsets.all(offsetBase),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
              color: backgroundColor,
            ),
            child: Text(content, style: semiBold.copyWith(fontSize: fontMd, color: Colors.white),),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(milliseconds: milliseconds),
      )
    ).closed.then((value) {
        if (dismiss != null) dismiss();
      }
    );
  }

  Future<dynamic> showCustomDialog({
    Widget contentWidget,
  }) async {
    return await showDialog<dynamic>(
      context: context,
      builder: (context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: contentWidget,
        ),
      ),
    );
  }
}
