import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/features/task/controller/task_controller.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';
import 'package:riverpod_training/functions/show_snack_bar.dart';

import '../../../config/utils/enum/router_enum.dart';

class AddOrEditTaskPage extends HookConsumerWidget {
  const AddOrEditTaskPage({super.key, this.taskId});
  final String? taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskTitleController = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text(taskId == null ? "タスクを作成" : 'タスクを編集')),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: taskId == null
              ? addEditTaskBody(
                  taskTitleController, formKey, context, ref, null)
              : ref.watch(getTaskControllerProvider(taskId!)).when(
                  data: (Task taskData) {
                    taskTitleController.text = taskData.title;
                    return addEditTaskBody(
                        taskTitleController, formKey, context, ref, taskData);
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                  error: (error, stackTrace) {
                    return const Center(child: Text('エラーだよ'));
                  },
                ),
        ),
      ),
    );
  }

  Padding addEditTaskBody(
      TextEditingController taskTitleController,
      GlobalKey<FormState> formKey,
      BuildContext context,
      WidgetRef ref,
      Task? taskData) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          //タスクのタイトルを入れるフォーム
          TextFormField(
            controller: taskTitleController,
            validator: (value) {
              if (value == "") {
                return "必須入力項目です";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          //タスク追加ボタン
          ElevatedButton(
            onPressed: () {
              //タスクを作る処理（ロジック）はview(見た目)とは関係がないので、
              //メソッドを作成して見た目に関わるコードから分離するのが良い
              //_(アンダースコア)をつけて関数名を定義し、
              //関数にカーソルを当てた状態でcmd+.を押すとcreate methodという候補を選択
              if (!formKey.currentState!.validate()) {
                return;
              }
              if (taskId == null) {
                _createNewTask(
                  context: context,
                  ref: ref,
                  title: taskTitleController.text,
                );
              } else {
                //タスクを編集する処理
                _editTask(
                    context: context,
                    ref: ref,
                    title: taskTitleController.text,
                    taskData: taskData!);
              }
            },
            child: Text(taskId == null ? 'タスクを作成' : 'タスクを編集'),
          )
        ],
      ),
    );
  }

  void _createNewTask({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
  }) async {
    //taskデータクラスのインスタンスを作成
    //taskIdはuuidパッケージを使ってランダムなidを自動で生成
    try {
      await ref.read(taskControllerProvider.notifier).addTask(title);
      if (context.mounted) {
        context.goNamed(AppRoute.tasks.name);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void _editTask({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required Task taskData,
  }) async {
    try {
      await ref
          .read(taskControllerProvider.notifier)
          .updateTask(taskData, title);
      if (context.mounted) {
        context.goNamed(AppRoute.tasks.name);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
