import 'package:http/http.dart' as http;
import 'dart:convert';

class MediaApiClient {
  final String baseUrl;
  http.Client client = http.Client();

  MediaApiClient({required this.baseUrl});

  Future<Map<String, dynamic>> addMedia({
    required int mediaType,
    required String mediaPath,
    required int startFrame,
    required int endFrame,
    required int recordFrame,
    required int trackIndex,
    required String timelineName,
  }) async {
    var uri = Uri.parse('$baseUrl/add_media');
    print("uri: $uri");
    final response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'mediaType': mediaType,
        'mediaPath': mediaPath,
        'startFrame': startFrame,
        'endFrame': endFrame,
        'recordFrame': recordFrame,
        'trackIndex': trackIndex,
        'timelineName': timelineName,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to add media: ${response.statusCode} ${response.body}');
    }
  }
}

void main() async {
  var client = MediaApiClient(baseUrl: 'http://127.0.0.1:5000');

  print("Created client, now adding media...");

  var message = await client.addMedia(
    mediaType: 1,
    mediaPath:
        '/Users/peterkolloch/Sync/2023-04-greece-video/AtMeltemiBeachHouse.mp4',
    startFrame: 0,
    endFrame: 1000,
    recordFrame: 180000,
    trackIndex: 1,
    timelineName: 'MyTimeline',
  );

  print('Response from server: $message');

  message = await client.addMedia(
    mediaType: 2,
    mediaPath:
        '/Users/peterkolloch/Sync/2023-04-greece-video/AtMeltemiBeachHouse.mp4',
    startFrame: 0,
    endFrame: 1000,
    recordFrame: 180000,
    trackIndex: 1,
    timelineName: 'MyTimeline',
  );

  print('Response from server: $message');

  /*
  audio_clip = media_pool.ImportMedia('/Users/peterkolloch/Sync/2023-05-15-nexxiot-arch/unsynced/230515_0178_1-2.wav')[0]

  audio_clip_info = {
    "mediaPoolItem": audio_clip, 
    "startFrame": 50, # within the source clip (in)
    "endFrame": 550, # within the source clip (out)
    "mediaType": 2,
    "trackIndex": 2,
    "recordFrame": 180000 + 100
}
  */

  message = await client.addMedia(
    mediaType: 2,
    mediaPath:
        '/Users/peterkolloch/Sync/2023-05-15-nexxiot-arch/unsynced/230515_0178_1-2.wav',
    startFrame: 30,
    endFrame: 550,
    trackIndex: 2,
    recordFrame: 180000 + 100,
    timelineName: 'MyTimeline',
  );

  print('Response from server: $message');
}
