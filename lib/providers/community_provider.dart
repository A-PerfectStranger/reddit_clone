import 'package:flutter/material.dart';
import '../models/community_model.dart';
import '../mock/mock_data.dart';

class CommunityProvider extends ChangeNotifier {
  final List<CommunityModel> _communities = MockData.generateCommunities();

  List<CommunityModel> get communities => _communities;

  void toggleJoin(CommunityModel community) {
    community.joined = !community.joined;
    notifyListeners();
  }
}
