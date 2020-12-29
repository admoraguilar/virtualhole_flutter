import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../virtualhole_client.dart';

class FromContentCard extends FlowContext {
  FromContentCard(this.contentDTO) : assert(contentDTO != null);
  final ContentDTO contentDTO;
}

class ToCreatorPageResponse extends FlowResponse<FromContentCard> {
  bool get canRespond => true;

  void respond() {
    pages.add(FlowPage(
      key: UniqueKey(),
      name: '/creator',
      child: CreatorPage(
        key: GlobalKey<NavigatorState>(),
        creatorBuilder:
            CreatorFactory.fromIdAsync(context.contentDTO.content.creator.id),
        contentFeedTabBuilder: (Creator creator) =>
            ContentFeedTabFactory.creator([creator]),
        onBottomNavigationBarItemTap: (int index) =>
            navigate(ToHomeRoute(index)),
        bottomNavigationBarItems: BottomNavigationFactory.main(),
      ),
    ));
  }
}
