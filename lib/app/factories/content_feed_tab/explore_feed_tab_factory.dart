import '../../../virtualhole_client.dart';

class ExploreFeedTabBuilder extends ContentFeedTabBuilder {
  @override
  List<ContentFeedTab> build() {
    return [
      discover(),
      community(),
      live(),
      scheduled(),
    ];
  }
}
