
import 'package:aula1/exemplo.dart';
import 'package:aula1/home.dart';
import 'package:flutter/material.dart';

import 'banco/usuarioDAO.dart';

class telaLogin extends StatefulWidget{
  @override
  State<telaLogin> createState() => telaLoginState();

}

class telaLoginState extends State<telaLogin>{
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Ifood'),
        backgroundColor: Colors.yellow
      ),

      body: Container(
        width: double.infinity,
        color: Colors.blueAccent,
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset('assets/restaurante.png'),

            SizedBox(
              height: 60,
            ),

            SizedBox(
              width: 350,
              child: TextFormField(
                controller: usuarioController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Usuer',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),

                ),

              ),
            ),

            SizedBox(
              height: 30,
            ),

            SizedBox(
              width: 350,
              child: TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            ElevatedButton(onPressed: () async{
              final sucesso = await UsuarioDAO.autenticar(usuarioController.text, senhaController.text);
              if(sucesso){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => telaHome())
                );

              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Usuario e/ou senha inválido.',
                                    style: TextStyle(color: Colors.black, fontSize: 18)),
                      backgroundColor: Colors.yellowAccent,



                  )
                );
              }
            }, child: Text('Entrar'))

          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Cadastrar')
      ]),

    );
  }

}