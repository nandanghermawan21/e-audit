import 'package:eaudit/component/circular_loader_component.dart';
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
        image: const DecorationImage(
          image: AssetImage(
            "assets/background_aksen.png",
          ),
          alignment: Alignment.topCenter,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
      child: CircularLoaderComponent(
        controller: loadingController,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Container(
                  color: Colors.transparent,
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      logo(),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                "Login E-Audit",
                                style: System.data.textStyles!.boldTitleLabel,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            StreamBuilder<bool>(
                              stream: userNameErrorState.stream,
                              initialData: false,
                              builder: (c, s) {
                                return TextField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0.5,
                                        color: s.data == true
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            StreamBuilder(
                              initialData: false,
                              stream: passwordErrorState.stream,
                              builder: (c, s) {
                                return TextField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0.5,
                                        color: s.data == true
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  obscureText: true,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  login();
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        System.data.color!.primaryColorLight)),
                                child: Text(
                                  "Login",
                                  style:
                                      System.data.textStyles!.basicLightLabel,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: footer(),
        ),
      ),
    );
  }

  Widget logo() {
    return Container(
      color: Colors.transparent,
      width: 200,
      child: Column(
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
    );
  }

  Widget footer() {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              "Versi ${System.data.versionName}",
              style: System.data.textStyles!.boldTitleLabel.copyWith(
                color: System.data.color!.lightTextColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              System.data.copyrightName,
              style: System.data.textStyles!.boldTitleLabel.copyWith(
                color: System.data.color!.lightTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
