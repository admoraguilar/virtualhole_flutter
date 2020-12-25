import 'package:flutter/cupertino.dart';
import 'package:virtualhole_flutter/client/configs/configs.dart';
import 'package:virtualhole_flutter/client/pages/app/root_flow_page_helper.dart';
import 'package:virtualhole_flutter/client/pages/creator/creator_page.dart';
import 'package:virtualhole_flutter/client/ui/elements/root_scaffold.dart';
import 'package:virtualhole_flutter/midnight_flutter/flow_handler/flow_handler.dart';

class CreatorFlowPage<T> extends FlowPage<T> {
  CreatorFlowPage()
      : super(
          key: UniqueKey(),
          name: '/creator',
          designType: FlowDesignType.Material,
          child: RootScaffold(
            key: GlobalKey<NavigatorState>(),
            title: '${AppConfig.appName}',
            body: CreatorPage(),
            pageBuilder: () => RootFlowPageHelper.generateRootPages(),
            bottomNavigationBarItems:
                RootFlowPageHelper.generateBottomNavigationBarItems(),
          ),
        );
}
