import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:isnamyang/Theme.dart';
import 'package:isnamyang/api/BarcodeApi.dart';
import 'package:isnamyang/model/BarcodeInfo.dart';

class ScanScreen extends StatefulWidget {
  static const routeName = '/scan';

  ScanScreen({Key key}) : super(key: key);
  final String title = '남양유없';

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);
  
  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  ScanResult scanResult;

  final BarcodeApi api = BarcodeApi();

  @override
  initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
      // showResult(BarcodeInfo(barcode: '123', product: '초코에몽')); // TEST
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = Image(image: AssetImage('assets/isnamyang-logo.png'));

    return Scaffold(
      appBar: null,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: logo,
                ),
                renderScanButton()
              ]
            )
          );
        }
      )
    );
  }

  Widget renderScanButton() {
    final scanStyle = TextStyle(fontSize: Themes.normalTextSize, color: Themes.buttonTextColor);

    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: ButtonTheme(
        minWidth: 44.0,
        padding: new EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: RaisedButton(
          child: Text('스캔하기', 
            style: scanStyle),
          onPressed: () => scan(),
          color: Themes.buttonColor,
      ))
    );
  }

  // if result is null, there is no information about this barcode.
  showResult(BarcodeInfo result) async {
    final confirmButtonText = Text('확인',
      style: TextStyle(color: Themes.resultTextColor),
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: null,
          content: SingleChildScrollView(
            child: ListBody(
              children: renderResult(result),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: confirmButtonText,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> renderResult(BarcodeInfo result) {
    final resultStyle = TextStyle(
      color: Themes.resultTextColor, 
      fontWeight: FontWeight.bold, 
      fontSize: Themes.resultTextSize);
    final productStyle = TextStyle(
      color: Themes.resultProductTextColor,
      fontWeight: FontWeight.bold, 
      fontSize: Themes.resultTextSize);
    
    if (result == null) {
      final isNotNamYang = '남양유업 제품이 아닙니다.';
      return [
        Text(isNotNamYang, style: resultStyle)
      ];
    } else {
      final isNamYang = '남양유업 제품입니다.';
      return [
        Text(isNamYang, style: resultStyle),
        Text(result.product, style: productStyle)
      ];
    }
  }

  createScanOptions() {
    final localization = {
      "cancel": '취소',
      "flash_on": '플래시 켜기',
      "flash_off": '플래시 끄기',
    };

    return ScanOptions(
      strings: localization,
      restrictFormat: selectedFormats,
      useCamera: _selectedCamera,
      autoEnableFlash: _autoEnableFlash,
      android: AndroidOptions(
        aspectTolerance: _aspectTolerance,
        useAutoFocus: _useAutoFocus,
      ),
    );
  }

  Future scan() async {
    try {
      var result = await BarcodeScanner.scan(options: createScanOptions());
      if (result.type == ResultType.Barcode) {
        api.queryBarcode(result.rawContent).then((value) => showResult(value));
      }
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      handleScanException(e);
    }
  }

  handleScanException(PlatformException e) {
    final errorMessage = '카메라 접근 권한이 필요합니다.';

    var result = ScanResult(
      type: ResultType.Error,
      format: BarcodeFormat.unknown,
    );

    if (e.code == BarcodeScanner.cameraAccessDenied) {
      setState(() {
        result.rawContent = errorMessage;
      });
    } else {
      result.rawContent = '오류: $e';
    }
    setState(() {
      scanResult = result;
    });
  }
}