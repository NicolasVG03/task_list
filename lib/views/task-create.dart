import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  // <input id="task" name="task" ... == GlbalKey
  var formKey = GlobalKey<FormState>();
  String? name = '';
  DateTime? dataSelecionada;
  final prioridades = ['Alta', 'Média', 'Baixa'];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void saveTask(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      firestore.collection('tasks').add({
        'name': name,
        'finished': false,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                //campo para selecionar data com o datepicker
                Container(
                  padding: EdgeInsets.all(20),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2030),
                    onDateChanged: (data) {
                      dataSelecionada = data;
                    },
                  ),
                ),

                //campo select para escolher a categoria
                Container(
                  padding: EdgeInsets.all(20),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: "Prioridade",
                      border: OutlineInputBorder(),
                    ),
                    items: prioridades.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 200,
                    decoration: InputDecoration(
                      labelText: 'Nova tarefa',
                    ),
                    onSaved: (value) => name = value!,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira uma tarefa';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 200,
                  child: ElevatedButton(
                    onPressed: () => saveTask(context),
                    child: const Text('Salvar'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
