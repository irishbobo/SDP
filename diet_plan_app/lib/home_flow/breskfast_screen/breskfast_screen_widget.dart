import '/components/appbar_widget.dart';
import '/components/comon_componet_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'breskfast_screen_model.dart';
export 'breskfast_screen_model.dart';

class BreskfastScreenWidget extends StatefulWidget {
  const BreskfastScreenWidget({super.key});

  @override
  State<BreskfastScreenWidget> createState() => _BreskfastScreenWidgetState();
}

class _BreskfastScreenWidgetState extends State<BreskfastScreenWidget> {
  late BreskfastScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BreskfastScreenModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.appbarModel,
                updateCallback: () => safeSetState(() {}),
                child: const AppbarWidget(
                  title: 'Breakfast',
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      16.0,
                      0,
                      16.0,
                    ),
                    scrollDirection: Axis.vertical,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('brek_fast_iIngredients');
                        },
                        child: wrapWithModel(
                          model: _model.comonComponetModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: const ComonComponetWidget(),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('brek_fast_iIngredients');
                        },
                        child: wrapWithModel(
                          model: _model.comonComponetModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: const ComonComponetWidget(),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('brek_fast_iIngredients');
                        },
                        child: wrapWithModel(
                          model: _model.comonComponetModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: const ComonComponetWidget(),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('brek_fast_iIngredients');
                        },
                        child: wrapWithModel(
                          model: _model.comonComponetModel4,
                          updateCallback: () => safeSetState(() {}),
                          child: const ComonComponetWidget(),
                        ),
                      ),
                    ].divide(const SizedBox(height: 16.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
