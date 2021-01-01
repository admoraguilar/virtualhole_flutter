import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../virtualhole_client.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
