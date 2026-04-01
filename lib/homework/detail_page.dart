import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'detail_page_controller.dart';


class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.finalResult});

  final int finalResult;

  @override
  Widget build(BuildContext context) {
    final DetailPageController detailPageController =
    Get.put(DetailPageController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Final Result : $finalResult'),
      ),
      body: Obx(() {
        if (detailPageController.imageList.isEmpty) {
          return const Center(
            child: Text('This is the detail page'),
          );
        } else {
          return ListView.builder(
            itemCount: detailPageController.imageList.length,
            itemBuilder: (context, index) {
              final image = detailPageController.imageList[index];
              return ListTile(
                title: Text(image.author),
                subtitle: Text("Width: ${image.width}, Height: ${image.height}"),
                leading: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(image.download_url),
                ),
              );
            },
          );
        }
      }),
    );
  }
}