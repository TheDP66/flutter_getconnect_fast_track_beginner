import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../../data/models/user_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getAllUsers(),
        builder: (context, snap) {
          // Jika masih fetching
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Jika tidak ada data
          if (snap.data?.isEmpty ?? true) {
            return const Center(
              child: Text("Tidak ada data user"),
            );
          }
          return ListView.builder(
            itemCount: snap.data?.length,
            itemBuilder: (context, index) {
              User user = snap.data![index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar!),
                ),
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: Text("${user.email}"),
              );
            },
          );
        },
      ),
    );
  }
}
