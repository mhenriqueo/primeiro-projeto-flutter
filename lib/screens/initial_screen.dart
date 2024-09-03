import 'package:flutter/material.dart';
import 'package:primeiro_projeto/data/task_dao.dart';
// import 'package:primeiro_projeto/data/task_inherited.dart';
import 'package:primeiro_projeto/screens/form_screen.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  // double globalProgress = 0.0;

  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  // void updateGlobalProgress() {
  //   double totalProgress = 0.0;
  //
  //   for (var task in TaskInherited.of(context).taskList) {
  //     if (task.difficulty > 0) {
  //       double taskProgress = (task.level / 10) * task.difficulty;
  //       totalProgress += taskProgress;
  //     }
  //   }
  //
  //   setState(() {
  //     widget.globalProgress = totalProgress;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: Container(),
        actions: [IconButton(onPressed: (){setState((){});}, icon: const Icon(Icons.refresh))],
        title: const Text('Tarefas'),
        // leading: const Icon(Icons.checklist),
        // title: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const SizedBox(child: Text('Tarefas')),
        //     Row(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.all(3),
        //           child: SizedBox(
        //             width: 120,
        //             child: LinearProgressIndicator(
        //               color: Colors.white,
        //               value: widget.globalProgress / 50,
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(12),
        //           child: Text(
        //             'Nível: ${widget.globalProgress.toStringAsFixed(2)}',
        //             style: const TextStyle(color: Colors.white, fontSize: 16),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(12),
        //           child: Container(
        //             height: 20,
        //             width: 20,
        //             decoration: const BoxDecoration(
        //               shape: BoxShape.circle,
        //               color: Colors.blue,
        //             ),
        //             child: ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 primary: Colors.blue,
        //                 shape: const CircleBorder(),
        //                 padding: EdgeInsets.zero,
        //               ),
        //               onPressed: updateGlobalProgress,
        //               child: const Icon(
        //                 Icons.refresh_outlined,
        //                 color: Colors.white,
        //                 size: 20,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot){
            List<Task>? items = snapshot.data;
            switch(snapshot.connectionState){

              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
                    ],
                  ),
                );
                break;

              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
                    ],
                  ),
                );
                break;

              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
                    ],
                  ),
                );
                break;

              case ConnectionState.done:
                if(snapshot.hasData && items != null){
                  if(items.isNotEmpty){
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index){
                          final Task tarefa = items[index];
                          return tarefa;
                        }
                    );
                  }
                  return Center(
                    child: Column(
                      children: const [
                        Icon(Icons.error_outline, size: 128),
                        Text('Não há nenhuma Tarefa', style: TextStyle(fontSize: 32),),
                      ],
                    ),
                  );
                }
                return const Text(' Erro ao carregar as tarefas! ');
                break;
            }
            return const Text('Erro desconhecido!');

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context),
            ),
          ).then((value) => setState((){
            print('Recarregando a tela!');
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}