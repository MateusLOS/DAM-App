import 'package:flutter/material.dart';
import 'change_password_confirm_page.dart'; // Importando a tela de troca de senha concluída

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar icon
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 30),

            // Code input field
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Digite o código',
                filled: true,
                fillColor: Color(0xFFF4F4F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 15),

            // "Não recebeu o código?" link
            TextButton(
              onPressed: () {
                // Implement logic to resend the code here
              },
              child: Text(
                'Não recebeu o código? clique aqui',
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(height: 20),

            // Trocar senha button
            ElevatedButton(
              onPressed: () {
                // Redireciona para a tela de confirmação de senha
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordConfirmPage()),
                );
              },
              child: Text('Trocar senha', style: TextStyle(fontSize: 16, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Color(0xFFE35128), // Cor do botão (laranja)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
