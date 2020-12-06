import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/api/storage/dynamic/support_info.dart';
import 'package:virtualhole_flutter/client/viewmodels/support_list_viewmodel.dart';
import 'package:virtualhole_flutter/common/common.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SupportListViewModel supportListViewModel =
        ViewModelContainer.instance.get<SupportListViewModel>();

    return FutureBuilder(
        future:
            supportListViewModel.storageClient.dynamic.listSupportInfoAsync(),
        builder:
            (BuildContext context, AsyncSnapshot<List<SupportInfo>> snapshot) {
          if (snapshot.hasData) {
            List<SupportInfo> supportList = snapshot.data;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text(supportList[index].header,
                    style: TextStyle(
                      color: Colors.white,
                    ));
              },
              itemCount: supportList.length,
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
