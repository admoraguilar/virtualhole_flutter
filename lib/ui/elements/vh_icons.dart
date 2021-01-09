import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';

class VHIcons {
  static VHIcons _instance = VHIcons._();

  VHIcons._();

  factory VHIcons() => _instance;

  IconData social(String social) {
    if (social == SocialType.youtube) {
      return MdiIcons.youtube;
    } else if (social == SocialType.twitter) {
      return MdiIcons.twitter;
    } else if (social == SocialType.twitch) {
      return MdiIcons.twitch;
    }

    return Icons.music_note;
  }
}
