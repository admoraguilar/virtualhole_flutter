import 'package:flutter/cupertino.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../configs/configs.dart';
import '../../pages/pages.dart';
import '../../ui/ui.dart';

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
