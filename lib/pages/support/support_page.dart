import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../virtualhole_client.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({
    Key key,
    this.onBottomNavigationBarItemTap,
    this.bottomNavigationBarItems,
  })  : assert(onBottomNavigationBarItemTap != null),
        assert(bottomNavigationBarItems != null),
        super(key: key);

  final Function(int index) onBottomNavigationBarItemTap;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  Widget build(BuildContext context) {
    ResourcesClient resourcesClient =
        VirtualHoleApiClient.managed(domain: 'www.virtualhole.app').resources;

    return FlowScaffold(
      body: FutureBuilder(
        future: resourcesClient.getSupportListAsync(),
        builder: (BuildContext context,
            AsyncSnapshot<ApiResponse<List<SupportInfo>>> snapshot) {
          if (snapshot.hasError) {
            throw snapshot.error;
          }
          if (snapshot.hasData) {
            List<SupportInfo> supportList = snapshot.data.body;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                SupportInfo supportInfo = supportList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Column(
                    children: [
                      if (index == 0)
                        SizedBox(
                          height: 20,
                        ),
                      InfoCard(
                        header: supportInfo.header,
                        content: supportInfo.content,
                        imageUrl: resourcesClient
                            .buildObjectUri(supportInfo.imagePath)
                            .toString(),
                        onTap: () => launch(supportInfo.url),
                      ),
                    ],
                  ),
                );
              },
              itemCount: supportList.length,
            );
          } else {
            return Center(
              child: HololiveRotatingImage(),
            );
          }
        },
      ),
      onBottomNavigationBarItemTap: onBottomNavigationBarItemTap,
      bottomNavigationBarItems: bottomNavigationBarItems,
      bottomNavigationBarIndex: 3,
    );
  }
}
