import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:snapp/Pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool _showSecWidget = false;

class _LoginPageState extends State<LoginPage> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showSecWidget = true;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 204, 109, 1),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/snapp.svg", //asset location
                  height: 40,
                ),
              ),
            ],
          ),
        ),
        _showSecWidget
            ? Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white),
                      // color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(29.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'به اسنپ خوش آمدید.',
                                  style: TextStyle(
                                    package: 'persian_fonts',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                    fontFamily: 'Vazir',
                                  ),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Expanded(
                                  child: Text(
                                    'لطفاً شماره موبایل‌ خود را وارد کنید تا کد فعال‌سازی برای‌تان ارسال شود.',
                                    style: TextStyle(
                                      package: 'persian_fonts',
                                      color: Colors.black,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'Vazir',
                                    ),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'شماره موبایل',
                                  style: TextStyle(
                                    package: 'persian_fonts',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    fontFamily: 'Vazir',
                                  ),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            const Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.phone,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  package: 'persian_fonts',
                                  fontFamily: 'Vazir',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.to(MapPage()),
                                  child: Container(
                                      height: 55,
                                      width: 120,
                                      decoration: const BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: const Center(
                                        child: Text(
                                          'مرحله بعد',
                                          style: TextStyle(
                                              package: 'persian_fonts',
                                              fontFamily: 'Vazir',
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              )
            : const SizedBox()
      ]),
    );
  }
}
