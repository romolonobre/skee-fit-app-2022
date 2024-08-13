import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class YoutubeDataSource {
  Future<Map<String, dynamic>> getChannelData({required String channelId});
  Future<Map<String, dynamic>> getPlaylistVideos({required String playlistId, String pageToken});
}

class YoutubeDataSourceImpl implements YoutubeDataSource {
  final String _baseUrl = 'www.googleapis.com';
  final String? _apiKey = dotenv.env['YOUTUBE_API_KEY'];

  @override
  Future<Map<String, dynamic>> getChannelData({required String channelId}) async {
    final parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': _apiKey,
    };

    final uri = Uri.https(_baseUrl, '/youtube/v3/channels', parameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    final response = await http.get(uri, headers: headers);
    if (response.statusCode != 200 || response.body.isEmpty) {
      throw Exception('Failed to fetch channel data');
    }

    return jsonDecode(response.body);
  }

  @override
  Future<Map<String, dynamic>> getPlaylistVideos({required String playlistId, String pageToken = ''}) async {
    final parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '100',
      'pageToken': pageToken,
      'key': _apiKey,
    };

    final uri = Uri.https(_baseUrl, '/youtube/v3/playlistItems', parameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    final response = await http.get(uri, headers: headers);
    if (response.statusCode != 200 || response.body.isEmpty) {
      throw Exception('Failed to fetch playlist videos');
    }

    return jsonDecode(response.body);
  }
}
