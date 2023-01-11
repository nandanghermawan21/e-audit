import 'package:d_chart/d_chart.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_rating_temuan_model.dart';
import 'package:eaudit/model/audit_rating_unit_kerja.dart';
import 'package:eaudit/model/bar_chart_model.dart';
import 'package:eaudit/model/monitoring_external_model.dart';
import 'package:eaudit/model/monitoring_tindak_lanjut_management_leter_model.dart';
import 'package:eaudit/model/monitoring_tl_model.dart';
import 'package:eaudit/model/pie_chart_model.dart';
import 'package:eaudit/model/realisasi_bulanan_model.dart';
import 'package:eaudit/model/realisasi_model.dart';
import 'package:eaudit/model/temuan_per_unit_kerja_model.dart';
import 'package:eaudit/model/year_model.dart';
import 'package:eaudit/util/error_handling_util.dart';
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
              case "realisasiBulanan":
                return loader<RealisasiBulananModel?>(
                  future: RealisasiBulananModel.get(
                    token: System.data.global.token,
                    tahun: selectedYear,
                  ),
                  childBuilder: realisasiBulanan,
                );
              case "auditRatingTemuan":
                return loader<AuditRatingTemuanModel?>(
                  future: AuditRatingTemuanModel.get(
                    token: System.data.global.token,
                    tahun: selectedYear,
                  ),
                  childBuilder: auditRatingTemuan,
                );
              case "auditRatingUnitKerja":
                return loader<AuditRatingUnitKerjaModel?>(
                  future: AuditRatingUnitKerjaModel.get(
                    token: System.data.global.token,
                    tahun: selectedYear,
                  ),
                  childBuilder: auditRatingUnitKerja,
                );
              case "temuanPerUnitKerja":
                return loader<TemuanPerUnitKerjaModel?>(
                  future: TemuanPerUnitKerjaModel.get(
                    token: System.data.global.token,
                    tahun: selectedYear,
                  ),
                  childBuilder: temuanPerUnitKerja,
                );
              case "monitoringTindakLanjut":
                return loader<MonitoringTindakLanjutModel?>(
                  future: MonitoringTindakLanjutModel.get(
                    token: System.data.global.token,
                    tahun: selectedYear,
                  ),
                  childBuilder: monitoringTindakLanjut,
                );
              case "monitoringTindakLanjutManagementLetter":
                return loader<
                    List<MonitoringTindakLanjutManagementLetterModel>?>(
                  future: MonitoringTindakLanjutManagementLetterModel.get(
                    token: System.data.global.token,
                    tahun: selectedYear,
                  ),
                  childBuilder: monitoringTindakLanjutManagementLetter,
                );
              case "monitoringWxternal":
                return loader<Map<String, MonitoringExternalModel>?>(
                  future: MonitoringExternalModel.get(
                    token: System.data.global.token,
                    tahun: selectedYear,
                  ),
                  childBuilder: monitoringWxternal,
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
    return FutureBuilder<T?>(
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
          if (s.hasData) {
            return childBuilder(s.data);
          } else {
            return IntrinsicHeight(
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    childBuilder(s.data),
                    Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          ErrorHandlingUtil.handleApiError(s.error),
                          style: System.data.textStyles!.basicLabelDanger,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
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

  Widget realisasiBulanan(RealisasiBulananModel? data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: horizontalBarChart(data?.toBarChartData()),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Perencanaan dan Persiapan Audit",
                style: System.data.textStyles!.basicLabel.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children:
                      List.generate(data?.toBarChartData().length ?? 0, (i) {
                    return IntrinsicWidth(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              margin: const EdgeInsets.all(3),
                              color: data?.toBarChartData()[i].color,
                            ),
                            Text(
                              data?.toBarChartData()[i].id ?? "",
                              style: System.data.textStyles!.basicLabel,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget auditRatingTemuan(AuditRatingTemuanModel? data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: pieChart(data?.toPieChartData()),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Audit Rating Temuan",
                style: System.data.textStyles!.basicLabel.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      data?.toPieChartData().data?.length ?? 0, (i) {
                    return IntrinsicWidth(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              margin: const EdgeInsets.all(3),
                              color: data?.toPieChartData().data?[i].color,
                            ),
                            Text(
                              data?.toPieChartData().data?[i].domain ?? "",
                              style: System.data.textStyles!.basicLabel,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget auditRatingUnitKerja(AuditRatingUnitKerjaModel? data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: pieChart(data?.toPieChartData()),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Audit Rating Unit Kerja",
                style: System.data.textStyles!.basicLabel.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      data?.toPieChartData().data?.length ?? 0, (i) {
                    return IntrinsicWidth(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              margin: const EdgeInsets.all(3),
                              color: data?.toPieChartData().data?[i].color,
                            ),
                            Text(
                              data?.toPieChartData().data?[i].domain ?? "",
                              style: System.data.textStyles!.basicLabel,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget temuanPerUnitKerja(TemuanPerUnitKerjaModel? data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: horizontalBarChart(data?.toBarChartData(),
                  aspectRatio: 6 / 9),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Temuan Per Unit Kerja",
                style: System.data.textStyles!.basicLabel.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children:
                      List.generate(data?.toBarChartData().length ?? 0, (i) {
                    return IntrinsicWidth(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              margin: const EdgeInsets.all(3),
                              color: data?.toBarChartData()[i].color,
                            ),
                            Text(
                              data?.toBarChartData()[i].id ?? "",
                              style: System.data.textStyles!.basicLabel,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget monitoringTindakLanjut(MonitoringTindakLanjutModel? data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: pieChart(data?.toPieChartData()),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Monitoring Tindak Lanjut",
                style: System.data.textStyles!.basicLabel.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      data?.toPieChartData().data?.length ?? 0, (i) {
                    return IntrinsicWidth(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              margin: const EdgeInsets.all(3),
                              color: data?.toPieChartData().data?[i].color,
                            ),
                            Text(
                              data?.toPieChartData().data?[i].domain ?? "",
                              style: System.data.textStyles!.basicLabel,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget monitoringTindakLanjutManagementLetter(
      List<MonitoringTindakLanjutManagementLetterModel>? data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50, top: 30),
              child: pieChart(
                  MonitoringTindakLanjutManagementLetterModel.toPieChartData(
                      data ?? [])),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Monitoring Tindak Lanjut\nManagement Letter",
                style: System.data.textStyles!.basicLabel.copyWith(
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(data?.length ?? 0, (i) {
                    return IntrinsicWidth(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              margin: const EdgeInsets.all(3),
                              color: data?[i].warna,
                            ),
                            Text(
                              data?[i].name ?? "",
                              style: System.data.textStyles!.basicLabel,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget monitoringWxternal(Map<String, MonitoringExternalModel>? data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: horizontalBarChart(
                MonitoringExternalModel.toBarChartData(data ?? {}),
                labelPosition: BarValuePosition.outside,
                barValue: (dataChart, index) {
                  if (dataChart['measure'] ==
                          data?[dataChart['domain']]?.jumlahTindakLanjut &&
                      dataChart['measure'] > 0) {
                    return '${dataChart['measure']}(${dataChart['percentage']}%)';
                  } else {
                    return '${dataChart['measure']}';
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Monitoring External",
                style: System.data.textStyles!.basicLabel.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      MonitoringExternalModel.toBarChartData(data ?? {}).length,
                      (i) {
                    return IntrinsicWidth(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              margin: const EdgeInsets.all(3),
                              color: MonitoringExternalModel.toBarChartData(
                                      data ?? {})[i]
                                  .color,
                            ),
                            Text(
                              MonitoringExternalModel.toBarChartData(
                                          data ?? {})[i]
                                      .id ??
                                  "",
                              style: System.data.textStyles!.basicLabel,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
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
                "${angle == double.infinity ? 0 : angle}%",
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

  Widget horizontalBarChart(
    List<BarChartModel>? data, {
    double? aspectRatio,
    BarValuePosition? labelPosition,
    Function(Map<String, dynamic>, int?)? barValue,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: aspectRatio ?? 5 / 9,
        child: DChartBar(
          data: data?.map((e) => e.toJson()).toList() ?? [],
          measureMin: 0,
          measureMax: (BarChartModel.maxMeasureFromList(data) + 10),
          minimumPaddingBetweenLabel: 1,
          domainLabelPaddingToAxisLine: 16,
          axisLineTick: 2,
          axisLinePointTick: 2,
          axisLinePointWidth: 10,
          axisLineColor: Colors.black,
          measureLabelPaddingToAxisLine: 12,
          measureLabelColor: Colors.black,
          barColor: (barData, index, id) {
            return data?.where((e) => e.id == id).first.color ?? Colors.green;
          },
          barValue: (barData, index) {
            if (barValue != null) {
              return barValue(barData, index);
            } else {
              return '${barData['measure']}';
            }
          },
          showBarValue: true,
          barValuePosition: labelPosition ?? BarValuePosition.inside,
          verticalDirection: false,
          showMeasureLine: true,
          showDomainLine: true,
        ),
      ),
    );
  }

  Widget pieChart(PieChartModel? data) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: DChartPie(
          data: data?.data?.isEmpty == null ||
                  (data?.total ?? 0) == 0 ||
                  data?.data?.map((e) => e.toJson()).toList() == null
              ? [
                  {'domain': '', 'measure': 100},
                ]
              : data?.data?.map((e) => e.toJson()).toList() ?? [],
          fillColor: (pieData, index) {
            if (data?.data?.isEmpty == null ||
                (data?.total ?? 0) == 0 ||
                data?.data?.map((e) => e.toJson()).toList() == null) {
              return Colors.grey.shade400;
            } else {
              return data?.data
                  ?.where((e) => e.domain == pieData["domain"])
                  .first
                  .color;
            }
          },
          pieLabel: (pieData, index) {
            return (data?.total ?? 0) == 0
                ? ""
                : "${(pieData['measure'] as double).round()}%\n${pieData['total']}";
          },
          labelPosition: PieLabelPosition.outside,
          labelColor: Colors.black,
          labelFontSize: 14,
          labelLineColor: Colors.grey,
          showLabelLine: true,
        ),
      ),
    );
  }
}
