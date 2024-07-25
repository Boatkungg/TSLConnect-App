import "dart:convert" as convert;
import "dart:typed_data";
import "package:http/http.dart" as http;

String url = "https://api.mystrokeapi.uk";

Future<String> uploadVideo(Uint8List bytes) async {
  Map<String, String> headers = {
    "Content-Type": "multipart/form-data",
  };

  var request = http.MultipartRequest('POST', Uri.parse("$url/sign2thai"));

  request.headers.addAll(headers);

  request.files.add(http.MultipartFile.fromBytes("file", bytes, filename: "video.mp4"));

  var response = await request.send();

  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode((await http.Response.fromStream(response)).body)
            as Map<String, dynamic>;
    return convert.utf8.decode(jsonResponse["translation"].toString().codeUnits);
  } else {
    return "";
  }
}

Future<String> uploadText(String text) async {
  var response = await http.post(
    Uri.parse("$url/thai2sign"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: convert.jsonEncode(<String, String>{
      'text': text,
    }),
  );

  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse["link"];
  } else {
    return "";
  }
}
