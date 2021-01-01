import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../virtualhole_client.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({
    Key key,
    this.bottomNavigationBarOnItemTap,
    this.bottomNavigationBarItems,
  })  : assert(bottomNavigationBarOnItemTap != null),
        assert(bottomNavigationBarItems != null),
        super(key: key);

  final Function(int index) bottomNavigationBarOnItemTap;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      body: FutureBuilder(
        future: ClientFactory.vHoleApi().resources.getSupportList(),
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
                        imageUrl: ClientFactory.vHoleApi()
                            .resources
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
      bottomNavigationBarOnItemTap: bottomNavigationBarOnItemTap,
      bottomNavigationBarItems: bottomNavigationBarItems,
      bottomNavigationBarIndex: 3,
    );
  }
}
