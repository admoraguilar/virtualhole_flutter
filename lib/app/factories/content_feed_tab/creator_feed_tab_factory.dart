import 'package:flutter/material.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../../virtualhole_client.dart';

class CreatorFeedTabBuilder extends ContentFeedTabBuilder {
  CreatorFeedTabBuilder.single(Creator creator)
      : assert(creator != null),
        creators = [creator],
        isSingle = true,
        super(isEnableTapMore: false);

  CreatorFeedTabBuilder()
      : creators = [],
        isSingle = false,
        super(isEnableTapMore: true);

  final List<Creator> creators;
  final bool isSingle;

  factory CreatorFeedTabBuilder.fromIds(List<String> creatorIds) {
    CreatorFeedTabBuilder builder = CreatorFeedTabBuilder();
    creatorIds.forEach((String id) {
      builder.creators.add(Creator(id: id));
    });
    return builder;
  }

  @override
  List<ContentFeedTab> build(BuildContext context) {
    ContentFeedTab _live() => live(
          context,
          request: ContentRequest(
            isCreatorsInclude: true,
            creatorIds: creators.map((c) => c.id).toList(),
          ),
        );

    ContentFeedTab _scheduled() => scheduled(
          context,
          request: ContentRequest(
            isCreatorsInclude: true,
            creatorIds: creators.map((c) => c.id).toList(),
          ),
        );

    ContentFeedTab _discover() => discover(
          context,
          request: ContentRequest(
            isCreatorsInclude: true,
            creatorIds: creators.map((c) => c.id).toList(),
          ),
        );

    ContentFeedTab _community() => community(
          context,
          request: ContentRequest(
            isCreatorRelated: true,
            creatorIds: creators.map((c) => c.id).toList(),
          ),
        );

    if (isSingle) {
      return [
        _live(),
        _scheduled(),
        _discover(),
        _community(),
      ];
    } else {
      return [
        _discover(),
        _community(),
        _live(),
        _scheduled(),
      ];
    }
  }
}
