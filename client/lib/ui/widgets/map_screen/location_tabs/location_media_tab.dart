import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:floob/data/models/file.dart';
import 'package:floob/data/models/location.dart';
import 'package:floob/utils/floob_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class LocationMediaTab extends ConsumerStatefulWidget {
  const LocationMediaTab({required this.location, super.key});

  final Location location;

  @override
  _LocationMediaTabState createState() => _LocationMediaTabState();
}

class _LocationMediaTabState extends ConsumerState<LocationMediaTab> {
  // TODO: Adjust this function for use with the API, use it when ready
  // ?: Move this function to the controller
  Future<List<File>> _loadFiles() async {
    final http.Response response =
        await FloobApi.get('/locations/${widget.location.id}/reviews');
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(json.decode(response.body) as List);
      return data
          .map((Map<String, dynamic> review) => File.fromJson(review))
          .toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 24),
        _buildVideosSection(context),
        const SizedBox(height: 24),
        _buildImagesSection(context),
        const SizedBox(height: 24),
        _buildAudioSection(context),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        tr('location_media_no_media'),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildVideosSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('location_media_videos'),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildEmptyState(context),
      ],
    );
  }

  Widget _buildImagesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('location_media_images'),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildEmptyState(context),
      ],
    );
  }

  Widget _buildAudioSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('location_media_audio'),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildEmptyState(context),
      ],
    );
  }
}
