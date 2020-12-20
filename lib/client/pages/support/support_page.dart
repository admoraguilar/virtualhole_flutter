import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtualhole_flutter/api/common/api_response.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/api.dart';
import 'package:virtualhole_flutter/client/ui/ui.dart';
import 'package:virtualhole_flutter/client/pages/support/support_list_viewmodel.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SupportListViewModel supportListViewModel =
        ViewModel.get<SupportListViewModel>();

    return FutureBuilder(
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
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
