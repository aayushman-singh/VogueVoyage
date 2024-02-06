import 'dart:convert';
import 'dart:io';
import 'package:clothing/features/text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:clothing/screens/carousels.dart';
import 'package:clothing/utils/adjustments.dart'; // Ensure you have a HomeModel class to manage your app state
import 'package:clothing/utils/image_data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PermissionExample extends StatefulWidget {
  @override
  _PermissionExampleState createState() => _PermissionExampleState();
}

class _PermissionExampleState extends State<PermissionExample> {
  // Define the permission status
  PermissionStatus _status = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    // Check and request the desired permission when the widget is initialized
    _checkPermission();
  }

  // Function to check and request the permission
  Future<void> _checkPermission() async {
    // Check if the permission is granted
    final status = await Permission.camera.status;
    setState(() {
      _status = status;
    });

    // If the permission is not granted, request it
    if (!_status.isGranted) {
      final result = await Permission.camera.request();
      setState(() {
        _status = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Camera Permission Status: $_status'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _checkPermission,
              child: Text('Check Permission'),
            ),
          ],
        ),
      ),
    );
  }
}

Future _showOccasionMenu(BuildContext context) async {
  final String? result = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text('Select Occasion'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'casual');
            },
            child: Text('Casual'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'formal');
            },
            child: Text('Formal'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'other');
            },
            child: Text('Other'),
          ),
        ],
      );
    },
  );

  // Set the selected occasion in HomeModel
  if (result != null) {
    final homeModel = Provider.of<HomeModel>(context, listen: false);
    homeModel.setOccasion(result);
  }
}

Future _showApparelMenu(BuildContext context) async {
  // You can populate this list based on your needs
  final List<String> options = [
    'Tshirts',
    'Tops',
    'Shirts',
    'Jeans',
    'Pants',
    'Shoes',
    'Boots',
    'Skirts',
    'Dresses',
    'Jackets',
    'Blazers',
    'Heels',
    'Hats',
    'Shorts'
  ];

  final String? result = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text('Select Apparel Type'),
        children: options
            .map((option) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, option);
                  },
                  child: Text(option),
                ))
            .toList(),
      );
    },
  );

  // Set the selected apparel input in HomeModel
  if (result != null) {
    final homeModel = Provider.of<HomeModel>(context, listen: false);
    final boxToApparelTypeMapProvider =
        Provider.of<BoxToApparelTypeMap>(context, listen: false);
    homeModel.setApparelInput(result);
    boxToApparelTypeMapProvider.updateApparelTypeMap(result);
    print(boxToApparelTypeMapProvider.boxToApparelTypeMap);
    print(result);
    print("Current ApparelInput: ${homeModel.apparelInput}");
  }
}

Future _showColorMenu(BuildContext context) async {
  // You can populate this list based on your needs
  final List<String> options = [
    'Red',
    'Green',
    'Blue',
    'Yellow',
    'Orange',
    'Purple',
    'Black',
    'White',
    'Gray',
    'Pink',
    'Cyan',
    'Magenta',
    'Lime',
    'Maroon',
    'Navy',
    'Olive',
    'Turquoise',
    'Coral',
  ];

  final String? result = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text('Select Color'),
        children: options
            .map((option) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, option);
                  },
                  child: Text(option),
                ))
            .toList(),
      );
    },
  );

  // Set the selected apparel input in HomeModel
  if (result != null) {
    final homeModel = Provider.of<HomeModel>(context, listen: false);
    print(result);
    homeModel.setColor(result);
    print("Current ApparelColor: ${homeModel.apparelColor}");
  }
}

class YoloImageV8 extends StatefulWidget {
  final FlutterVision vision;
  const YoloImageV8({Key? key, required this.vision}) : super(key: key);

  @override
  State<YoloImageV8> createState() => _YoloImageV8State();
}

class _YoloImageV8State extends State<YoloImageV8> {
  void updateModel(String label) {
    print('successfully upadted');
    final homeModel = Provider.of<HomeModel>(context, listen: false);
    homeModel.setApparelInput(label);
    print(homeModel);
    final boxToApparelTypeMapProvider =
        Provider.of<BoxToApparelTypeMap>(context, listen: false);
    boxToApparelTypeMapProvider.updateApparelTypeMap(label);
    print(boxToApparelTypeMapProvider.boxToApparelTypeMap);
  }

  late List<Map<String, dynamic>> yoloResults;
  File? imageFile;
  int imageHeight = 1;
  int imageWidth = 1;
  bool isLoaded = false;
  String imagePath = 'C:/Users/Aayushman/Downloads/tshirt.jpg';
  @override
  void initState() {
    setState(() {
      yoloResults = [];
      isLoaded = true;
      imagePath = 'C:/Users/Aayushman/Downloads/tshirt.jpg';
    });
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: Text("Model not loaded, waiting for it"),
        ),
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        imageFile != null ? Image.file(imageFile!) : const SizedBox(),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showOccasionMenu(context),
                  child: const Text('Occasion'),
                ),
                ElevatedButton(
                  onPressed: () => _showApparelMenu(context),
                  child: const Text('Apparel'),
                ),
                ElevatedButton(
                  onPressed: () => _showColorMenu(context),
                  child: const Text('Color'),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: pickImage,
                child: const Text("Pick an image"),
              ),
              ElevatedButton(
                onPressed: yoloOnImage,
                child: const Text("Detect"),
              )
            ],
          ),
        ),
      ],
    );
  }

  //Future<void> loadYoloModel() async {
  // await widget.vision.loadYoloModel(
  //     labels: 'assets/labels.txt',
  //     modelPath: 'assets/yolov8n.tflite',
  //   modelVersion: "yolov8",
  //    quantization: false,
  //     numThreads: 2,
  //   useGpu: true);
  //setState(() {
  //   isLoaded = true;
  // });
  //}

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      print("Image path: ${photo.path}");
      setState(() {
        imageFile = File(photo.path);
        imagePath = photo.path; // Set imagePath here
      });

      // Call the yoloOnImage function after setting the imagePath
      await yoloOnImage();
    }
  }

  yoloOnImage() async {
  final homeModel = Provider.of<HomeModel>(context, listen: false);
  final boxToApparelTypeMapProvider =
      Provider.of<BoxToApparelTypeMap>(context, listen: false);

    var uri = Uri.parse('http://192.168.29.210:5000/predict');
    var request = http.MultipartRequest('POST', uri);

    // Add the image file to the request
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));

    var response = await request.send();
    if (response.statusCode == 200) {
      // Handle the response here
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonObject = json.decode(responseString);
      print(responseString);
      String label = responseString;
      print(label); // Corrected line
      // Use the label as needed
      updateModel(label);
      showToast(message: label);
      
    } else {
      // Handle errors
      print('Failed to make the prediction request');
    }
  }
}

class ImagePreviewDialog extends StatelessWidget {
  final String? imagePath;
  final String? label;
  final String? colorHex;

  ImagePreviewDialog({this.colorHex, this.imagePath, this.label});

  @override
  Widget build(BuildContext context) {
    final boxToApparelTypeMapProvider =
        Provider.of<BoxToApparelTypeMap>(context, listen: false);

    boxToApparelTypeMapProvider.updateApparelTypeMap(label!);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown[400], // Coffee color
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(File(imagePath!)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    boxToApparelTypeMapProvider.updateApparelTypeMap(label!);
                    Navigator.pop(context); // Close the dialog
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Carousels(),
                      ),
                    );
                  },
                  child: Text('Continue'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
