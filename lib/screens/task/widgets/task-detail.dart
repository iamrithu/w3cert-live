import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w3cert/provider/providers.dart';

class TaskDetail extends ConsumerStatefulWidget {
  const TaskDetail({Key? key}) : super(key: key);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends ConsumerState<TaskDetail> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(singleTaskProvider);
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: Container(
        width: width,
        height: height * 0.5,
        child: data.when(
          data: (_data) {
            return Column(
              children: [
                Text(
                    "${_data.project == null ? "--" : _data.project!.projectName}")
              ],
            );
          },
          error: (e, s) {
            return Text("${e}");
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),

        // actions: <Widget>[
        //   TextButton(
        //     onPressed: () => Navigator.pop(context, 'Cancel'),
        //     child: const Text('Cancel'),
        //   ),
        //   TextButton(
        //     onPressed: () => Navigator.pop(context, 'OK'),
        //     child: const Text('OK'),
        //   ),
        // ],
      ),
    );
  }
}
