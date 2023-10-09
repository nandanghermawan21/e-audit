import 'dart:convert';

import 'package:eaudit/model/audit_tl_model.dart';
import 'package:eaudit/util/basic_response.dart';

import '../util/network.dart';
import '../util/system.dart';

class AuditTLReviuModel {
  String? id;
  String? obyekAudit;
  String? nomorLha;
  List<AuditTLModel?>? listAuditTL;

  AuditTLReviuModel({
    this.id,
    this.obyekAudit,
    this.nomorLha,
    this.listAuditTL,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "obyek_audit": obyekAudit,
      "nomor_lha": nomorLha,
      "listAuditTL": listAuditTL?.map((e) => e?.toJson()).toList(),
    };
  }

  static AuditTLReviuModel fromJson(Map<String, dynamic> json) {
    return AuditTLReviuModel(
      id: json["assign_id"],
      obyekAudit: json["auditee_name"],
      nomorLha: json["nomor_lha"],
      listAuditTL: json["listAuditTL"] != null
          ? List<AuditTLModel>.from(
              json["listAuditTL"].map((x) => AuditTLModel.fromJson(x)),
            )
          : null,
    );
  }

  static Future<List<AuditTLReviuModel>> get({
    required String? token,
    required int? tahun,
    required String? searchKey,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_tl",
        "tahun": "$tahun",
        "token": "$token",
        "search": "$searchKey",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if (value == false) {
        throw BasicResponse(message: "Data gagal ditemukan");
      }
      try {
        if ((value)["message"] != "" && (value)["message"] != null) {
          throw BasicResponse(message: (value)["message"]);
        }
      } catch (e) {
        //
      }
      return (value as List).map((e) => AuditTLReviuModel.fromJson(e)).toList();
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static List<Map<String, String>> dataSample = [
    {
      "assign_id": "5b895ac7294582f97a38b851c43dae2b4821df63",
      "auditee_name": "Kantor Cabang Bandung",
      "nomor_lha": "test/123/LHA"
    },
    {
      "assign_id": "99f1c94d53a729c234eb9c8d14397a15c6d25fc2",
      "auditee_name": "Kantor Cabang Semarang",
      "nomor_lha": "16/LHA/III/2023"
    },
    {
      "assign_id": "a364a171eb972b2fbbd023e60d9de84ce34d2a28",
      "auditee_name": "Kantor Cabang Pekalongan",
      "nomor_lha": "12/LHA/II/2023"
    },
    {
      "assign_id": "1bd4ed4887f6cc59628289320a686283a44141d2",
      "auditee_name": "Kantor Cabang Jayapura",
      "nomor_lha": "13/LHA/II/2023"
    },
    {
      "assign_id": "ef57f325515ed623a93d1e2514f4166e44cd063b",
      "auditee_name": "Kantor Cabang Serang",
      "nomor_lha": "14/LHA/II/2023"
    },
    {
      "assign_id": "e6d5d38f9472c1aacf888020f89dbc3d59eb48de",
      "auditee_name": "Kantor Cabang Kediri",
      "nomor_lha": "11/LHA/II/2023"
    },
    {
      "assign_id": "4b357e617eee91c917d692be5e9b5f0c1d51797a",
      "auditee_name": "Kantor Cabang Jambi",
      "nomor_lha": "09/LHA/II/2023"
    },
    {
      "assign_id": "80194ca1ed65539167f260d3d0e55c52387fa978",
      "auditee_name": "Kantor Cabang Cirebon",
      "nomor_lha": "10/LHA/II/2023"
    },
    {
      "assign_id": "a88b657ca76afe06d7031f2793868c29876ca7aa",
      "auditee_name": "Kantor Cabang Pekanbaru",
      "nomor_lha": "07/LHA/II/2023"
    },
    {
      "assign_id": "e4679c67d948f68fc5c321289d7f6e77a82f1900",
      "auditee_name": "Kantor Cabang Palopo",
      "nomor_lha": "08/LHA/II/2023"
    },
    {
      "assign_id": "0cd979cde2ea906e58c872bb5f78adeb36d38522",
      "auditee_name": "Kantor Cabang Madiun",
      "nomor_lha": "03/LHA/I/2023"
    },
    {
      "assign_id": "21fb19a6d2d29e53727b22c143f452f92b605417",
      "auditee_name": "Kantor Cabang Kendari",
      "nomor_lha": "04/LHA/I/2023"
    },
    {
      "assign_id": "db636f82021ce8b79ac5b5c9a3fc20bc4d8ae61d",
      "auditee_name": "Kantor Cabang Bandar Lampung",
      "nomor_lha": "1/LHA/I/2023"
    },
    {
      "assign_id": "44ffa724509799482e7a5455e9e435d52e342729",
      "auditee_name": "Kantor Cabang Sumbawa Besar",
      "nomor_lha": "02/LHA/I/2023"
    },
    {
      "assign_id": "eade6d93fa806bc204c219ca8f6ff7cf49d74a54",
      "auditee_name": "Divisi Operasional TI",
      "nomor_lha": "79/LHA/XII/2022"
    },
    {
      "assign_id": "f959b0a546855e78abfc7ceda520191e719050b6",
      "auditee_name": "Divisi Pengembangan TI",
      "nomor_lha": "78/LHA/XII/2022"
    },
    {
      "assign_id": "78916a020d90c0d7de1a8c5a3441fe6c470980ea",
      "auditee_name": "Divisi Umum",
      "nomor_lha": "74/LHA/XI/2022"
    },
    {
      "assign_id": "33b29e86d7cdb221802a2b83f072ac3be859c743",
      "auditee_name": "Sekretaris Perusahaan",
      "nomor_lha": "73/LHA/XI2022"
    },
    {
      "assign_id": "437b08942944c539e748fa74ce0c782be54c342e",
      "auditee_name": "Divisi Keuangan dan Investasi",
      "nomor_lha": "71/LHA/XI/2022"
    },
    {
      "assign_id": "c4be40746032e1b1da19c4950b443a73999f466a",
      "auditee_name": "Divisi Keuangan dan Investasi",
      "nomor_lha": "72/LHA/XI/2022"
    },
    {
      "assign_id": "fbaef3dd180d58e490275970c8f8343b7e7dc367",
      "auditee_name": "Divisi Jaringan dan Layanan",
      "nomor_lha": "70/LHA/XI/2022"
    },
    {
      "assign_id": "ddc4a38150daa1bc22957c4d8f67369201132a18",
      "auditee_name": "Kantor Cabang DKI Jakarta",
      "nomor_lha": "68/LHA/XI/2022"
    },
    {
      "assign_id": "0de7ab88c00c346b851c681895d9a2836f23f1ae",
      "auditee_name": "Divisi Pengembangan TI",
      "nomor_lha": "75/LHA/XII/2022"
    },
    {
      "assign_id": "1c24eab8ad2b8e91a9e964a512ea54d02298a97c",
      "auditee_name": "Divisi Operasional TI",
      "nomor_lha": "76/LHA/XII/2022"
    },
    {
      "assign_id": "c85c9063d86694d9061c818f139314568cfc6845",
      "auditee_name": "Kantor Cabang Medan",
      "nomor_lha": "67/LHA/X/2022"
    },
    {
      "assign_id": "5b7aaace10dad759d7c56f8209702d245ffe028a",
      "auditee_name": "Kantor Cabang Manado",
      "nomor_lha": "66/LHA/X/2022"
    },
    {
      "assign_id": "4a01ccdc828fb97e9c25732aa680d023f2195f3b",
      "auditee_name": "Kantor Cabang Kupang",
      "nomor_lha": "65/LHA/X/2022"
    },
    {
      "assign_id": "db4ca5f2bf09c1b59ea060312bb9aa078af00d06",
      "auditee_name": "Divisi Akuntansi",
      "nomor_lha": "69/LHA/XI2022"
    },
    {
      "assign_id": "b6a65dd3bed4503a54a7b11443fb7564e2b42573",
      "auditee_name": "Kantor Wilayah VIII Banjarmasin",
      "nomor_lha": "64/LHA/X/2022"
    },
    {
      "assign_id": "b0899e4a14084cc440e73899d75546591d82b0de",
      "auditee_name": "Kantor Cabang Khusus Jakarta",
      "nomor_lha": "63/LHA/X/2022"
    },
    {
      "assign_id": "6df83e544ae04952bc85bde27aa1727fb62e37a3",
      "auditee_name": "Kantor Wilayah V Semarang",
      "nomor_lha": "62/LHA/IX/2022"
    },
    {
      "assign_id": "b70e78cedec8a7fb754610aba521c323a19fc787",
      "auditee_name": "Kantor Cabang Semarang",
      "nomor_lha": "61/LHA/IX/2022"
    },
    {
      "assign_id": "b5ac25a42b8439bf7fe10893cb746be79abbfa87",
      "auditee_name": "Kantor Wilayah IV Bandung",
      "nomor_lha": "59/LHA/IX/2022"
    },
    {
      "assign_id": "710d108db19555496bea18559325a61c5f70cb54",
      "auditee_name": "Kantor Cabang Bandung",
      "nomor_lha": "60/LHA/IX/2022"
    },
    {
      "assign_id": "dbcbbe6c70ddb0915ae312a77e5ad3ce5c46bf90",
      "auditee_name": "Kantor Wilayah I Medan",
      "nomor_lha": "58/LHA/IX/2022"
    },
    {
      "assign_id": "ca3b3f45842214ea296a65f7ffed02322024a81d",
      "auditee_name": "Kantor Cabang Denpasar",
      "nomor_lha": "56/LHA/IX/2022"
    },
    {
      "assign_id": "7e11302b39f7d63181141a3d6305112b8c0acb03",
      "auditee_name": "Kantor Wilayah VII Denpasar",
      "nomor_lha": "57/LHA/IX/2022"
    },
    {
      "assign_id": "c8e4f204cf25ef00084b3e119821949090688c6c",
      "auditee_name": "Kantor Wilayah VI Surabaya",
      "nomor_lha": "55/LHA/IX/2022"
    },
    {
      "assign_id": "c5815e5fef9682ec5a54681a84e194c6911fb1bb",
      "auditee_name": "Kantor Wilayah IX Makassar",
      "nomor_lha": "54/LHA/VIII/2022"
    },
    {
      "assign_id": "0deeac63e6b1867783e979e38dbb73183fde1117",
      "auditee_name": "Kantor Cabang Makassar",
      "nomor_lha": "53/LHA/VIII/2022"
    },
    {
      "assign_id": "c7b02d5a9984007f0813b1ac1dbb3f0c03f92c72",
      "auditee_name": "Kantor Cabang Surabaya",
      "nomor_lha": "52/LHA/VIII/2022"
    },
    {
      "assign_id": "cbd5f8e30e30a52ad8d3acb7126569f6c9554110",
      "auditee_name": "Kantor Cabang Palembang",
      "nomor_lha": "51/LHA/VIII/2022"
    },
    {
      "assign_id": "34bf03389852ebc6f02a8837c3f180d4b21213f5",
      "auditee_name": "Kantor Wilayah II Palembang",
      "nomor_lha": "50/LHA/VIII/2022"
    },
    {
      "assign_id": "3aa7b1bfd56b9896097afa8585cbcd81f03a5278",
      "auditee_name": "Kantor Cabang Padang",
      "nomor_lha": "49/LHA/VII/2022"
    },
    {
      "assign_id": "aa1a41afd1a428f6caaec9d8406afb498ef4d2c2",
      "auditee_name": "Kantor Cabang Pontianak",
      "nomor_lha": "47/LHA/VII/2022"
    },
    {
      "assign_id": "4a02d459c802f688da6a1600d496b4874b1ed4e5",
      "auditee_name": "Kantor Cabang Jayapura",
      "nomor_lha": "46/LHA/VII/2022"
    },
    {
      "assign_id": "ea001f4ffec46aae6c910166f3328dc256c83f11",
      "auditee_name": "Kantor Wilayah III Jakarta",
      "nomor_lha": "48/LHA/VII/2022"
    },
    {
      "assign_id": "14f535bc5f3e4eba465fbd202e776a8361bd8d3b",
      "auditee_name": "Kantor Cabang Ambon",
      "nomor_lha": "45/LHA/VII/2022"
    },
    {
      "assign_id": "a8153983091abac4fd3fe5787c2b4758336360f0",
      "auditee_name": "Kantor Cabang Pangkal Pinang",
      "nomor_lha": "44/LHA/VII/2022"
    },
    {
      "assign_id": "4a6f584fc8bd398a9c82b646936e50cd417dad7c",
      "auditee_name": "Kantor Cabang Samarinda",
      "nomor_lha": "42/LHA/VI/2022"
    },
    {
      "assign_id": "51582c3a5c8c8c6e3c936eb99d9524584db82457",
      "auditee_name": "Kantor Cabang Serang",
      "nomor_lha": "40/LHA/VI/2022"
    },
    {
      "assign_id": "743b05021e0b697bdcb5a97cc135d63fedecd28c",
      "auditee_name": "Kantor Cabang Solo",
      "nomor_lha": "41/LHA/VI/2022"
    },
    {
      "assign_id": "b0c096c46d12830f061e3f0ba628c98784c947af",
      "auditee_name": "Kantor Cabang Bandar Lampung",
      "nomor_lha": "43/LHA/VI/2022"
    },
    {
      "assign_id": "0c5cbbb2a33aa86fbb2cd14e0a015c9d82b2900d",
      "auditee_name": "Kantor Cabang Kediri",
      "nomor_lha": "39/LHA/VI/2022"
    },
    {
      "assign_id": "02ff10051deff3bd5f0765250de240fef2831493",
      "auditee_name": "Kantor Cabang Purwakarta",
      "nomor_lha": "38/LHA/VI/2022"
    },
    {
      "assign_id": "2552da91685c24bd1f0ff766ceefd88efb5cdd4f",
      "auditee_name": "Kantor Cabang Yogyakarta",
      "nomor_lha": "37/LHA/VI/2022"
    },
    {
      "assign_id": "dda8686ce44879843dc392f70824b490abbf329d",
      "auditee_name": "Kantor Cabang Tarakan",
      "nomor_lha": "36/LHA/VI/2022"
    },
    {
      "assign_id": "7ebe79f2255b87436ea2a6aa9b44ffa8fec26ab5",
      "auditee_name": "Kantor Cabang Palangkaraya",
      "nomor_lha": "32/LHA/V/2022"
    },
    {
      "assign_id": "2f4c1c5b6f6582b5f961fe9e63ac530f83f2522b",
      "auditee_name": "Kantor Cabang Tangerang",
      "nomor_lha": "33/LHA/V/2022"
    },
    {
      "assign_id": "f69a0d1c42a6586e3e4429764b6f18da486523cf",
      "auditee_name": "Kantor Cabang Ternate",
      "nomor_lha": "34/LHA/V/2022"
    },
    {
      "assign_id": "957e6b7f53a8526ee66afbc01d29fb677bd78fc9",
      "auditee_name": "Kantor Cabang Tasikmalaya",
      "nomor_lha": "35/LHA/V/2022"
    },
    {
      "assign_id": "d13693808d36caad8ccb426f6c89b9cab22aa933",
      "auditee_name": "Kantor Cabang Banyuwangi",
      "nomor_lha": "27/LHA/V/2022"
    },
    {
      "assign_id": "fd6e35af80648e9f21cb02d3d1493ec0eee4481b",
      "auditee_name": "Kantor Cabang Manokwari",
      "nomor_lha": "28/LHA/V/2022"
    },
    {
      "assign_id": "a6d44c7616425c99661047b79d2a79205e246d36",
      "auditee_name": "Kantor Cabang Jambi",
      "nomor_lha": "26/LHA/V/2022"
    },
    {
      "assign_id": "225b190e997d0c0ebd702328cc17cffe5d92436e",
      "auditee_name": "Divisi Pengembangan TI",
      "nomor_lha": "30/LHA/V/2022"
    },
    {
      "assign_id": "c644456a7b91d85caebcd603d583baaa351b2321",
      "auditee_name": "Divisi Operasional TI",
      "nomor_lha": "29/LHA/V/2022"
    },
    {
      "assign_id": "6fee74aef40f1014f88589056229cc9788e7e767",
      "auditee_name": "Divisi Klaim dan Subrogasi",
      "nomor_lha": "31/LHA/V/2022"
    },
    {
      "assign_id": "6b72325365f7ea3c0aa09ecab6afcabb5a684d7a",
      "auditee_name": "Divisi Bisnis II",
      "nomor_lha": "25/LHA/IV/2022"
    },
    {
      "assign_id": "66db91faad497506501eff725c8031ec35efac41",
      "auditee_name": "Kantor Cabang Pekanbaru",
      "nomor_lha": "22/LHA/IV/2022"
    },
    {
      "assign_id": "e6a1e15f641838218aba0dd3776cebceedebba9a",
      "auditee_name": "Kantor Cabang Kudus",
      "nomor_lha": "21/LHA/IV/2022"
    },
    {
      "assign_id": "19988507e55811c9907f40c4004516928e580ff8",
      "auditee_name": "Divisi Teknik",
      "nomor_lha": "24/LHA/IV/2022"
    },
    {
      "assign_id": "d4f615e36a91942ddc28f8ff682e0bc155ccbb89",
      "auditee_name": "Divisi Kepatuhan",
      "nomor_lha": "23/LHA/IV/2022"
    },
    {
      "assign_id": "eb13b7ec85b8dcef976b4a0941ef03dd537f280d",
      "auditee_name": "Kantor Cabang Tanjung Pinang",
      "nomor_lha": "18/LHA/III2022"
    },
    {
      "assign_id": "7f10a06a050dba51e504f5323884b82395f44a07",
      "auditee_name": "Kantor Cabang Bengkulu",
      "nomor_lha": "19/LHA/III/2022"
    },
    {
      "assign_id": "9c9d030e55a196025c707f241eeef7c60607e8c4",
      "auditee_name": "Kantor Cabang Batam",
      "nomor_lha": "20/LHA/III/2022"
    },
    {
      "assign_id": "89ce12f191dae4c61b88656069ddf95c0208dc09",
      "auditee_name": "Kantor Cabang Mataram",
      "nomor_lha": "17/LHA/III/2022"
    },
    {
      "assign_id": "1c51d582e0fbcfb65867da0aaa096057532e4723",
      "auditee_name": "Kantor Cabang Cirebon",
      "nomor_lha": "16/LHA/III/2022"
    },
    {
      "assign_id": "ca74b173ad175c85a1bc484242d27876a7b506af",
      "auditee_name": "Kantor Cabang Gorontalo",
      "nomor_lha": "13/LHA/III/2022"
    },
    {
      "assign_id": "f5625e1016ed4c23a711b3cfdab2049f7ad83fb5",
      "auditee_name": "Kantor Cabang Banjarmasin",
      "nomor_lha": "14/LHA/II/2022"
    },
    {
      "assign_id": "0d471bef866069b9d263c29add3316723b453cb1",
      "auditee_name": "Kantor Cabang Purwokerto",
      "nomor_lha": "15/LHA/III/2022"
    },
    {
      "assign_id": "322fa75f11d9d3e68beeab1e39bea2abdb96e617",
      "auditee_name": "Kantor Cabang Palu",
      "nomor_lha": "12/LHA/III/2022"
    },
    {
      "assign_id": "7d0f0939c9202b13d48ff14dcfc556fe5496aa99",
      "auditee_name": "Kantor Cabang Mamuju",
      "nomor_lha": "11/LHA/II/2022"
    },
    {
      "assign_id": "3e52ee4d81432d126a5848b38b9f1cc925d53b86",
      "auditee_name": "Kantor Cabang Balikpapan",
      "nomor_lha": "8/LHA/II/2022"
    },
    {
      "assign_id": "dd44096301fa0681936ecdf8fcd56ddecd6bd32c",
      "auditee_name": "Kantor Cabang Pare-pare",
      "nomor_lha": "9/LHA/II/2022"
    },
    {
      "assign_id": "ffe82622e8fa3a6db0460911a5e69e7adcceed2e",
      "auditee_name": "Kantor Cabang Malang",
      "nomor_lha": "1O/LHA/II/2022"
    },
    {
      "assign_id": "a357e7dd7010fd65d322a7d6307ac4433c55fb91",
      "auditee_name": "Kantor Cabang Balige",
      "nomor_lha": "7/LHA/II/2022"
    },
    {
      "assign_id": "ca201db563cd226e0a6d156e0ccf7ebb6be84996",
      "auditee_name": "Divisi Manajemen Risiko",
      "nomor_lha": "1.a/LHA/II/2022"
    },
    {
      "assign_id": "103e88e122288e75ce69745da771775bc5f1e91d",
      "auditee_name": "Divisi Manajemen Risiko",
      "nomor_lha": "1/LHA/II/2022"
    },
    {
      "assign_id": "e9ad9609747620dccf61b1fce7fb353a83c95ad3",
      "auditee_name": "Divisi Pengembangan TI",
      "nomor_lha": "6/LHA/II/2022"
    },
    {
      "assign_id": "c3b30c9bd4c273ed37daec013c1e6384aedfb088",
      "auditee_name": "Divisi Operasional TI",
      "nomor_lha": "5/LHA/II/2022"
    },
    {
      "assign_id": "4675385906c0f1aa9dfa5ed7e1f86e2ee28142bc",
      "auditee_name": "Divisi Bisnis III",
      "nomor_lha": "4/LHA/II/2022"
    },
    {
      "assign_id": "83b06392f2145cc4dd560ca03254201ccd7f8a3d",
      "auditee_name": "Divisi Bisnis I",
      "nomor_lha": "03/LHA/II/2022"
    },
    {
      "assign_id": "269ae210ec2bc4bcdaec6df7556c29bcb68bf1d6",
      "auditee_name": "Divisi Perencanaan Strategis",
      "nomor_lha": "2/LHA/II/2022"
    },
    {
      "assign_id": "ce3d5482ca90728638d6f66cc00d9d8374b981c9",
      "auditee_name": "Divisi Keuangan dan Investasi",
      "nomor_lha": "64/LHA/XII/2021"
    },
    {
      "assign_id": "2b87656aea341dc26b229fc301c26fa52358939b",
      "auditee_name": "Kantor Cabang Khusus Jakarta",
      "nomor_lha": "63/LHA/XII/2021"
    },
    {
      "assign_id": "793507008f965b5c03d1a830dc486f2ef9bc7147",
      "auditee_name": "Kantor Wilayah V Semarang",
      "nomor_lha": "61/LHA/XII/2021"
    },
    {
      "assign_id": "26b6bd9ff1707b42f975bf583eee644ce3b9855a",
      "auditee_name": "Divisi Manajemen Sumber Daya Manusia (MSDM)",
      "nomor_lha": "62/LHA/XII/2021"
    },
    {
      "assign_id": "85159ec57a07dd73084460661612ad827c463a13",
      "auditee_name": "Kantor Wilayah III Jakarta",
      "nomor_lha": "60/LHA/XII/2021"
    },
    {
      "assign_id": "3ad66529617fc13f06550323d88cb5a6ae019f6a",
      "auditee_name": "Divisi Umum",
      "nomor_lha": "59/LHA/XII/2021"
    },
    {
      "assign_id": "1f6e246ebde5f6d22c39e846a074fd45e8fac2b8",
      "auditee_name": "Kantor Cabang DKI Jakarta",
      "nomor_lha": "57/LHA/XI/2021"
    },
    {
      "assign_id": "2700ef9f602b900327a59d61a755316ededfc087",
      "auditee_name": "Kantor Wilayah IX Makassar",
      "nomor_lha": "58/LHA/XI/2021"
    },
    {
      "assign_id": "abf2a150d21123be76dcead2edef5336a0f24ff8",
      "auditee_name": "Kantor Cabang Medan",
      "nomor_lha": "56/LHA/XI/2021"
    },
    {
      "assign_id": "f21e2b76b98f38c3a0a36d31ee24b9efb8fa9081",
      "auditee_name": "Kantor Cabang Denpasar",
      "nomor_lha": "55/LHA/X/2021"
    },
    {
      "assign_id": "83e620b85572663d94c5e8dd470afeb4b7e81f2c",
      "auditee_name": "Kantor Cabang Bandung",
      "nomor_lha": "52/LHA/X/2021"
    },
    {
      "assign_id": "2833e068e9e3e141303957d2bd56e4423847f928",
      "auditee_name": "Kantor Cabang Semarang",
      "nomor_lha": "53/LHA/X/2021"
    },
    {
      "assign_id": "1d1e4065fe746b1e611e6d9150891ee4858e5ef0",
      "auditee_name": "Kantor Wilayah VIII Banjarmasin",
      "nomor_lha": "54/LHA/X/2021"
    },
    {
      "assign_id": "c025b367cb57f9800c5c14c865ca1e3d386b5fd2",
      "auditee_name": "Kantor Cabang Manado",
      "nomor_lha": "51/LHA/X/2021"
    },
    {
      "assign_id": "ca23d7ee1052e65b30d365cc1bdab4fdf956f2ee",
      "auditee_name": "Kantor Cabang Makassar",
      "nomor_lha": "48/LHA/IX/2021"
    },
    {
      "assign_id": "97d221aafe8cb6c8600ef802609027b74e1960be",
      "auditee_name": "Kantor Wilayah VII Denpasar",
      "nomor_lha": "50/LHA/IX/2021"
    },
    {
      "assign_id": "00c305ae8c6719c166f40c35952846f99ec6e60b",
      "auditee_name": "Kantor Cabang Kupang",
      "nomor_lha": "49/IX/LHA/2021"
    },
    {
      "assign_id": "0daf1144c3b340719f2faa72b1f92ce4be4dd9ba",
      "auditee_name": "Kantor Wilayah II Palembang",
      "nomor_lha": "47/LHA/IX/2021"
    },
    {
      "assign_id": "0b6a0ac615cda5c1a6860a04bae83a67a6a1a760",
      "auditee_name": "Kantor Cabang Jayapura",
      "nomor_lha": "46/LHA/IX/2021"
    },
    {
      "assign_id": "55786ae60a078baf3703e5c658456bbae9dd870d",
      "auditee_name": "Kantor Wilayah IV Bandung",
      "nomor_lha": "45/LHA/IX/2021"
    },
    {
      "assign_id": "04125f0831d5d69778232a5954bdeeabceff9a10",
      "auditee_name": "Kantor Cabang Palembang",
      "nomor_lha": "44/LHA/IX/2021"
    },
    {
      "assign_id": "1cc598152b1362a2ac65edd4a416ec3f7bc8b185",
      "auditee_name": "Kantor Cabang Palu",
      "nomor_lha": "42/LHA/VIII/2021"
    },
    {
      "assign_id": "353f99a0ab61ada6ceee7e9f1482d366492ca186",
      "auditee_name": "Kantor Cabang Surabaya",
      "nomor_lha": "43/LHA/VIII/2021"
    },
    {
      "assign_id": "8880543f51f848fa2d66773f173ea25eba90ec4c",
      "auditee_name": "Kantor Cabang Samarinda",
      "nomor_lha": "41/LHA/VIII/2021"
    },
    {
      "assign_id": "10b355a69f03e74173ffa174e0f205ae97e4a27f",
      "auditee_name": "Kantor Cabang Bandar Lampung",
      "nomor_lha": "40/LHA/VIII/2021"
    },
    {
      "assign_id": "152244fb0d5c8d9438c335e0fe5053f02109d49e",
      "auditee_name": "Kantor Wilayah VI Surabaya",
      "nomor_lha": "39/LHA/VII/2021"
    },
    {
      "assign_id": "26a9e420146bc9ccc68844e476d253900cb515f6",
      "auditee_name": "Kantor Wilayah I Medan",
      "nomor_lha": "38/LHA/VII/2021"
    },
    {
      "assign_id": "bd4fe5ef829347f8f9877be1801ea0d7fd7326b1",
      "auditee_name": "Kantor Cabang Padang",
      "nomor_lha": "37/LHA/VII/2021"
    },
    {
      "assign_id": "b49372ab69270597d3c352ecff63b56a7668436b",
      "auditee_name": "Kantor Cabang Yogyakarta",
      "nomor_lha": "36/LHA/VII/2021"
    },
    {
      "assign_id": "fe7ff2f9d057586e3e9819ca356fbad126c6c0ba",
      "auditee_name": "Kantor Cabang Madiun",
      "nomor_lha": "35/LHA/VII/2021"
    },
    {
      "assign_id": "e42673ac2c75d12c65f5da179a1d850de70ef9ec",
      "auditee_name": "Kantor Cabang Pontianak",
      "nomor_lha": "34/LHA/VII/2021"
    },
    {
      "assign_id": "1d51f595dc57edc612194a47548eccc7c0fcef1a",
      "auditee_name": "Kantor Cabang Ternate",
      "nomor_lha": "32/LHA/VI/2021"
    },
    {
      "assign_id": "db060bdc2de874ee2a3786455f5fae4d35c97f82",
      "auditee_name": "Kantor Cabang Manokwari",
      "nomor_lha": "33/LHA/VI/2021"
    },
    {
      "assign_id": "2dd9673174f0e61ae06e2ee3bf15d7d5e50d5b0d",
      "auditee_name": "Kantor Cabang Pangkal Pinang",
      "nomor_lha": "30/LHA/VI/2021"
    },
    {
      "assign_id": "d286a56cd562bebdf302e0730e77c0a1c9079d54",
      "auditee_name": "Kantor Cabang Aceh",
      "nomor_lha": "28/LHA/VI/2021"
    },
    {
      "assign_id": "d0b4f03d45d0ef97a7d7c701a58f7d4cd8bbfbe4",
      "auditee_name": "Kantor Cabang Serang",
      "nomor_lha": "27/LHA/VI/2021"
    },
    {
      "assign_id": "816ce3bfe3d8ea6447a9a9507344ec87c30d6e64",
      "auditee_name": "Kantor Cabang Tangerang",
      "nomor_lha": "29/LHA/VI/2021"
    },
    {
      "assign_id": "53780947609f37c5eae5b29a15a67c1bdd7bcd52",
      "auditee_name": "Kantor Cabang Tarakan",
      "nomor_lha": "23/LHA/V/2021"
    },
    {
      "assign_id": "1c031c0ddc11847ef3fabd281258502d3963d2ed",
      "auditee_name": "Kantor Cabang Banjarmasin",
      "nomor_lha": "26/LHA/V/2021"
    },
    {
      "assign_id": "6417a790343daf7c5734841c105ab560a265412d",
      "auditee_name": "Kantor Cabang Banyuwangi",
      "nomor_lha": "25/LHA/V/2021"
    },
    {
      "assign_id": "fbbbb5a9734669ef5876ce92dcca5bcfc4904b30",
      "auditee_name": "Kantor Cabang Palangkaraya",
      "nomor_lha": "24/LHA/V/2021"
    },
    {
      "assign_id": "53ffd9eb750c6254ec25b3cdad2cdc2d34bda672",
      "auditee_name": "Kantor Cabang Tanjung Pinang",
      "nomor_lha": "22/LHA/IV/2021"
    },
    {
      "assign_id": "cfb41d09c9fab9f941c5d5c0543ea632c55b693f",
      "auditee_name": "Kantor Cabang Mataram",
      "nomor_lha": "20/LHA/IV/2021"
    },
    {
      "assign_id": "43427459674ff54ba8f3512885279244c7b2e026",
      "auditee_name": "Kantor Cabang Kudus",
      "nomor_lha": "19/LHA/IV/2021"
    },
    {
      "assign_id": "d0ba202be9169ae4f3d3b1c3dce6add3e03be884",
      "auditee_name": "Kantor Cabang Kendari",
      "nomor_lha": "21/LHA/IV/2021"
    },
    {
      "assign_id": "21b69fbf19e74d6793426d6fbfa88e3297288b5f",
      "auditee_name": "Divisi Teknologi Informasi",
      "nomor_lha": "31/LHA/VI/2021"
    },
    {
      "assign_id": "21c0618e3baf12a9c3aa7594b53c32a665ebebde",
      "auditee_name": "Divisi Penunjang Bisnis",
      "nomor_lha": "13/LHA/IV/2021"
    },
    {
      "assign_id": "9a42eabb95dd79cc5d94cd51ba4504094ec2abfb",
      "auditee_name": "Divisi Keuangan dan Investasi",
      "nomor_lha": "18/LHA/IV/2021"
    },
    {
      "assign_id": "243676cd2d0baa3bc73bbe01b6226b1d3434863f",
      "auditee_name": "Divisi Bisnis II",
      "nomor_lha": "17/LHA/IV/2021"
    },
    {
      "assign_id": "8924fa5efe3c8762b1f8c60ae4a29c92aa3a4482",
      "auditee_name": "Divisi Bisnis I",
      "nomor_lha": "14/LHA/IV/2021"
    },
    {
      "assign_id": "1ecb39f278ba59dff8c155ddde65da98ccd69fd4",
      "auditee_name": "Divisi Bisnis III",
      "nomor_lha": "12/LHA/IV/2021"
    },
    {
      "assign_id": "d79626fc3e96deee13de0a6a64d4b13de2a01255",
      "auditee_name": "Divisi Klaim dan Subrogasi",
      "nomor_lha": "16/LHA/IV/2021"
    },
    {
      "assign_id": "6a9823a5765f3b54cd4dc98a755ba766d0017a7d",
      "auditee_name": "Divisi Klaim",
      "nomor_lha": "15/LHA/IV/2021"
    },
    {
      "assign_id": "5b95dccb58497483e56f5a72920b616b8cf4c79b",
      "auditee_name": "Kantor Cabang Kediri",
      "nomor_lha": "10/LHA/III/2021"
    },
    {
      "assign_id": "32146d3a47fc2afc87f03c5b405da774ee6021a2",
      "auditee_name": "Kantor Cabang Ambon",
      "nomor_lha": "09/LHA/III/2021"
    },
    {
      "assign_id": "6f86de9c7e4b80c1ac6ae482be64164b44c77f98",
      "auditee_name": "Kantor Cabang Solo",
      "nomor_lha": "07/LHA/III/2021"
    },
    {
      "assign_id": "38251b44cc09fee738af98a8da0eb865d50c220c",
      "auditee_name": "Kantor Cabang Malang",
      "nomor_lha": "08/LHA/III/2021"
    },
    {
      "assign_id": "3abfa148ac14ea32c70a6543118ec5cbf1e25a6f",
      "auditee_name": "Kantor Cabang Purwokerto",
      "nomor_lha": "11/LHA/III/2021"
    },
    {
      "assign_id": "370ca2258abccfae7b5aa7efe65bb514dea0bd46",
      "auditee_name": "Kantor Cabang Sukabumi",
      "nomor_lha": "06/LHA/II/2021"
    },
    {
      "assign_id": "d7a87bad5ea5c858385c83f907919fef52f17a96",
      "auditee_name": "Kantor Cabang Palopo",
      "nomor_lha": "05/LHA/II/2021"
    },
    {
      "assign_id": "63be3badf6c8196762c05ebb33b8b9bd8b1a18fb",
      "auditee_name": "Kantor Cabang Pekalongan",
      "nomor_lha": "04/LHA/II/2021"
    },
    {
      "assign_id": "2754160722125e86cec03b9540077f771b3e857d",
      "auditee_name": "Kantor Cabang Sumbawa Besar",
      "nomor_lha": "03/LHA/II/2021"
    },
    {
      "assign_id": "9d24c9ebbb92e887f13749887205b3a968605df2",
      "auditee_name": "Kantor Cabang Bitung",
      "nomor_lha": "02/LHA/II/2021"
    },
    {
      "assign_id": "dde43fc57d948303d936f79877a2bb5902315b19",
      "auditee_name": "Kantor Cabang Sorong",
      "nomor_lha": "01/LHA/II/2021"
    },
    {
      "assign_id": "55de714355998ec5a310f40e3724cb2866739d26",
      "auditee_name": "Kantor Cabang Denpasar",
      "nomor_lha": "48/LHP/XII/2020"
    },
    {
      "assign_id": "5f2ca089e14dead585c84c9df8cd8fb73dd371c1",
      "auditee_name": "Kantor Cabang Batam",
      "nomor_lha": "47/LHP/XII/2020"
    },
    {
      "assign_id": "d84a6c2c1846338e386e749e89b0270d61c6632a",
      "auditee_name": "Kantor Cabang Jambi",
      "nomor_lha": "51/LHP/XII/2020"
    },
    {
      "assign_id": "9a0bab655e316f994783f40168ce8899244d2777",
      "auditee_name": "Kantor Cabang Manado",
      "nomor_lha": "45/LHP/XII/2020"
    },
    {
      "assign_id": "c1a2d32f3484d3e71332c34e0919055e8cb345d9",
      "auditee_name": "Divisi Umum",
      "nomor_lha": "55/LHP/XII/2020"
    },
    {
      "assign_id": "73182d5bd8d1b7ccf0fe02222d047bb61a494a45",
      "auditee_name": "Kantor Cabang Gorontalo",
      "nomor_lha": "33/LHP/XI/2020"
    },
    {
      "assign_id": "a6dfaf3ce64f12e2409a3a409e37c909ada428a9",
      "auditee_name": "Kantor Cabang Surabaya",
      "nomor_lha": "38/LHP/XII/2020"
    },
    {
      "assign_id": "3ae26c40c830eb86994b10ce3c1a14bd1dfefb04",
      "auditee_name": "Kantor Cabang DKI Jakarta",
      "nomor_lha": "39/LHP/XII/2020"
    },
    {
      "assign_id": "e60e189d0f74dcf60aba627ca5cafd87ef581722",
      "auditee_name": "Kantor Cabang Medan",
      "nomor_lha": "40/LHP/XII/2020"
    },
    {
      "assign_id": "b4595a886c88b1a19eda825ade96405c130adbda",
      "auditee_name": "Kantor Cabang Khusus Jakarta",
      "nomor_lha": "42/LHP/XII/2020"
    },
    {
      "assign_id": "8a1df5707854e846d99f8e8103641c3e1ce5fa35",
      "auditee_name": "Kantor Cabang Pekanbaru",
      "nomor_lha": "43/LHP/XII/2020"
    },
    {
      "assign_id": "3111c6e79590a17a718f2a0eb8264f128bc9017c",
      "auditee_name": "Kantor Wilayah V Semarang",
      "nomor_lha": "36/LHP/XII/2020"
    },
    {
      "assign_id": "4f3e77a987bccd54d930108df261c2e7b26b1cf3",
      "auditee_name": "Kantor Cabang Balige",
      "nomor_lha": "35/LHP/XII/2020"
    },
    {
      "assign_id": "fbb37cef9d90471df5c8ed1a770bc34eab2b7dfe",
      "auditee_name": "Kantor Wilayah III Jakarta",
      "nomor_lha": "41/LHP/XII/2020"
    },
    {
      "assign_id": "a1212df94f9b83ff9d5c7f68e615eab3f3dcc0e3",
      "auditee_name": "Kantor Wilayah IX Makassar",
      "nomor_lha": "37/LHP/XII/2020"
    },
    {
      "assign_id": "a631405b272f44cafdb5f563b7f967d03248f6db",
      "auditee_name": "Kantor Cabang Bandung",
      "nomor_lha": "24/LHP/XI/2020"
    },
    {
      "assign_id": "c24dc1276176a722340a62b15424cd0f0b15fa03",
      "auditee_name": "Kantor Cabang Samarinda",
      "nomor_lha": "32/LHP/XI/2020"
    },
    {
      "assign_id": "e92aae5f24c15c213f5226eac9ad54a5c0a500e3",
      "auditee_name": "Kantor Cabang Kupang",
      "nomor_lha": "23/LHP/XI/2020"
    },
    {
      "assign_id": "56d58e9d734200ab19df9f53fc41e39780883b80",
      "auditee_name": "Kantor Cabang Palembang",
      "nomor_lha": "26/LHP/XI/2020"
    },
    {
      "assign_id": "b07caab758bcb5c0944bd0d2dfccc19d101f0e98",
      "auditee_name": "Kantor Cabang Pare-pare",
      "nomor_lha": "34/LHP/XI/2020"
    },
    {
      "assign_id": "b1ca560f852ae93049b6ca20b5fd727cfd0f93f3",
      "auditee_name": "Kantor Wilayah VIII Banjarmasin",
      "nomor_lha": "31/LHP/XI/2020"
    },
    {
      "assign_id": "a7d0c87ed45c1a53f1b6ba89f1c9586dadc2c48b",
      "auditee_name": "Kantor Wilayah VII Denpasar",
      "nomor_lha": "22/LHP/XI/2020"
    },
    {
      "assign_id": "75ab410ca6436c5b89b02f3202bd46c4b8504e5b",
      "auditee_name": "Kantor Wilayah IV Bandung",
      "nomor_lha": "25/LHP/XI/2020"
    },
    {
      "assign_id": "ee762098d27fd5fd2a871e27ef9fa5ef0db3b05e",
      "auditee_name": "Kantor Wilayah II Palembang",
      "nomor_lha": "29/LHP/XI/2020"
    },
    {
      "assign_id": "91de092c442a536fc45d8cff6acab19d767e1c3b",
      "auditee_name": "Divisi Keuangan dan Investasi",
      "nomor_lha": "50/LHP/XII/2020"
    },
    {
      "assign_id": "43354d12f26eeaf6233287cd86764f0794b1d83c",
      "auditee_name": "Divisi Bisnis I",
      "nomor_lha": "46/LHP/XII/2020"
    },
    {
      "assign_id": "35ebb8769e96d355bb888e43cac3e4880a8cfe67",
      "auditee_name": "Divisi Bisnis II",
      "nomor_lha": "52/LHP/XII/2020"
    },
    {
      "assign_id": "484ff838ed74ad0851f6a76d9bdb49fadaa3b25e",
      "auditee_name": "Divisi Klaim dan Subrogasi",
      "nomor_lha": "20/LHP/XI/2020"
    },
    {
      "assign_id": "d3a06ccb2657f23358ab842af25dd7ecbad50b73",
      "auditee_name": "Divisi Akuntansi",
      "nomor_lha": "53/LHP/XII/2020"
    },
    {
      "assign_id": "1a4b01bf51f9647817aa35c231d03c655b866aad",
      "auditee_name": "Divisi Teknik dan Administrasi Bisnis",
      "nomor_lha": "44/LHP/XII/2020"
    },
    {
      "assign_id": "e5af45c3cbcb2dc5ecf47fdef84ec8891e4010ee",
      "auditee_name": "Divisi Bisnis III",
      "nomor_lha": "49/LHP/XII/2020"
    },
    {
      "assign_id": "34eb843bcd96d76ef0c85d391e45d0741f0e6075",
      "auditee_name": "Divisi Jaringan dan Layanan",
      "nomor_lha": "18/LHP/XI/2020"
    },
    {
      "assign_id": "3df351f0663a9e089ba08982d2c8b0392385484c",
      "auditee_name": "Kantor Cabang Cirebon",
      "nomor_lha": "21/LHP/XI/2020"
    },
    {
      "assign_id": "38784c88541e66eb6dfc40e81e0ec8912b8ce94c",
      "auditee_name": "Kantor Wilayah VI Surabaya",
      "nomor_lha": "17/LHP/IX/2020"
    },
    {
      "assign_id": "5777112b0525b0d775fd376f8849d4215cf7f0f4",
      "auditee_name": "Kantor Cabang Balikpapan",
      "nomor_lha": "10/LHP/VI/2020"
    },
    {
      "assign_id": "67ce5fdb6f2f8854d3b674e4c9ab9a2d151c0156",
      "auditee_name": "Kantor Cabang Mamuju",
      "nomor_lha": "14/LHP/VI/2020"
    },
    {
      "assign_id": "aa91ef1d10f171447d12f703a70b77fa990d5cc3",
      "auditee_name": "Kantor Cabang Bengkulu",
      "nomor_lha": "15/LHP/VI/2020"
    },
    {
      "assign_id": "b866dcf94436ffbe00c3a4bbcf3f74e22e6c660b",
      "auditee_name": "Kantor Cabang Tasikmalaya",
      "nomor_lha": "9/LHP/VI/2020"
    },
    {
      "assign_id": "b6e07335d83d10296dd506a907c58c56a5eddd63",
      "auditee_name": "Kantor Wilayah I Medan",
      "nomor_lha": "16/LHP/VIII/2020"
    },
    {
      "assign_id": "2941136bee344050f79cb4c4f19a5563ba659f8c",
      "auditee_name": "Kantor Cabang Purwakarta",
      "nomor_lha": "13/LHP/VI/2020"
    }
  ];

  //dummy
  static List<AuditTLReviuModel> dummys() {
    return <AuditTLReviuModel>[
      AuditTLReviuModel(
        obyekAudit: "Kantor Cabang Serang",
        nomorLha: "4/LHA/II/2023",
        listAuditTL: AuditTLModel.dummys(),
      ),
      AuditTLReviuModel(
        obyekAudit: "Kantor Cabang Batam",
        nomorLha: "4/LHA/I3/2023",
        listAuditTL: AuditTLModel.dummys(),
      ),
      AuditTLReviuModel(
        obyekAudit: "Kantor Cabang Sorong",
        nomorLha: "14/LHA/I9/2023",
        listAuditTL: AuditTLModel.dummys(),
      ),
    ];
  }
}
