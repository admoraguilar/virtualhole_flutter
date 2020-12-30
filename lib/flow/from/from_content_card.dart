import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import 'package:virtualhole_flutter/flow/to/to_creator_page.dart';

class FromContentCard extends FlowContext {
  FromContentCard(this.contentDTO) : assert(contentDTO != null);
  final ContentDTO contentDTO;
}

class FromContentCardResponse extends FlowResponse<FromContentCard> {
  void respond() {
    navigate(ToCreatorPage(context.contentDTO.content.creator.id));
  }
}
