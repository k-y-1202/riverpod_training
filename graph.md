Analyzing /Users/yoshidamitsuteru/workspace/3.yoshida-test/riverpod_training ...
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
  authRepoProvider -.-> TasksScreen;
<<<<<<< HEAD
  AuthPage((AuthPage));
  authRepoProvider -.-> AuthPage;
  authRepoProvider -.-> AuthPage;
  authRepoProvider -.-> AuthPage;
  userRepoProvider -.-> AuthPage;
=======
  LoginScreen((LoginScreen));
  authRepoProvider -.-> LoginScreen;
  authRepoProvider -.-> LoginScreen;
  authRepoProvider -.-> LoginScreen;
  userRepoProvider -.-> LoginScreen;
>>>>>>> main
  NewTaskScreen((NewTaskScreen));
  taskRepoProvider -.-> NewTaskScreen;
  goRouterProvider[[goRouterProvider]];
  authRepoProvider ==> goRouterProvider;
<<<<<<< HEAD
  authRepoProvider -.-> goRouterProvider;
  authRepoProvider[[authRepoProvider]];
  firebaseAuthInstanceProvider -.-> authRepoProvider;
  tasksStreamProvider[[tasksStreamProvider]];
  taskRepoProvider -.-> tasksStreamProvider;
  userRepoProvider[[userRepoProvider]];
  firebaseFireStoreInstanceProvider -.-> userRepoProvider;
  taskRepoProvider[[taskRepoProvider]];
  firebaseFireStoreInstanceProvider -.-> taskRepoProvider;
  firebaseFireStoreInstanceProvider[[firebaseFireStoreInstanceProvider]];
  firebaseAuthInstanceProvider[[firebaseAuthInstanceProvider]];
=======
  tasksStreamProvider[[tasksStreamProvider]];
  taskRepoProvider ==> tasksStreamProvider;
  authRepoProvider[[authRepoProvider]];
  firebaseAuthProvider -.-> authRepoProvider;
  userRepoProvider[[userRepoProvider]];
  firestoreProvider -.-> userRepoProvider;
  taskRepoProvider[[taskRepoProvider]];
  firestoreProvider -.-> taskRepoProvider;
  firestoreProvider[[firestoreProvider]];
  authStateChangesProvider[[authStateChangesProvider]];
  authRepoProvider ==> authStateChangesProvider;
  firebaseAuthProvider[[firebaseAuthProvider]];
>>>>>>> main
