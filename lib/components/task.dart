import 'dart:math';
import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/difficulty.dart';

class Task extends StatefulWidget {  // StatefulWidget: Um Widget que permite que a tela seja redesenhada caso algum estado dessa tela mude, por exemplo uma variavel e etc.
  final String nameTask;
  final String image;
  final int difficulty;
  int level = 0;          // Novo parametro

  Task(this.nameTask, this.image, this.difficulty, {super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  Color containerColor = Colors.blue;

  bool assetOrNetwork(){

    // (widget.image.contains('http')) ? false : true;

    if(widget.image.contains('http')){
      return false;
    }
    return true;
  }

  void updateLevel() {
    setState(() {
      if (widget.level >= widget.difficulty * 10) {
        widget.level = 0;
        containerColor = getRandomColor();
      } else {
        widget.level++;
      }
    });
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),    // Para deixar um espaçamento sobre cada cartão
      child: Stack(                          // Para fazer uma pilha de cartões
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: containerColor,
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork()
                          ? Image.asset(
                            widget.image,
                            fit: BoxFit.cover,   //Pra deixar a imagem maior
                            )
                          : Image.network(
                            widget.image,
                            fit: BoxFit.cover,   //Pra deixar a imagem maior
                          ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.nameTask,
                            style: const TextStyle(
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis, // Parametro para impedir nomes muito grandes
                            ),
                          ),
                        ),
                        Difficulty(difficultyLevel: widget.difficulty),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: SizedBox(                                 // Colocado um SizedBox para o ElevatedButton, para poder definir uma tamanho máximo para ele (poderia ser um Container)
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                          onPressed: updateLevel,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(
                                Icons.arrow_drop_up,
                              ),
                              Text('UP', style: TextStyle(fontSize: 12),),
                            ],
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(                         // Colocado um SizedBox para o LinearProgressIndicator, para poder definir uma tamanho máximo para ele (poderia ser um Container)
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.difficulty > 0) ? (widget.level / widget.difficulty) / 10 : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Nível: ${widget.level}',
                      style: const TextStyle(color: Colors.white,fontSize: 16,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}