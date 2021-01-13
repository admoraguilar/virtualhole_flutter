import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../../virtualhole_client.dart';

abstract class ContentFeedTabBuilder {
  ContentFeedTabBuilder({
    this.isEnableTapMore = true,
  }) : assert(isEnableTapMore != null);

  final bool isEnableTapMore;

  List<ContentFeedTab> build(BuildContext context);

  ContentFeedTab discover(BuildContext context, {ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Discover',
      icon: Icon(
        Icons.explore,
        color: Colors.white,
      ),
      dataProvider: (int page) => ApiResponseProvider(
        ClientFactory.managed()
            .vHoleApi
            .contents
            .getDiscover(request.copyWith(page: page)),
      ).getResult(),
      cardContentBuilder: (ContentDTO contentDTO) {
        return Image.network(
          contentDTO.content.thumbnailUrl,
          fit: BoxFit.cover,
        );
      },
      cardTitleBuilder: (ContentDTO contentDTO) {
        return Text(
          contentDTO.content.title,
          overflow: TextOverflow.ellipsis,
        );
      },
      cardCreatorBuilder: (ContentDTO contentDTO) {
        return Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundImage:
                  NetworkImage(contentDTO.content.creator.avatarUrl),
            ),
            SizedBox(width: 4),
            Text(contentDTO.content.creator.name),
          ],
        );
      },
      cardDateBuilder: (ContentDTO contentDTO) {
        return Text('Created ${contentDTO.creationDateDisplay}');
      },
      onTap: (ContentDTO contentDTO) {
        FirebaseAnalytics().logViewItem(
          itemId: contentDTO.content.id,
          itemName: contentDTO.content.title,
          itemCategory: contentDTO.content.fullType,
        );

        String url = contentDTO.content.url;
        if (url != null || url.isNotEmpty) {
          launch(url);
        }
      },
      onTapMore: isEnableTapMore
          ? (ContentDTO contentDTO) {
              FirebaseAnalytics().logViewItem(
                itemId: contentDTO.content.id,
                itemName: contentDTO.content.title,
                itemCategory: contentDTO.content.fullType,
              );

              FirebaseAnalytics().logViewItem(
                itemId: contentDTO.content.creator.id,
                itemName: contentDTO.content.creator.name,
                itemCategory: 'creator',
              );
              FlowApp.of(context).map.navigate(FromContentCard(contentDTO));
            }
          : null,
    );
  }

  ContentFeedTab community(BuildContext context, {ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Community',
      icon: Icon(
        MdiIcons.accountGroup,
        color: Colors.white,
      ),
      dataProvider: (int page) => ApiResponseProvider(
        ClientFactory.managed()
            .vHoleApi
            .contents
            .getCommunity(request.copyWith(page: page)),
      ).getResult(),
      cardContentBuilder: (ContentDTO contentDTO) {
        return Image.network(
          contentDTO.content.thumbnailUrl,
          fit: BoxFit.cover,
        );
      },
      cardTitleBuilder: (ContentDTO contentDTO) {
        return Text(
          contentDTO.content.title,
          overflow: TextOverflow.ellipsis,
        );
      },
      cardCreatorBuilder: (ContentDTO contentDTO) {
        return Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundImage:
                  NetworkImage(contentDTO.content.creator.avatarUrl),
            ),
            SizedBox(width: 4),
            Text(contentDTO.content.creator.name),
          ],
        );
      },
      cardDateBuilder: (ContentDTO contentDTO) {
        return Text('Created ${contentDTO.creationDateDisplay}');
      },
      onTap: (ContentDTO contentDTO) {
        FirebaseAnalytics().logViewItem(
          itemId: contentDTO.content.id,
          itemName: contentDTO.content.title,
          itemCategory: contentDTO.content.fullType,
        );

        String url = contentDTO.content.url;
        if (url != null || url.isNotEmpty) {
          launch(url);
        }
      },
    );
  }

  ContentFeedTab live(BuildContext context, {ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Live',
      icon: Icon(
        MdiIcons.accessPoint,
        color: Colors.white,
      ),
      dataProvider: (int page) => ApiResponseProvider(
        ClientFactory.managed()
            .vHoleApi
            .contents
            .getLive(request.copyWith(page: page)),
      ).getResult(),
      cardContentBuilder: (ContentDTO contentDTO) {
        return Image.network(
          contentDTO.content.thumbnailUrl,
          fit: BoxFit.cover,
        );
      },
      cardTitleBuilder: (ContentDTO contentDTO) {
        return Text(
          contentDTO.content.title,
          overflow: TextOverflow.ellipsis,
        );
      },
      cardCreatorBuilder: (ContentDTO contentDTO) {
        return Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundImage:
                  NetworkImage(contentDTO.content.creator.avatarUrl),
            ),
            SizedBox(width: 4),
            Text(contentDTO.content.creator.name),
          ],
        );
      },
      cardDateBuilder: (ContentDTO contentDTO) {
        return Text("LIVE NOW");
      },
      cardIndicatorBuilder: (ContentDTO contentDTO) {
        MLog.log('build');
        return CircleAvatar(
          backgroundColor: Colors.black54,
          child: Icon(
            MdiIcons.accessPoint,
            size: 30,
            color: Colors.red,
          ),
        );
      },
      onTap: (ContentDTO contentDTO) {
        FirebaseAnalytics().logViewItem(
          itemId: contentDTO.content.id,
          itemName: contentDTO.content.title,
          itemCategory: contentDTO.content.fullType,
        );

        String url = contentDTO.content.url;
        if (url != null || url.isNotEmpty) {
          launch(url);
        }
      },
      onTapMore: isEnableTapMore
          ? (ContentDTO contentDTO) {
              FirebaseAnalytics().logViewItem(
                itemId: contentDTO.content.id,
                itemName: contentDTO.content.title,
                itemCategory: contentDTO.content.fullType,
              );

              FirebaseAnalytics().logViewItem(
                itemId: contentDTO.content.creator.id,
                itemName: contentDTO.content.creator.name,
                itemCategory: 'creator',
              );
              FlowApp.of(context).map.navigate(FromContentCard(contentDTO));
            }
          : null,
    );
  }

  ContentFeedTab scheduled(BuildContext context, {ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Scheduled',
      icon: Icon(
        Icons.schedule,
        color: Colors.white,
      ),
      dataProvider: (int page) => ApiResponseProvider(
        ClientFactory.managed()
            .vHoleApi
            .contents
            .getSchedule(request.copyWith(page: page)),
      ).getResult(),
      cardContentBuilder: (ContentDTO contentDTO) {
        return Image.network(
          contentDTO.content.thumbnailUrl,
          fit: BoxFit.cover,
        );
      },
      cardTitleBuilder: (ContentDTO contentDTO) {
        return Text(
          contentDTO.content.title,
          overflow: TextOverflow.ellipsis,
        );
      },
      cardCreatorBuilder: (ContentDTO contentDTO) {
        return Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundImage:
                  NetworkImage(contentDTO.content.creator.avatarUrl),
            ),
            SizedBox(width: 4),
            Text(contentDTO.content.creator.name),
          ],
        );
      },
      cardDateBuilder: (ContentDTO contentDTO) {
        return Text('Live in ${contentDTO.scheduleDateDisplay}');
      },
      cardIndicatorBuilder: (ContentDTO contentDTO) {
        return CircleAvatar(
          backgroundColor: Colors.black54,
          child: Icon(
            Icons.schedule,
            size: 30,
            color: Colors.white,
          ),
        );
      },
      onTap: (ContentDTO contentDTO) {
        FirebaseAnalytics().logViewItem(
          itemId: contentDTO.content.id,
          itemName: contentDTO.content.title,
          itemCategory: contentDTO.content.fullType,
        );

        String url = contentDTO.content.url;
        if (url != null || url.isNotEmpty) {
          launch(url);
        }
      },
      onTapMore: isEnableTapMore
          ? (ContentDTO contentDTO) {
              FirebaseAnalytics().logViewItem(
                itemId: contentDTO.content.id,
                itemName: contentDTO.content.title,
                itemCategory: contentDTO.content.fullType,
              );

              FirebaseAnalytics().logViewItem(
                itemId: contentDTO.content.creator.id,
                itemName: contentDTO.content.creator.name,
                itemCategory: 'creator',
              );
              FlowApp.of(context).map.navigate(FromContentCard(contentDTO));
            }
          : null,
    );
  }
}
