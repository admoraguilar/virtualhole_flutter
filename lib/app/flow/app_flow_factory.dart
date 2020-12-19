import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/app/app_config.dart' as config;

class AppFlowFactory {
  static FlowPage discoverPage() {
    return pageRaw(
      name: '/discover',
    );
  }

  static FlowPage pageRaw({
    Key key,
    String name,
    FlowDesignType designType,
    FlowScaffoldSettings scaffoldSettings,
    Widget child,
  }) {
    assert(child != null);

    key ??= UniqueKey();
    designType ??= FlowDesignType.Material;

    return FlowPage(
      key: key,
      name: name,
      designType: designType,
      scaffoldSettings: scaffoldSettings,
      child: child,
    );
  }

  static FlowScaffoldSettings scaffoldSettingsRaw({
    @required BottomNavigationBar bottomNavigationBar,
  }) {
    return FlowScaffoldSettings(
      appBar: AppBar(
        title: Text('${config.kAppName}'),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: FlowHandler.get().routerDelegate.popRoute,
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  static Widget bottomNavigationBarRaw({
    @required List<BottomNavigationBarItem> items,
    @required List<FlowPage> pages,
    @required int currentIndex,
  }) {
    assert(items != null);
    assert(pages != null);
    assert(items.length == pages.length);
    assert(currentIndex != null && currentIndex > -1);

    void pushPage(FlowPage flowAppPage) {
      FlowHandler.get().routerDelegate.setDirty(() {
        FlowHandler.get().routerDelegate.pages.add(flowAppPage);
      });
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: items,
      onTap: (int index) => pushPage(pages[index]),
    );
  }
}
