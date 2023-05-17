# riverpod_training
FireStoreを用いてタスク追加をするだけのサンプルです。
研修で使用します。


# 構成
<pre>
.
├── lib
│   ├── config(設定周り)
│   │   ├── firebase(firebase関連の設定)
│   │   │   ├── firebase_options.dart
│   │   │   ├── firebase_provider.dart
│   │   │   └── firebase_provider.g.dart
│   │   └── utils(色やkey、enumなど)
│   │       ├── enum
│   │       │   └── router_enum.dart
│   │       └── keys
│   │           └── firebase_key.dart
│   ├── data_models(データモデル)
│   │   ├── task
│   │   │   ├── task.dart
│   │   │   ├── task.freezed.dart
│   │   │   └── task.g.dart
│   │   └── timestamp_converter.dart
│   ├── main.dart
│   ├── repo（firestore利用箇所）
│   │   ├── tasks_repository.dart
│   │   └── tasks_repository.g.dart
│   ├── routing(go_router定義)
│   │   ├── app_router.dart
│   │   └── app_router.g.dart
│   └── view(UI部分)
│       ├── new_task_page.dart
│       └── tasks_page.dart
├── pubspec.lock
├── pubspec.yaml
└── web
    ├── favicon.png
    ├── icons
    │   ├── Icon-192.png
    │   ├── Icon-512.png
    │   ├── Icon-maskable-192.png
    │   └── Icon-maskable-512.png
    ├── index.html
    └── manifest.json
</pre>


# Provider graph

Generated by https://github.com/rrousselGit/riverpod/tree/master/packages/riverpod_graph

```mermaid
flowchart TB
  subgraph Arrows
    direction LR
    start1[ ] -..->|read| stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    start2[ ] --->|listen| stop2[ ]
    style start2 height:0px;
    style stop2 height:0px; 
    start3[ ] ===>|watch| stop3[ ]
    style start3 height:0px;
    style stop3 height:0px; 
  end

  subgraph Type
    direction TB
    ConsumerWidget((widget));
    Provider[[provider]];
  end
  MyApp((MyApp));
  goRouterProvider ==> MyApp;
  TasksScreen((TasksScreen));
  tasksStreamProvider ==> TasksScreen;
  NewTaskScreen((NewTaskScreen));
  taskRepoProvider -.-> NewTaskScreen;
  goRouterProvider[[goRouterProvider]];
  tasksStreamProvider[[tasksStreamProvider]];
  taskRepoProvider -.-> tasksStreamProvider;
  taskRepoProvider[[taskRepoProvider]];
  userFirestoreProvider ==> taskRepoProvider;
  userFirestoreProvider[[userFirestoreProvider]];
  firestoreProvider -.-> userFirestoreProvider;
  firestoreProvider[[firestoreProvider]];
```