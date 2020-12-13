import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'package:virtualhole_flutter/client/ui/elements/info_card.dart';
import 'package:virtualhole_flutter/common/common.dart';
import 'package:virtualhole_flutter/client/pages/support/support_list_viewmodel.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResourcesClient resourcesClient = ViewModelContainer.instance
        .get<VirtualHoleApiWrapperClient>()
        .resources;
    SupportListViewModel supportListViewModel =
        ViewModelContainer.instance.get<SupportListViewModel>();

    return FutureBuilder(
        future: supportListViewModel.resourcesClient.getSupportListAsync(),
        builder:
            (BuildContext context, AsyncSnapshot<List<SupportInfo>> snapshot) {
          if (snapshot.hasData) {
            List<SupportInfo> supportList = snapshot.data;
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
                            .buildObjectUrl(supportInfo.imagePath),
                        onTap: () => launch(supportInfo.url),
                      ),
                    ],
                  ),
                );
              },
              itemCount: supportList.length,
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
