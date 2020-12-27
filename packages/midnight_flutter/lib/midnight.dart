import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class Midnight {
  static void init() {
    // Done for package:connectivity package:
    // https://pub.dev/packages/connectivity/example
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    }

    // data_connection_checker additional DNSes for IPv6 (For iOS)
    // https://github.com/komapeb/data_connection_checker/issues/13
    DataConnectionChecker().addresses.clear();
    DataConnectionChecker().addresses.addAll(
      [
        AddressCheckOptions(
          InternetAddress('8.8.8.8', type: InternetAddressType.IPv4),
        ), // Google
        AddressCheckOptions(
          InternetAddress('2001:4860:4860::8888',
              type: InternetAddressType.IPv6),
        ), // Google
        AddressCheckOptions(
          InternetAddress('1.1.1.1', type: InternetAddressType.IPv4),
        ), // CloudFlare
        AddressCheckOptions(
          InternetAddress('2606:4700:4700::1111',
              type: InternetAddressType.IPv6),
        ), // CloudFlare
        AddressCheckOptions(
          InternetAddress('208.67.222.222', type: InternetAddressType.IPv4),
        ), // OpenDNS
        AddressCheckOptions(
          InternetAddress('2620:0:ccc::2', type: InternetAddressType.IPv6),
        ), // OpenDNS
        AddressCheckOptions(
          InternetAddress('180.76.76.76', type: InternetAddressType.IPv4),
        ), // Baidu
        AddressCheckOptions(
          InternetAddress('2400:da00::6666', type: InternetAddressType.IPv6),
        ), // Baidu
      ],
    );
  }
}
