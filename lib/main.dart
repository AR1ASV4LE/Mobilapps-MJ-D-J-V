import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    Center(
        key: ValueKey(0),
        child: Text("Inicio",
            style: TextStyle(color: Colors.white, fontSize: 24))),
    Center(
        key: ValueKey(1),
        child: Text("Buscar",
            style: TextStyle(color: Colors.white, fontSize: 24))),
    Center(
        key: ValueKey(2),
        child: Text("Perfil",
            style: TextStyle(color: Colors.white, fontSize: 24))),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget buildNavItem(IconData icon, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.white70,
          size: 26,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 FONDO (usa imagen si quieres)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A4C93), Color(0xFF4A2F6B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🔹 CONTENIDO CON ANIMACIÓN (ARREGLADO)
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
              child: screens[selectedIndex],
            ),
          ),

          // 🔻 MENÚ INFERIOR
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                // FIX: Replaced deprecated `withOpacity` with `withAlpha`
                // `Colors.white` (0xFFFFFFFF) with 0.15 opacity means
                // alpha component: (255 * 0.15).round() = 38
                color: Colors.white.withAlpha(38),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavItem(Icons.home_outlined, 0),
                  buildNavItem(Icons.search, 1),
                  buildNavItem(Icons.person_outline, 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
