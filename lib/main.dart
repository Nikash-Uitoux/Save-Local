import 'dart:io';
import 'dart:core';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'as path;



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(child: Column(children: [
        Container(
            padding: const EdgeInsets.all(10),
            child: Image.network(url)),
        ElevatedButton(onPressed: ()
        async {
          var response = await http.get(Uri.parse(url));
          Directory? externalStorageDirectory =
              await getExternalStorageDirectory();
          File file = File(
            path.join(externalStorageDirectory!.path, path.basename(url)));
          await file.writeAsBytes(response.bodyBytes);
          showDialog(context: context, builder: (BuildContext context) => AlertDialog(
            title: const Text("Image saved Successfully"),
            content: Image.file(file),
          ));
        },
            child: const Text("Save Image"))
      ]),)
    );
  }

  // Future<String> createFolderInAppDocDir(String Imagesaver) async {
  //   //Get this App Document Directory
  //
  //   final Directory _appDocDir = await getApplicationDocumentsDirectory();
  //   //App Document Directory + folder name
  //   final Directory _appDocDirFolder =
  //   Directory('${_appDocDir.path}/$Imagesaver/');
  //
  //   if (await _appDocDirFolder.exists()) {
  //     //if folder already exists return path
  //     return _appDocDirFolder.path;
  //   } else {
  //     //if folder not exists create folder and then return its path
  //     final Directory _appDocDirNewFolder =
  //     await _appDocDirFolder.create(recursive: true);
  //     return _appDocDirNewFolder.path;
  //   }
  // }

}
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart' as path_provider;
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       // Remove the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'Kindacode.com',
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // This is the image file that will be displayed
//   // In the beginning, it is null
//   File? _displayImage;
//
//   // This is the flag to check if the image is downloading
//   // If it is true, the screen will show "Downloading..."
//   bool _isDownloading = false;
//
//   // URL of the image to download from the internet
//   final String _url =
//       'https://www.kindacode.com/wp-content/uploads/2022/02/orange.jpeg';
//
//   Future<void> _download() async {
//     // Set the flag to true
//     setState(() {
//       _isDownloading = true;
//     });
//
//     final response = await http.get(Uri.parse(_url));
//
//     // Get the image name
//     final imageName = path.basename(_url);
//     // Get the document directory path
//     final appDir = await path_provider.getApplicationDocumentsDirectory();
//
//     // This is the saved image path
//     // You can use it to display the saved image later
//     final localPath = path.join(appDir.path, imageName);
//
//     // Download the image
//     final imageFile = File(localPath);
//     await imageFile.writeAsBytes(response.bodyBytes);
//
//     setState(() {
//       _isDownloading = false;
//       _displayImage = imageFile;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(25),
//           child: Column(
//             children: [
//               ElevatedButton(
//                   onPressed: _download, child: const Text('Download Image')),
//               const SizedBox(height: 25),
//               _displayImage != null
//                   ? Image.file(_displayImage!)
//                   : Center(
//                 child: _isDownloading
//                     ? const Text(
//                   'Downloading...',
//                   style: TextStyle(fontSize: 35),
//                 )
//                     : null,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }