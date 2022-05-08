import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../virtualhole_client.dart';

class ToCreatorPage extends FlowContext {
  ToCreatorPage(this.creatorId)
      : assert(creatorId != null && creatorId.isNotEmpty);

  final String creatorId;
}

class ToCreatorPageResponse extends FlowResponse<ToCreatorPage> {
  @override
  void respond() {
    pages.add(
      FlowPage(
        key: UniqueKey(),
        name: '/creator',
        child: RootScaffold(
          key: GlobalKey<NavigatorState>(),
          body: Builder(
            builder: (BuildContext buildContext) {
              return CreatorPage(
                creatorBuilder: CreatorFactory().fromId(context.creatorId),
                contentFeedTabBuilder: (Creator creator) =>
                    CreatorFeedTabBuilder.single(creator).build(buildContext),
              );
            },
          ),
          bottomNavigationBarItems: HomeBottomNavigationItemsBuilder().build(),
          bottomNavigationBarOnItemTap: (int index) => navigate(
            FromHomeRoute(index),
          ),
        ),
      ),
    );
  }
}