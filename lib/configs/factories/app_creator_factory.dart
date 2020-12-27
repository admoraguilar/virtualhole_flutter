import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../configs.dart';

class AppCreatorFactory {
  static VirtualHoleApiClient _vHoleApi =
      VirtualHoleApiClient.managed(domain: AppConfig.virtualHoleApi);

  static Future<Creator> fromId(String id) async {
    assert(id != null);

    List<Creator> result = await APIResponseProvider(
      _vHoleApi.creators.get(
        CreatorRequest(
          search: id,
        ),
      ),
    ).getResult();

    return result[0];
  }

  static Creator suisei() {
    return Creator(
      name: 'Suisei Hoshimachi',
      id: 'SztEdPVk',
      avatarUrl:
          'https://yt3.ggpht.com/a/AATXAJzbRjSTNu3QQ7pia2yR5oVTcds7MpmeA3a1xE-h=s900-c-k-c0x00ffffff-no-rj',
      isHidden: false,
      isGroup: false,
      depth: 0,
      affiliations: [
        "hololiveJapan0thGen",
        "hololiveJapan",
        "hololive",
        "hololiveProduction",
        "CoverCorp.",
      ],
      socials: [
        CreatorSocial(
          socialType: SocialType.youtube,
          id: 'UC5CwaMl1eIgY8h02uZw7u8A',
          name: 'Suisei Channel',
          url: 'https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A',
          avatarUrl:
              'https://yt3.ggpht.com/a/AATXAJzbRjSTNu3QQ7pia2yR5oVTcds7MpmeA3a1xE-h=s900-c-k-c0x00ffffff-no-rj',
        )
      ],
    );
  }

  static Creator matsuri() {
    return Creator(
      name: 'Natsuiro Matsuri',
      id: '72Dv02Yo',
      avatarUrl:
          'https://yt3.ggpht.com/a/AATXAJw8RXWyEofFZFI5EwEb7lXDq3Cm6l0SThQxT9XG=s900-c-k-c0x00ffffff-no-rj',
      isHidden: false,
      isGroup: false,
      depth: 0,
      affiliations: [
        "hololiveJapan1stGen",
        "hololiveJapan",
        "hololive",
        "hololiveProduction",
        "CoverCorp.",
      ],
      socials: [
        CreatorSocial(
          socialType: SocialType.youtube,
          id: 'UCQ0UDLQCjY0rmuxCDE38FGg',
          name: 'Matsuri Channel 夏色まつり',
          url: 'https://www.youtube.com/channel/UCQ0UDLQCjY0rmuxCDE38FGg',
          avatarUrl:
              'https://yt3.ggpht.com/a/AATXAJw8RXWyEofFZFI5EwEb7lXDq3Cm6l0SThQxT9XG=s900-c-k-c0x00ffffff-no-rj',
        )
      ],
    );
  }

  static Creator haachama() {
    return Creator(
      name: 'Akai Haato',
      id: 'KravQesT',
      avatarUrl:
          'https://yt3.ggpht.com/a/AATXAJw3IoOJZlLAn_Eyy0r6gJHR3vt64XHfuXCailaCPw=s900-c-k-c0x00ffffff-no-rj',
      isHidden: false,
      isGroup: false,
      depth: 0,
      affiliations: [
        "hololiveJapan1stGen",
        "hololiveJapan",
        "hololive",
        "hololiveProduction",
        "CoverCorp.",
      ],
      socials: [
        CreatorSocial(
          socialType: SocialType.youtube,
          id: 'UC1CfXB_kRs3C-zaeTG3oGyg',
          name: 'Haachama Ch. 赤井はあと',
          url: 'https://www.youtube.com/channel/UC1CfXB_kRs3C-zaeTG3oGyg',
          avatarUrl:
              'https://yt3.ggpht.com/a/AATXAJw3IoOJZlLAn_Eyy0r6gJHR3vt64XHfuXCailaCPw=s900-c-k-c0x00ffffff-no-rj',
        )
      ],
    );
  }
}
