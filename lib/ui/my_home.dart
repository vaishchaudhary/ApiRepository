import 'package:api_example/network/api_service.dart';
import 'package:api_example/network/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API TEST"),
      ),
      body: _listFutureTasks(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final api = Provider.of<ApiService>(context, listen: false);
          api.getTasks().then((it) {
           print(it.results);
          }).catchError((onError){
            print(onError.toString());
          });
        },
        child: Icon(Icons.terrain),
      ),
    );
  }

  FutureBuilder _listFutureTasks(BuildContext context) {
    return

      FutureBuilder<Autogenerated>(
      future: Provider.of<ApiService>(context, listen: false).getTasks(),
      builder: (BuildContext context, AsyncSnapshot<Autogenerated> snapshot) {
        print("new data"+snapshot.data.toString());
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasError) {
            return Container(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          final tasks = snapshot.data;
          return _listTasks(context: context, tasks: tasks);

        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  ListView _listTasks({BuildContext context, Autogenerated tasks}) {
    return ListView.builder(
      itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                title: Text(tasks.status),
              ),
            ),
          );
        });
  }
}

