import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            System.data.color!.primaryColor,
            System.data.color!.primaryDark,
          ],
        ),
        // image: const DecorationImage(
        //   image: AssetImage(
        //     "assets/background_aksen.png",
        //   ),
        //   alignment: Alignment.topCenter,
        //   repeat: ImageRepeat.noRepeat,
        // ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: Container(
                color: Colors.transparent,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo_jamkrindo_putih.png",
                      width: 180,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                      color: Colors.white,
                    ),
                    Image.asset(
                      "assets/logo_ifg_horizontal.png",
                      width: 100,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Text(
                          "Versi ${System.data.versionName}",
                          style:
                              System.data.textStyles!.boldTitleLabel.copyWith(
                            color: System.data.color!.lightTextColor,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          System.data.copyrightName,
                          style:
                              System.data.textStyles!.boldTitleLabel.copyWith(
                            color: System.data.color!.lightTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
