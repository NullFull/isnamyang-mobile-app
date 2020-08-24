class BarcodeInfo {
  final String barcode;
  final String brand;
  final String manufacturer;
  final String distributor;
  final String product;

  BarcodeInfo({this.barcode, this.brand, this.manufacturer, this.distributor, this.product});
  
  factory BarcodeInfo.fromJson(Map<String, dynamic> json) {
    return BarcodeInfo(
      barcode: json['바코드'],
      brand: json['브랜드'],
      manufacturer: json['제조사'],
      distributor: json['유통사'],
      product: json['제품명']
    );
  }
}