import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../pages/pages.dart';
import '../../ui/ui.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({
    Key key,
    this.pageBuilder,
    this.bottomNavigationBarItems,
  })  : assert(pageBuilder != null),
        assert(bottomNavigationBarItems != null),
        super(key: key);

  final FlowPage Function(int index) pageBuilder;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  Widget build(BuildContext context) {
    SupportListViewModel supportListViewModel =
        ViewModel.get<SupportListViewModel>();

    return RootScaffold(
      body: FutureBuilder(
        future: supportListViewModel.resourcesClient.getSupportListAsync(),
        builder: (BuildContext context,
            AsyncSnapshot<APIResponse<List<SupportInfo>>> snapshot) {
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
                        imageUrl: supportListViewModel.resourcesClient
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
      pageBuilder: pageBuilder,
      bottomNavigationBarItems: bottomNavigationBarItems,
      bottomNavigationBarIndex: 3,
    );
  }
}
