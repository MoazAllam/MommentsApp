import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lahazaat/pages/NoInternetConnection_page.dart';
import 'package:lahazaat/pages/WebView_page.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';

import '../services/notification_services.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key}); // Modify
  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  bool activeConnection = false;

  var connectionStatus = 0.obs;

  late StreamSubscription<InternetConnectionStatus> _listener;

  InAppWebViewController? controller;

  @override
  void initState() {
    _listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          connectionStatus.value = 1;
          break;
        case InternetConnectionStatus.disconnected:
          connectionStatus.value = 0;
          break;
      }
    });
    NotificationService.init();
    dailyNotifications();
    notifications();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listener.cancel();
  }

  Future<void> dailyNotifications() async {
    final scheduler = NeatPeriodicTaskScheduler(
      interval: const Duration(hours: 1),
      name: 'hello-world',
      timeout: const Duration(hours: 1),
      task: () async => NotificationService.showNotification(
        title: "لحظات",
        body: "تعالى دردش في غرفة صوتية!",
        payload: "lol",
      ),
    );

    Future.delayed(const Duration(hours: 1), () {
      scheduler.start();
    });

    await ProcessSignal.sigterm.watch().first;
    await scheduler.stop();
  }

  void notifications() async {
    await NotificationService.showDailyNotification(
      title: "لحظات",
      body: "!قم بدردشة من تريد في أي وقت تريد ودخول كل غرف الدردشة التي تريد",
      payload: "lol",
      date: DateTime.now().add(const Duration(seconds: 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => connectionStatus.value == 1
          ? WillPopScope(
              onWillPop: () => onBackButtonPressed(context),
              child: const Scaffold(
                body: SafeArea(
                  child: WebViewPage(),
                ),
              ),
            )
          : const NoInternetPage(),
    );
  }

  Widget dialogButton(
    String title,
    IconData iconData,
    Callback tap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: tap,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 100,
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xff00DC82),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              iconData,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  Future<bool> onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      barrierColor: const Color.fromARGB(199, 0, 0, 0),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              dialogButton(
                "الرجوع",
                FontAwesomeIcons.arrowLeft,
                // Icons.arrow_back_ios,
                () => controller?.goBack(),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const WebViewPage()),
                // ),
              ),
              dialogButton(
                "الخروج من التطبيق",
                FontAwesomeIcons.xmark,
                () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        );
      },
    );

    return exitApp;
  }
}

class AppIcon extends StatelessWidget {
  const AppIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            image: const DecorationImage(
                image: AssetImage('assets/logo.png'), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
