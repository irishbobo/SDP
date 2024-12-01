import '/flutter_flow/flutter_flow_util.dart';
import 'onbodying_screen_widget.dart' show OnbodyingScreenWidget;
import 'package:flutter/material.dart';

class OnbodyingScreenModel extends FlutterFlowModel<OnbodyingScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
