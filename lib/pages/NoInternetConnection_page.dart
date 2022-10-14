import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
// import 'package:app_settings/app_settings.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 70,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Image.asset(
                        "assets/img1.png",
                        width: 150.0,
                      ),
                    ),
                    const Text(
                      'استثناء في الشبكة',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'يرجى محاولة الاتصال مرة أخرى والمحاولة مرة أخرى',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 41, 41, 41),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 150,
                child: GestureDetector(
                  // style: ButtonStyle(sha),
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      // color: const Color(0xff967EFD),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      'اعادة المحاولة',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 54, 54, 54),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: GestureDetector(
                  onTap: () async {
                    await AppSettings.openWIFISettings();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: const Text(
                      'عرض اعدادات الشبكة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 102, 255),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
