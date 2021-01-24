import 'package:flutter/material.dart';
import 'package:local_note/providers/base_provider.dart';
import 'package:local_note/utils/color_util.dart';

class StateWidget extends StatelessWidget {
  final BuildContext context;
  final ViewState viewState;
  final Widget idle;

  const StateWidget(
      {Key key,
      @required this.viewState,
      @required this.context,
      @required this.idle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = viewState;

    if (state is Idle) {
      return idle;
    } else if (state is Success) {
      return Center(
        child: Icon(
          Icons.check_circle,
          color: colorSuccess,
          size: 64,
        ),
      );
    } else if (state is Loading) {
      return LoadingWidget();
    } else if (state is Error) {
      return ExceptionWidget(error: state.error);
    } else {
      return Container();
    }
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }
}

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({
    Key key,
    @required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: colorDanger,
          size: 64,
        ),
        Container(
          margin: EdgeInsets.all(16),
          child: Text(
            error,
            style: TextStyle(fontSize: 16, color: colorPrimary),
          ),
        )
      ],
    );
  }
}
