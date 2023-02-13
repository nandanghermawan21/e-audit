import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/realisasi_detail_model.dart';
import 'package:eaudit/model/year_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
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
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          drawer: drawer(),
          body: GestureDetector(
            onVerticalDragEnd: (dt) {
              if (dt.velocity.pixelsPerSecond.direction > 1) {
                if (dt.velocity.pixelsPerSecond.distance > 2000) {
                  getRealisasiData();
                }
              }
            },
            child: Column(
              children: [
                appbar(),
                Container(
                  height: 30,
                  color: Colors.transparent,
                  child: Center(
                    child: YearModel.yearSelector(
                      selectedYear: selectedYear,
                      onChange: (v) {
                        selectedYear = v;
                        getRealisasiData();
                      },
                    ),
                  ),
                ),
                StreamBuilder<RealisasiDetailModel?>(
                  initialData: null,
                  stream: dataRealisasiStream.stream,
                  builder: (c, s) {
                    return header(
                      isLoading: s.data == null,
                      isError: s.hasError ? true : false,
                      data: s.data,
                    );
                  },
                ),
                Expanded(
                  child: mainMenu(),
                ),
                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appbar() {
    return SafeArea(
      child: Container(
        height: 70,
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                openDrawer();
              },
              child: Container(
                width: 60,
                color: Colors.transparent,
                child: const Center(
                  child: Icon(
                    FontAwesomeIcons.bars,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo_jamkrindo_putih.png",
                    width: 100,
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.white,
                    thickness: 1,
                  ),
                  Image.asset(
                    "assets/logo_ifg_horizontal.png",
                    width: 70,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                "${System.data.global.user?.userUsername}",
                                style: System.data.textStyles!.boldTitleLabel
                                    .copyWith(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Text(
                              "${System.data.global.user?.groupName}",
                              style: System.data.textStyles!.boldTitleLabel
                                  .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        logout();
                      },
                      child: const Icon(
                        FontAwesomeIcons.userAlt,
                        color: Colors.white,
                        size: 50,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget header({
    bool isLoading = false,
    bool isError = false,
    RealisasiDetailModel? data,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          headerItem(
            value: data?.ongoing,
            isError: isError,
            isLoading: isLoading,
          ),
          headerItem(
            icon: "assets/icon_finding.png",
            background: "assets/background_finding.png",
            label: "Total \n Finding",
            value: data?.finding,
            isError: isError,
            isLoading: isLoading,
          ),
          headerItem(
            icon: "assets/icon_recomendation.png",
            background: "assets/background_recomendation.png",
            label: "Total \n Recomendation",
            value: data?.recomendation,
            isError: isError,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }

  Widget headerItem({
    String? icon,
    String? background,
    String? label,
    int? value,
    bool isLoading = false,
    bool isError = false,
  }) {
    return Container(
      width: 120,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 85,
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xff0A2B48),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: 85,
                      child: Image.asset(icon ?? "assets/icon_on_going.png"),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage(
                                background ?? "assets/background_on_going.png"),
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${value ?? 0}",
                            style: System.data.textStyles!.basicLabel.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                isLoading
                    ? SkeletonAnimation(
                        child: Container(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      )
                    : const SizedBox(),
                isError
                    ? Container(
                        color: Colors.grey.withOpacity(0.5),
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            height: 30,
                            width: double.infinity,
                            color: Colors.red,
                            alignment: Alignment.center,
                            child: Text(
                              "Error",
                              style:
                                  System.data.textStyles!.boldTitleLightLabel,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 35,
              color: Colors.transparent,
              child: Text(
                label ?? "On \n Going",
                style: System.data.textStyles!.basicLightLabel.copyWith(
                  // fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget mainMenu() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xffF4F4F4),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          menuItem(
            onTap: () {
              checkAccess(
                method: "mobile_dashboard",
                onGrandted: widget.onTapDashboard,
              );
            },
          ),
          menuItem(
              icon: "assets/icon_menu_riview_task.png",
              label: "Review Task",
              onTap: () {
                checkAccess(
                  method: "mobile_review_task",
                  onGrandted: widget.onTapReviewTask,
                );
              }),
          menuItem(
              icon: "assets/icon_menu_report.png",
              label: "Report",
              onTap: () {
                checkAccess(
                  method: "mobile_report",
                  onGrandted: widget.onTapReport,
                );
              }),
          menuItem(
            icon: "assets/icon_menu_manual_book.png",
            label: "Manual Book",
            onTap: () {
              checkAccess(
                method: "mobile_manual_book",
                onGrandted: widget.onTapManualBook,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget menuItem({
    String? icon,
    String? label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: (MediaQuery.of(context).size.width / 2) - 80,
        width: (MediaQuery.of(context).size.width / 2) - 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3,
            )
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(
                    icon ?? "assets/icon_menu_dashboard.png",
                    width: 70,
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              width: double.infinity,
              color: Colors.transparent,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label ?? "Dashboard",
                  style: System.data.textStyles!.basicLabel.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Container(
      width: MediaQuery.of(context).size.width * 70 / 100,
      color: const Color(0xffF4F4F4),
      child: Column(
        children: [
          Container(
            height: 200,
            color: System.data.color!.primaryColor,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      "assets/logo_jamkrindo_putih.png",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      "assets/logo_ifg_horizontal.png",
                      width: 120,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                drawerMenuItem(
                    label: "E-Audit",
                    onTap: () {
                      widget.onTapUrl("E-Audit", System.data.global.urlEaudit,
                          "Anda mungkin harus menggunakan jaringan lokal atau menggunakan VPN untuk mengakses halaman ini");
                    }),
                drawerMenuItem(
                    label: "Jamkrindo",
                    onTap: () {
                      widget.onTapUrl(
                          "Jamkrindo", "https://www.jamkrindo.co.id/", "");
                    }),
                drawerMenuItem(
                    label: "IFG",
                    onTap: () {
                      widget.onTapUrl(
                        "IFG",
                        "https://ifg.id/id",
                        "",
                      );
                    }),
                drawerMenuItem(
                  label: "Logout",
                  onTap: logout,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget drawerMenuItem({
    String? label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: Text(
          label ?? "Menu",
          style: System.data.textStyles!.boldTitleLabel,
          textAlign: TextAlign.left,
        ),
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
