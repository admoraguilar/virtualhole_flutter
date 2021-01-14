import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../virtualhole_client.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ClientFactory.managed().vHoleApi.resources.getSupportList(),
      builder: (BuildContext context,
          AsyncSnapshot<ApiResponse<List<SupportInfo>>> snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (snapshot.hasData) {
          List<SupportInfo> supportList = snapshot.data.body;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    for (SupportInfo info in supportList)
                      InfoCard(
                        header: info.header,
                        content: info.content,
                        imageUrl: ClientFactory.managed()
                            .vHoleApi
                            .resources
                            .buildObjectUri(info.imagePath)
                            .toString(),
                        onTap: () => launch(info.url),
                      ),
                    Text('Version: ${BuildInfoClient().version}'),
                    Text('Last data update: ...'),
                  ],
                )
              ],
            ),
          );

          // return ListView.builder(
          //   itemBuilder: (BuildContext context, int index) {
          //     SupportInfo supportInfo = supportList[index];
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 8.0,
          //       ),
          //       child: Column(
          //         children: [
          //           if (index == 0)
          //             SizedBox(
          //               height: 20,
          //             ),
          //           InfoCard(
          //             header: supportInfo.header,
          //             content: supportInfo.content,
          //             imageUrl: ClientFactory.managed()
          //                 .vHoleApi
          //                 .resources
          //                 .buildObjectUri(supportInfo.imagePath)
          //                 .toString(),
          //             onTap: () => launch(supportInfo.url),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          //   itemCount: supportList.length,
          // );
        } else {
          return Center(
            child: HololiveRotatingImage(),
          );
        }
      },
    );
  }
}
