import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadAndOpenPdf(String url) async {
  try {
    // Get the temporary directory of the device
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    
    // Define the file path
    String filePath = '$tempPath/document.pdf';
    
    // Download the file
    await Dio().download(url, filePath);
    
    // Open the file
    OpenFile.open(filePath);
  } catch (e) {
    print('Error: $e');
  }
}