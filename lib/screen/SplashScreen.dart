import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:isnamyang/screen/ScanScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      requestPermission().then((value) => value ? goNextPage() : displayWarnMessage());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nullfullLogo = Image(image: AssetImage('assets/nullfull-logo.png'));
    return Scaffold(
      key: _scaffoldKey,
      appBar: null,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Center(
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: nullfullLogo,
            )
          );
        }
      )
    );
  }
  
  Future<bool> requestPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions = 
      await PermissionHandler().requestPermissions([PermissionGroup.camera]);
    return permissions[PermissionGroup.camera].value == PermissionStatus.granted.value;
  }

  void displayWarnMessage() {
    final message = Text('카메라 권한을 허용해주셔야 합니다. 앱을 재실행해주세요.');
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: message,
      duration: Duration(seconds: 3),
    ));
  }

  void goNextPage() {
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      ScanScreen.routeName,
    );
  }
}