import 'dart:async';
import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../virtualhole_client.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key key,
    ScrollController scrollController,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  final ScrollController scrollController;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Source: TextField widget rebuilds on tap: https://stackoverflow.com/a/57417560
  GlobalKey<EditableTextState> _textEditState = GlobalKey<EditableTextState>();
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      FlowApp.of(context).routerDelegate.popRoute();
                    },
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: TextField(
                    key: _textEditState,
                    controller: _textEditingController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          _textEditingController.clear();
                          setState(() {});
                        },
                      ),
                    ),
                    onChanged: (String text) {
                      if (_timer != null && _timer.isActive) {
                        _timer.cancel();
                      }

                      _timer = Timer(Duration(seconds: 2), () {
                        setState(() {});
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 12,
          child: FutureBuilder(
            future: ApiResponseProvider(
              ClientFactory.managed().vHoleApi.creators.get(
                    CreatorRequest(
                      search: _textEditingController.text,
                    ),
                  ),
            ).getResult(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Creator>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return HololiveRotatingImage();
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  (!snapshot.hasData || snapshot.hasError)) {
                return ErrorPage(
                  onTryAgain: () => setState(() {}),
                );
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  (snapshot.data == null || snapshot.data.length <= 0)) {
                return Center(
                  child: Text('No results found. TMT'),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  controller: _scrollController,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Creator creator = snapshot.data[index];
                    return Container(
                      height: 40,
                      child: GestureDetector(
                        child: Card(
                          child: Row(
                            children: [
                              if (creator.avatarUrl.isNotEmpty)
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(creator.avatarUrl),
                                ),
                              SizedBox(width: 8),
                              Text(creator.name)
                            ],
                          ),
                        ),
                        onTap: () {
                          _textEditingController.clear();
                          FocusScope.of(context).unfocus();
                          FlowApp.of(context)
                              .map
                              .navigate(ToCreatorPage(creator.id));
                        },
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
