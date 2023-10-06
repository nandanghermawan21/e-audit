import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';

import '../util/system.dart';

class AuditPaModel {
  String? id;
  String? divisi;
  DateTime? tanggalMulai;
  DateTime? tanggalSelesai;
  String? kegiatan;
  String? status;
  int? menungguReviu;

  AuditPaModel({
    this.id,
    this.divisi,
    this.tanggalMulai,
    this.tanggalSelesai,
    this.kegiatan,
    this.status,
    this.menungguReviu,
  });

  static AuditPaModel fromJson(Map<String, dynamic> json) {
    return AuditPaModel(
      id: json["assign_id"],
      divisi: json["auditee_name"],
      tanggalMulai: DateTime.parse(json["assign_start_date"]),
      tanggalSelesai: DateTime.parse(json["assign_end_date"]),
      kegiatan: json["kegiatan"],
      status: json["assign_status"],
      menungguReviu: json["assign_status_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "divisi": divisi,
      "tanggal_mulai": tanggalMulai,
      "tanggal_selesai": tanggalSelesai,
      "kegiatan": kegiatan,
      "status": status,
      "menunggu_reviu": menungguReviu,
    };
  }

  static Future<List<AuditPaModel>> get({
    required String? token,
    required int? tahun,
    required String? searchKey,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_reviu",
        "tahun": "$tahun",
        "token": "$token",
        "search": "$searchKey",
        "tipe": "PKA",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if (value == false) {
        return dataSample.map((e) => AuditPaModel.fromJson(e)).toList();
      }
      if ((value)["message"] != "" && (value)["message"] != null) {
        throw BasicResponse(message: (value)["message"]);
      }
      return (value as List).map((e) => AuditPaModel.fromJson(e)).toList();
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  //create list dummy
  static List<AuditPaModel> dummys({
    String? status = "PKA",
  }) {
    return [
      AuditPaModel(
        id: "45",
        divisi: "Divisi Akuntansi",
        tanggalMulai: DateTime.parse("2021-09-01 08:00:00"),
        tanggalSelesai: DateTime.parse("2021-09-10 08:00:00"),
        kegiatan:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Akuntansi",
        status: status,
        menungguReviu: 3,
      ),
      AuditPaModel(
        id: "46",
        divisi: "Divisi Umum",
        tanggalMulai: DateTime.parse("2021-09-10 08:00:00"),
        tanggalSelesai: DateTime.parse("2021-09-15 08:00:00"),
        kegiatan:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Umum P3DN Tahap 2",
        status: status,
        menungguReviu: 2,
      ),
    ];
  }

  //handle sementara untuk get error false
  static List<Map<String, String>> dataSample = [
    {
      "assign_id": "7f77c993336269426be068910f3aeda4f0d1f118",
      "auditee_name": "Divisi Bisnis II",
      "assign_start_date": "2022-12-11",
      "assign_end_date": "2023-01-15",
      "assign_status": "0",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "eade6d93fa806bc204c219ca8f6ff7cf49d74a54",
      "auditee_name": "Divisi Operasional TI",
      "assign_start_date": "2022-12-04",
      "assign_end_date": "2022-12-27",
      "assign_status": "0",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "f959b0a546855e78abfc7ceda520191e719050b6",
      "auditee_name": "Divisi Pengembangan TI",
      "assign_start_date": "2022-12-04",
      "assign_end_date": "2022-12-27",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "78916a020d90c0d7de1a8c5a3441fe6c470980ea",
      "auditee_name": "Divisi Umum",
      "assign_start_date": "2022-11-07",
      "assign_end_date": "2022-11-22",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "33b29e86d7cdb221802a2b83f072ac3be859c743",
      "auditee_name": "Sekretaris Perusahaan",
      "assign_start_date": "2022-11-01",
      "assign_end_date": "2022-11-21",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "437b08942944c539e748fa74ce0c782be54c342e",
      "auditee_name": "Divisi Keuangan dan Investasi",
      "assign_start_date": "2022-10-24",
      "assign_end_date": "2022-11-09",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "c4be40746032e1b1da19c4950b443a73999f466a",
      "auditee_name": "Divisi Keuangan dan Investasi",
      "assign_start_date": "2022-10-23",
      "assign_end_date": "2022-11-16",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "fbaef3dd180d58e490275970c8f8343b7e7dc367",
      "auditee_name": "Divisi Jaringan dan Layanan",
      "assign_start_date": "2022-10-18",
      "assign_end_date": "2022-11-03",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "ddc4a38150daa1bc22957c4d8f67369201132a18",
      "auditee_name": "Kantor Cabang DKI Jakarta",
      "assign_start_date": "2022-10-17",
      "assign_end_date": "2022-10-28",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "0de7ab88c00c346b851c681895d9a2836f23f1ae",
      "auditee_name": "Divisi Pengembangan TI",
      "assign_start_date": "2022-10-11",
      "assign_end_date": "2022-11-29",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "1c24eab8ad2b8e91a9e964a512ea54d02298a97c",
      "auditee_name": "Divisi Operasional TI",
      "assign_start_date": "2022-10-11",
      "assign_end_date": "2022-11-29",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "c85c9063d86694d9061c818f139314568cfc6845",
      "auditee_name": "Kantor Cabang Medan",
      "assign_start_date": "2022-10-11",
      "assign_end_date": "2022-10-21",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "5b7aaace10dad759d7c56f8209702d245ffe028a",
      "auditee_name": "Kantor Cabang Manado",
      "assign_start_date": "2022-10-03",
      "assign_end_date": "2022-10-14",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "4a01ccdc828fb97e9c25732aa680d023f2195f3b",
      "auditee_name": "Kantor Cabang Kupang",
      "assign_start_date": "2022-10-02",
      "assign_end_date": "2022-10-13",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "db4ca5f2bf09c1b59ea060312bb9aa078af00d06",
      "auditee_name": "Divisi Akuntansi",
      "assign_start_date": "2022-09-28",
      "assign_end_date": "2022-10-17",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "b6a65dd3bed4503a54a7b11443fb7564e2b42573",
      "auditee_name": "Kantor Wilayah VIII Banjarmasin",
      "assign_start_date": "2022-09-27",
      "assign_end_date": "2022-10-08",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "b0899e4a14084cc440e73899d75546591d82b0de",
      "auditee_name": "Kantor Cabang Khusus Jakarta",
      "assign_start_date": "2022-09-15",
      "assign_end_date": "2022-10-04",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "6df83e544ae04952bc85bde27aa1727fb62e37a3",
      "auditee_name": "Kantor Wilayah V Semarang",
      "assign_start_date": "2022-09-11",
      "assign_end_date": "2022-09-21",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "b70e78cedec8a7fb754610aba521c323a19fc787",
      "auditee_name": "Kantor Cabang Semarang",
      "assign_start_date": "2022-09-11",
      "assign_end_date": "2022-09-21",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "710d108db19555496bea18559325a61c5f70cb54",
      "auditee_name": "Kantor Cabang Bandung",
      "assign_start_date": "2022-09-07",
      "assign_end_date": "2022-09-17",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "b5ac25a42b8439bf7fe10893cb746be79abbfa87",
      "auditee_name": "Kantor Wilayah IV Bandung",
      "assign_start_date": "2022-09-07",
      "assign_end_date": "2022-09-17",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "dbcbbe6c70ddb0915ae312a77e5ad3ce5c46bf90",
      "auditee_name": "Kantor Wilayah I Medan",
      "assign_start_date": "2022-08-26",
      "assign_end_date": "2022-09-04",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "ca3b3f45842214ea296a65f7ffed02322024a81d",
      "auditee_name": "Kantor Cabang Denpasar",
      "assign_start_date": "2022-08-23",
      "assign_end_date": "2022-09-02",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "7e11302b39f7d63181141a3d6305112b8c0acb03",
      "auditee_name": "Kantor Wilayah VII Denpasar",
      "assign_start_date": "2022-08-23",
      "assign_end_date": "2022-09-02",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "c8e4f204cf25ef00084b3e119821949090688c6c",
      "auditee_name": "Kantor Wilayah VI Surabaya",
      "assign_start_date": "2022-08-22",
      "assign_end_date": "2022-09-01",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "c5815e5fef9682ec5a54681a84e194c6911fb1bb",
      "auditee_name": "Kantor Wilayah IX Makassar",
      "assign_start_date": "2022-08-06",
      "assign_end_date": "2022-08-16",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "0deeac63e6b1867783e979e38dbb73183fde1117",
      "auditee_name": "Kantor Cabang Makassar",
      "assign_start_date": "2022-08-04",
      "assign_end_date": "2022-08-16",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "c7b02d5a9984007f0813b1ac1dbb3f0c03f92c72",
      "auditee_name": "Kantor Cabang Surabaya",
      "assign_start_date": "2022-08-02",
      "assign_end_date": "2022-08-12",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "cbd5f8e30e30a52ad8d3acb7126569f6c9554110",
      "auditee_name": "Kantor Cabang Palembang",
      "assign_start_date": "2022-07-26",
      "assign_end_date": "2022-08-05",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "34bf03389852ebc6f02a8837c3f180d4b21213f5",
      "auditee_name": "Kantor Wilayah II Palembang",
      "assign_start_date": "2022-07-26",
      "assign_end_date": "2022-08-05",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "3aa7b1bfd56b9896097afa8585cbcd81f03a5278",
      "auditee_name": "Kantor Cabang Padang",
      "assign_start_date": "2022-07-18",
      "assign_end_date": "2022-07-26",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "aa1a41afd1a428f6caaec9d8406afb498ef4d2c2",
      "auditee_name": "Kantor Cabang Pontianak",
      "assign_start_date": "2022-07-13",
      "assign_end_date": "2022-07-22",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "4a02d459c802f688da6a1600d496b4874b1ed4e5",
      "auditee_name": "Kantor Cabang Jayapura",
      "assign_start_date": "2022-07-05",
      "assign_end_date": "2022-07-14",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "ea001f4ffec46aae6c910166f3328dc256c83f11",
      "auditee_name": "Kantor Wilayah III Jakarta",
      "assign_start_date": "2022-07-03",
      "assign_end_date": "2022-07-21",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "14f535bc5f3e4eba465fbd202e776a8361bd8d3b",
      "auditee_name": "Kantor Cabang Ambon",
      "assign_start_date": "2022-06-29",
      "assign_end_date": "2022-07-08",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "a8153983091abac4fd3fe5787c2b4758336360f0",
      "auditee_name": "Kantor Cabang Pangkal Pinang",
      "assign_start_date": "2022-06-26",
      "assign_end_date": "2022-07-04",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "4a6f584fc8bd398a9c82b646936e50cd417dad7c",
      "auditee_name": "Kantor Cabang Samarinda",
      "assign_start_date": "2022-06-15",
      "assign_end_date": "2022-06-23",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "51582c3a5c8c8c6e3c936eb99d9524584db82457",
      "auditee_name": "Kantor Cabang Serang",
      "assign_start_date": "2022-06-13",
      "assign_end_date": "2022-06-21",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "743b05021e0b697bdcb5a97cc135d63fedecd28c",
      "auditee_name": "Kantor Cabang Solo",
      "assign_start_date": "2022-06-13",
      "assign_end_date": "2022-06-21",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "b0c096c46d12830f061e3f0ba628c98784c947af",
      "auditee_name": "Kantor Cabang Bandar Lampung",
      "assign_start_date": "2022-06-13",
      "assign_end_date": "2022-06-26",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "0c5cbbb2a33aa86fbb2cd14e0a015c9d82b2900d",
      "auditee_name": "Kantor Cabang Kediri",
      "assign_start_date": "2022-05-29",
      "assign_end_date": "2022-06-06",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "02ff10051deff3bd5f0765250de240fef2831493",
      "auditee_name": "Kantor Cabang Purwakarta",
      "assign_start_date": "2022-05-26",
      "assign_end_date": "2022-06-03",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "2552da91685c24bd1f0ff766ceefd88efb5cdd4f",
      "auditee_name": "Kantor Cabang Yogyakarta",
      "assign_start_date": "2022-05-25",
      "assign_end_date": "2022-06-03",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "dda8686ce44879843dc392f70824b490abbf329d",
      "auditee_name": "Kantor Cabang Tarakan",
      "assign_start_date": "2022-05-24",
      "assign_end_date": "2022-05-31",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "7ebe79f2255b87436ea2a6aa9b44ffa8fec26ab5",
      "auditee_name": "Kantor Cabang Palangkaraya",
      "assign_start_date": "2022-05-09",
      "assign_end_date": "2022-05-17",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "2f4c1c5b6f6582b5f961fe9e63ac530f83f2522b",
      "auditee_name": "Kantor Cabang Tangerang",
      "assign_start_date": "2022-05-09",
      "assign_end_date": "2022-05-17",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "f69a0d1c42a6586e3e4429764b6f18da486523cf",
      "auditee_name": "Kantor Cabang Ternate",
      "assign_start_date": "2022-05-08",
      "assign_end_date": "2022-05-19",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "957e6b7f53a8526ee66afbc01d29fb677bd78fc9",
      "auditee_name": "Kantor Cabang Tasikmalaya",
      "assign_start_date": "2022-05-08",
      "assign_end_date": "2022-05-19",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "d13693808d36caad8ccb426f6c89b9cab22aa933",
      "auditee_name": "Kantor Cabang Banyuwangi",
      "assign_start_date": "2022-04-18",
      "assign_end_date": "2022-04-27",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "fd6e35af80648e9f21cb02d3d1493ec0eee4481b",
      "auditee_name": "Kantor Cabang Manokwari",
      "assign_start_date": "2022-04-17",
      "assign_end_date": "2022-04-27",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "225b190e997d0c0ebd702328cc17cffe5d92436e",
      "auditee_name": "Divisi Pengembangan TI",
      "assign_start_date": "2022-04-12",
      "assign_end_date": "2022-04-29",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "a6d44c7616425c99661047b79d2a79205e246d36",
      "auditee_name": "Kantor Cabang Jambi",
      "assign_start_date": "2022-04-12",
      "assign_end_date": "2022-04-24",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "c644456a7b91d85caebcd603d583baaa351b2321",
      "auditee_name": "Divisi Operasional TI",
      "assign_start_date": "2022-04-12",
      "assign_end_date": "2022-04-29",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "6fee74aef40f1014f88589056229cc9788e7e767",
      "auditee_name": "Divisi Klaim dan Subrogasi",
      "assign_start_date": "2022-04-10",
      "assign_end_date": "2022-04-27",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "6b72325365f7ea3c0aa09ecab6afcabb5a684d7a",
      "auditee_name": "Divisi Bisnis II",
      "assign_start_date": "2022-03-24",
      "assign_end_date": "2022-04-10",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "e6a1e15f641838218aba0dd3776cebceedebba9a",
      "auditee_name": "Kantor Cabang Kudus",
      "assign_start_date": "2022-03-22",
      "assign_end_date": "2022-03-30",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "19988507e55811c9907f40c4004516928e580ff8",
      "auditee_name": "Divisi Teknik",
      "assign_start_date": "2022-03-22",
      "assign_end_date": "2022-04-07",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "66db91faad497506501eff725c8031ec35efac41",
      "auditee_name": "Kantor Cabang Pekanbaru",
      "assign_start_date": "2022-03-22",
      "assign_end_date": "2022-03-31",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "d4f615e36a91942ddc28f8ff682e0bc155ccbb89",
      "auditee_name": "Divisi Kepatuhan",
      "assign_start_date": "2022-03-20",
      "assign_end_date": "2022-04-01",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "eb13b7ec85b8dcef976b4a0941ef03dd537f280d",
      "auditee_name": "Kantor Cabang Tanjung Pinang",
      "assign_start_date": "2022-03-07",
      "assign_end_date": "2022-03-15",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "7f10a06a050dba51e504f5323884b82395f44a07",
      "auditee_name": "Kantor Cabang Bengkulu",
      "assign_start_date": "2022-03-07",
      "assign_end_date": "2022-03-15",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "9c9d030e55a196025c707f241eeef7c60607e8c4",
      "auditee_name": "Kantor Cabang Batam",
      "assign_start_date": "2022-03-07",
      "assign_end_date": "2022-03-15",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "89ce12f191dae4c61b88656069ddf95c0208dc09",
      "auditee_name": "Kantor Cabang Mataram",
      "assign_start_date": "2022-03-06",
      "assign_end_date": "2022-03-14",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "1c51d582e0fbcfb65867da0aaa096057532e4723",
      "auditee_name": "Kantor Cabang Cirebon",
      "assign_start_date": "2022-02-25",
      "assign_end_date": "2022-03-10",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "ca74b173ad175c85a1bc484242d27876a7b506af",
      "auditee_name": "Kantor Cabang Gorontalo",
      "assign_start_date": "2022-02-17",
      "assign_end_date": "2022-02-25",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "f5625e1016ed4c23a711b3cfdab2049f7ad83fb5",
      "auditee_name": "Kantor Cabang Banjarmasin",
      "assign_start_date": "2022-02-17",
      "assign_end_date": "2022-02-24",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "0d471bef866069b9d263c29add3316723b453cb1",
      "auditee_name": "Kantor Cabang Purwokerto",
      "assign_start_date": "2022-02-17",
      "assign_end_date": "2022-03-01",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "322fa75f11d9d3e68beeab1e39bea2abdb96e617",
      "auditee_name": "Kantor Cabang Palu",
      "assign_start_date": "2022-02-16",
      "assign_end_date": "2022-02-24",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "7d0f0939c9202b13d48ff14dcfc556fe5496aa99",
      "auditee_name": "Kantor Cabang Mamuju",
      "assign_start_date": "2022-02-06",
      "assign_end_date": "2022-02-16",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "3e52ee4d81432d126a5848b38b9f1cc925d53b86",
      "auditee_name": "Kantor Cabang Balikpapan",
      "assign_start_date": "2022-02-01",
      "assign_end_date": "2022-02-10",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "dd44096301fa0681936ecdf8fcd56ddecd6bd32c",
      "auditee_name": "Kantor Cabang Pare-pare",
      "assign_start_date": "2022-01-30",
      "assign_end_date": "2022-02-10",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "a357e7dd7010fd65d322a7d6307ac4433c55fb91",
      "auditee_name": "Kantor Cabang Balige",
      "assign_start_date": "2022-01-26",
      "assign_end_date": "2022-02-03",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "ffe82622e8fa3a6db0460911a5e69e7adcceed2e",
      "auditee_name": "Kantor Cabang Malang",
      "assign_start_date": "2022-01-26",
      "assign_end_date": "2022-02-04",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "ca201db563cd226e0a6d156e0ccf7ebb6be84996",
      "auditee_name": "Divisi Manajemen Risiko",
      "assign_start_date": "2022-01-13",
      "assign_end_date": "2022-01-28",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "103e88e122288e75ce69745da771775bc5f1e91d",
      "auditee_name": "Divisi Manajemen Risiko",
      "assign_start_date": "2022-01-12",
      "assign_end_date": "2022-01-27",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "e9ad9609747620dccf61b1fce7fb353a83c95ad3",
      "auditee_name": "Divisi Pengembangan TI",
      "assign_start_date": "2022-01-11",
      "assign_end_date": "2022-01-26",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "c3b30c9bd4c273ed37daec013c1e6384aedfb088",
      "auditee_name": "Divisi Operasional TI",
      "assign_start_date": "2022-01-11",
      "assign_end_date": "2022-01-26",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "4675385906c0f1aa9dfa5ed7e1f86e2ee28142bc",
      "auditee_name": "Divisi Bisnis III",
      "assign_start_date": "2022-01-10",
      "assign_end_date": "2022-01-25",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "83b06392f2145cc4dd560ca03254201ccd7f8a3d",
      "auditee_name": "Divisi Bisnis I",
      "assign_start_date": "2022-01-10",
      "assign_end_date": "2022-01-25",
      "assign_status": "2",
      "assign_tahun": "2022"
    },
    {
      "assign_id": "269ae210ec2bc4bcdaec6df7556c29bcb68bf1d6",
      "auditee_name": "Divisi Perencanaan Strategis",
      "assign_start_date": "2022-01-05",
      "assign_end_date": "2022-01-19",
      "assign_status": "2",
      "assign_tahun": "2022"
    }
  ];
}
