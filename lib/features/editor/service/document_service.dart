import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';

class DocumentService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isNetworkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar(
        "No Internet",
        "Please check your internet connection and try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<String?> uploadConfiguration(
      String jsonString,
      String fileName,
      ) async {
    if (!await isNetworkAvailable()) return null;

    try {
      Get.showOverlay(
        asyncFunction: () async {
          String uid = _auth.currentUser!.uid;
          List<dynamic> fields = jsonDecode(jsonString);

          DocumentReference docRef = await _firestore
              .collection('document_configs')
              .add({
            'owner_id': uid,
            'file_name': fileName,
            'fields': fields,
            'created_at': FieldValue.serverTimestamp(),
            'status': 'published',
          }).timeout(const Duration(seconds: 15));

          String shareableLink = "pe-app://config/${docRef.id}";

          Get.defaultDialog(
            title: "Share Configuration",
            middleText: "Copy this link to share: \n\n $shareableLink",
            textConfirm: "Copy",
            onConfirm: () {
              Clipboard.setData(ClipboardData(text: shareableLink));
              Get.back();
              Get.snackbar("Copied", "Link copied to clipboard!");
            },
          );
          return shareableLink;
        },
        loadingWidget: const Center(child: CircularProgressIndicator()),
      );
    } on FirebaseException catch (e) {
      Get.snackbar("Firebase Error", e.message ?? "Upload failed");
      return null;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
      return null;
    }
    return null;
  }



  Future<List<dynamic>?> fetchConfiguration(String docId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('document_configs').doc(docId).get();
      if (doc.exists) {
        return doc.get('fields') as List<dynamic>;
      }
      return null;
    } catch (e) {
      Get.snackbar("Error", "Invalid configuration link.");
      return null;
    }
  }
}