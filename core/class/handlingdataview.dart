import 'dart:ui';

import 'package:mohammed_admin/core/class/status_request.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView({
    Key? key,
    required this.statusRequest,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return Stack(
        children: [
          widget,
          // dim the background
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.25)),
          ),

          // modern glass-like loader
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.22),
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // gradient circular progress
                      SizedBox(
                        width: 56,
                        height: 56,
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              colors: [Color(0xFF5EE7DF), Color(0xFF4A00E0)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(rect);
                          },
                          child: const CircularProgressIndicator(
                            strokeWidth: 5,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            backgroundColor: Colors.white24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "جارٍ التحميل...",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "الرجاء الانتظار",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    
    // if (statusRequest == StatusRequest.loading) {

    //   return Stack(
    //     children: [
    //       widget,

    //       Container(
    //         color: Colors.black.withOpacity(0.3),
    //         child: Center(
    //           child: Container(
    //             height: 100,
    //             //width:400,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(16),
    //               // color: Colors.white,
    //             ),
    //             child: CircularProgressIndicator(),
    //           ),
    //         ),
    //       ),
    //     ],
    //   );
    // }

    // باقي الحالات: نخلي الصفحة، ونظهر تنبيه بدال الـ Cover
    if (statusRequest == StatusRequest.offlinefailure) {
      Future.microtask(() {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("أنت غير متصل بالانترنت")));
      });
    }

    if (statusRequest == StatusRequest.serverfailure) {
      Future.microtask(() {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("مشكلة في السيرفر")));
      });
    }

    if (statusRequest == StatusRequest.failure) {
      Future.microtask(() {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("لا توجد بيانات")));
      });
    }

    // الصفحة تبقى دومًا بالخلفية
    return widget;
  }
}

class AppImageAsset {
  static const String rootImages = "assets/images";
  static const String rootLottie = "assets/lottie";
  static const String logo = "$rootImages/logoapp.png";
  static const String onBoardingImageOne = "$rootImages/one.PNG";
  static const String onBoardingImageTwo = "$rootImages/two.PNG";
  static const String onBoardingImageThree = "$rootImages/three.PNG";
  static const String loading = "$rootLottie/loading.json";
  static const String offline = "$rootLottie/offline.json";
  static const String noData = "$rootLottie/nodata.json";
  static const String server = "$rootLottie/server.json";

  // static const String onBoardingImageFour   = "$rootImages/onboardingfour.PNG" ;
}
