import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/realisasi_model.dart';
import 'package:eaudit/model/year_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: System.data.color!.primaryColor,
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: System.data.textStyles!.boldTitleLightLabel,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            color: Colors.transparent,
            child: YearModel.yearSelector(
              selectedYear: selectedYear,
              onChange: (val) {
                selectedYear = val;
                listController.refresh();
              },
            ),
          )
        ],
      ),
      body: Container(
        color: const Color(0xffF4F4F4),
        child: ListDataComponent<String>(
          controller: listController,
          dataSource: (skip, search) {
            return getListDashboard();
          },
          enableDrag: false,
          enableGetMore: false,
          itemBuilder: (data, indext) {
            switch (data) {
              case "realisasi":
                return loader<RealisasiModel?>(
                  future: RealisasiModel.get(
                    token: System.data.global.token,
                    tahun: selectedYear,
                  ),
                  childBuilder: programAuditTahunan,
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget loader<T>({
    required Widget Function(T?) childBuilder,
    Future<T?>? future,
  }) {
    return FutureBuilder(
      future: future,
      builder: (c, s) {
        if (s.connectionState != ConnectionState.done) {
          return IntrinsicHeight(
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  childBuilder(s.data),
                  SkeletonAnimation(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: double.infinity,
                      color: Colors.grey.shade400.withOpacity(0.3),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return childBuilder(s.data);
        }
      },
    );
  }

  Widget programAuditTahunan(RealisasiModel? data) {
    return Container(
      height: 260,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: radialGauge(
              angle: data?.percentage ?? 0,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IntrinsicHeight(
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Text(
                              "Rencana Audit",
                              style:
                                  System.data.textStyles!.basicLabel.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${data?.rencana ?? "-"}",
                              style:
                                  System.data.textStyles!.basicLabel.copyWith(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Text(
                              "Realisasi Audit",
                              style:
                                  System.data.textStyles!.basicLabel.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${data?.realisasi ?? "-"}",
                              style:
                                  System.data.textStyles!.basicLabel.copyWith(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget radialGauge({
    double? angle = 90,
  }) {
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          child: SfRadialGauge(
            title: const GaugeTitle(
              text: 'Program Audit Tahunan',
              textStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
              ),
              alignment: GaugeAlignment.near,
              borderWidth: 5,
            ),
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 25,
                      color: Colors.red,
                      startWidth: 10,
                      endWidth: 10),
                  GaugeRange(
                      startValue: 25,
                      endValue: 50,
                      color: Colors.orange,
                      startWidth: 10,
                      endWidth: 10),
                  GaugeRange(
                      startValue: 50,
                      endValue: 75,
                      color: Colors.yellow,
                      startWidth: 10,
                      endWidth: 10),
                  GaugeRange(
                      startValue: 75,
                      endValue: 150,
                      color: Colors.green,
                      startWidth: 10,
                      endWidth: 10)
                ],
                pointers: const <GaugePointer>[NeedlePointer(value: 90)],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: const SizedBox(),
                    angle: angle,
                    positionFactor: 0.5,
                  ),
                ],
                showLastLabel: true,
              )
            ],
          ),
        ),
        Container(
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: (MediaQuery.of(context).size.width / 3) - 50,
            color: Colors.transparent,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "$angle%",
                style: System.data.textStyles!.boldTitleLabel.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
