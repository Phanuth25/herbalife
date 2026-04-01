import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart';
import 'package:project2/homework/img_model.dart';

class DetailPageController extends GetxController {
  static DetailPageController get instance => Get.find();

  RxList<ImgModel> imageList = <ImgModel>[].obs;
  final dio = Dio();
  final GET_IMAGE_URL_LIST = "https://picsum.photos/v2/list";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      final response = await dio.get(GET_IMAGE_URL_LIST);
      final list = response.data as List;
      final images = list.map((item) => ImgModel.fromJson(item)).toList();
      imageList.value = images;
      Get.snackbar(
        "Success",
        "Total images: ${imageList.length}",
        backgroundColor: Colors.lightBlueAccent,
        snackPosition: SnackPosition.TOP,
      );
    } on DioException catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}