import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final IndexPageListBloc _indexPageListBloc = IndexPageListBloc();
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: _indexPageListBloc,
      builder: ((
          BuildContext context,
          IndexPageListState state
        ) {
        List<Widget> listComps = List();

        state.list.forEach((s) {
          listComps.add(ListTile(
            leading: Icon(Icons.access_alarm),
            title: Text('点击按钮以设置title'),
            trailing: MaterialButton(
              child: new Text('戳我'),
              textColor: Colors.blueAccent,
              onPressed: () => _indexPageListBloc.setTitle(s)),
          ));
        });

        return Scaffold(
          appBar: AppBar(
            title: Text(state.title),
          ),
          body: ListView(
            children: listComps,
          )
        );
      })
    );
  }
}

abstract class IndexPageListEvent {}

class SetIndexPageTitleEvent extends IndexPageListEvent {
  String title;

  SetIndexPageTitleEvent({ this.title });
}

class IndexPageListState {
  List<String> list;
  String title;

  IndexPageListState({ this.list, this.title });
}

class IndexPageListBloc extends Bloc<IndexPageListEvent, IndexPageListState> {
  IndexPageListState _currentListState = IndexPageListState(
    list: ['aaa', 'bbb', 'ccc'],
    title: '首页'
  );

  IndexPageListState get initialState => _currentListState;

  void setTitle(String title) {
    dispatch(SetIndexPageTitleEvent(title: title));
  }

  @override
  Stream<IndexPageListState> mapEventToState(IndexPageListEvent event) async* {
    if (event is SetIndexPageTitleEvent) {
      yield IndexPageListState(
        list: _currentListState.list,
        title: event.title
      );
    }
  }

}