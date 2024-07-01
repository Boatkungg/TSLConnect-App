import "dart:convert" as convert;
import "package:http/http.dart" as http;

String url = "https://192.168.1.100:8000/";

Future<String> uploadVideo(String filePath) async {
  Map<String, String> headers = {
    "Content-Type": "multipart/form-data",
  };

  var request = http.MultipartRequest('POST', Uri.parse("$url/sign2thai"));

  request.headers.addAll(headers);

  request.files.add(await http.MultipartFile.fromPath('video', filePath));

  var response = await request.send();

  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode((await http.Response.fromStream(response)).body)
            as Map<String, dynamic>;
    return jsonResponse["translation"];
  } else {
    throw Exception('Failed to upload video');
  }
}

Future<String> uploadText(String text) async {
  var response = await http.post(
    Uri.parse("$url/thai2sign"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
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
    throw Exception('Failed to upload text');
  }
}
