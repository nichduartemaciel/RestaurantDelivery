import 'package:aula1/banco/usuarioDAO.dart';
import 'package:aula1/restaurante.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'banco/restauranteDAO.dart';

class telaHome extends StatefulWidget {
  @override
  State createState() => telaHomeState();
}

class telaHomeState extends State<telaHome> {
  final nome = UsuarioDAO.usuarioLogado.nome;
  List restaurantes = [];

  Future carregarRestaurantes() async {
    final lista = await RestauranteDAO.listarTodos();
    setState(() {
      restaurantes = lista;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarRestaurantes();
  }

  // Exemplo de filtros de culinária com bandeira
  final List<Map<String, String>> filtrosCulinaria = [
    {'nome': 'Mexicana', 'bandeira': 'assets/mexico.png'},
    {'nome': 'Árabe', 'bandeira': 'assets/arabe.png'},
    {'nome': 'Francesa', 'bandeira': 'assets/franca.png'},
    {'nome': 'Portuguesa', 'bandeira': 'assets/portugal.png'},
  ];

  int sliderAtual = 0; // Para marcador do banner

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),


        title: Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'o seu delivery',
                  style: TextStyle(
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  '24 horas',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),

        actions: [

          IconButton(

            icon: Icon(Icons.notifications_none_outlined, color: Colors.black),
            onPressed: () {},


          ),
          Text('Dinner Restaurant', style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // [SLIDER DE BANNER - ATIVIDADE 2]
            SizedBox(
              width: double.infinity,
              height: 150,
              child: ImagensSlider(
                onSlideChange: (index) {
                  setState(() {
                    sliderAtual = index;
                  });
                },
                sliderAtual: sliderAtual,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (idx) => Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: sliderAtual == idx ? Colors.blue : Colors.grey,
                ),
              )),
            ),
            SizedBox(height: 12),
            // [FILTROS COM BANDEIRAS - ATIVIDADE 1]
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filtrosCulinaria.length,
                itemBuilder: (context, index) {
                  final filtro = filtrosCulinaria[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            filtro['bandeira']!,
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(filtro['nome']!, style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 18),
            // [LISTA HORIZONTAL DOS RESTAURANTES (hierarquia pedida)]
            Text('Restaurantes disponíveis:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 95,
              child: ListView.builder(
                itemCount: restaurantes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final r = restaurantes[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.restaurant_menu, size: 40),
                        SizedBox(height: 4),
                        Text(r.nome ?? 'Sem nome'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_sharp), label: 'carrinho'),
        BottomNavigationBarItem(icon: Icon(Icons.savings_rounded), label: 'histórico'),
        BottomNavigationBarItem(icon: Icon(Icons.delivery_dining), label: 'pedidos')
      ]),
    );
  }
}

// [ATIVIDADE 2] SLIDER DE BANNERS - EXEMPLO SIMPLES
class ImagensSlider extends StatefulWidget {
  final void Function(int)? onSlideChange;
  final int sliderAtual;
  const ImagensSlider({this.onSlideChange, required this.sliderAtual, Key? key}) : super(key: key);
  @override
  State<ImagensSlider> createState() => _ImagensSliderState();
}

class _ImagensSliderState extends State<ImagensSlider> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    final banners = [
      'assets/banner1.png',
      'assets/banner2.png',
      'assets/banner3.png',
    ];
    return PageView.builder(
      controller: _controller,
      onPageChanged: (index) {
        if (widget.onSlideChange != null) widget.onSlideChange!(index);
      },
      itemCount: banners.length,
      itemBuilder: (context, idx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              banners[idx],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
