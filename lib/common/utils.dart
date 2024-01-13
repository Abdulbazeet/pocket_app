// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/common/widgets/text_widget.dart';
import 'package:shopping_app/features/admin/add/screens/add.dart';
import 'package:shopping_app/features/admin/approval_page/screens/approval_page.dart';
import 'package:shopping_app/features/admin/home/screens/home.dart';
import 'package:shopping_app/features/admin/shop/screens/shop.dart';
import 'package:shopping_app/models/product_group.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

bool store = true;
int seletedIndex = 0;

///snackbar;
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
      ),
    ),
  );
}

void errorHandling({
  required BuildContext context,
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      Navigator.pop(context);
      print(jsonDecode(response.body));
      showSnackBar(
        context,
        jsonDecode(response.body),
      );
      break;
    case 500:
      Navigator.pop(context);
      print(jsonDecode(response.body));

      showSnackBar(
        context,
        jsonDecode(response.body),
      );
      break;
    default:
      Navigator.pop(context);
      print(jsonDecode(response.body));

      showSnackBar(
        context,
        jsonDecode(response.body),
      );
  }
}

Future<String?> getToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final token = await sharedPreferences.getString('token');
  return token;
}

Future<String?> getName() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final name = await sharedPreferences.getString('name');
  return name;
}

Future<bool?> getAdminStatus() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final adminStatus = await sharedPreferences.getBool('admin');
  return adminStatus;
}

Future<String?> getStoreName() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final storeName = await sharedPreferences.getString('storeName');
  return storeName;
}

String newStoreName = '';

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      print(image!);
    }
  } catch (e) {
    showSnackBar(
      context,
      e.toString(),
    );
  }
  return image;
}

int storeID = 0;
int newOrderId = 0;
int newQuantity = 0;
String uuid = const Uuid().v4(); // Generate a random UUID
List<Item> itemList = [];
var newPrice = 0.0;
String? name = '';
int ID = 0;

Future<File?> pick(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  if (result != null) {
    File imageFile = File(result.files.single.path!);
    var bytes = await rootBundle.load(imageFile.toString());
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$bytes');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    print(file);
    return file;
  } else {
    showSnackBar(
        context, 'Select image again'); // User canceled the file picking
  }
}

List<String> imageList = [];
bool edit = false;
bool productEdit = false;
List<String> newId = [];

String adminstoreName = '';
var newProductId = '';

String formatNumberWithCommas(String inputString) {
  double number = double.tryParse(inputString) ?? 0.0;

  String formattedNumber = NumberFormat('#,##0.0', 'en_US').format(number);

  return formattedNumber;
}

//

bool isDeliveryFeesEnabled = false;

String getFormattedValue() {
  return isDeliveryFeesEnabled ? 'True' : 'False';
}

bool search = false;
var receipt = [];
List newID = [];
var productSearchData = null;
var searchTool;
List productIdStrings = [];
final List pages = [
  const Home(),
  const Shop(),
  const Add(),
  const ApprovalPage(),
];
String rep = '';
var PRODUCTID = [];
void showFuction({required BuildContext context, required String orderId}) {

}
