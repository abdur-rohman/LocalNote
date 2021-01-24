import 'package:flutter/material.dart';

class KeepAliveFutureBuilder extends StatefulWidget {
  final Future future;
  final AsyncWidgetBuilder builder;

  const KeepAliveFutureBuilder({Key key, this.future, this.builder})
      : super(key: key);

  @override
  _KeepAliveFutureBuilderState createState() => _KeepAliveFutureBuilderState();
}

class _KeepAliveFutureBuilderState extends State<KeepAliveFutureBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: widget.future,
      builder: widget.builder,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
