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

  // 🔵 SEMANA 1: pantallas separadas
  final List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.white70,
          size: isSelected ? 30 : 24, // 🔵 SEMANA 2 animación de tamaño
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 SEMANA 0 (tu base)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A4C93), Color(0xFF4A2F6B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🔵 SEMANA 2: animación mejorada
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.3, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: screens[selectedIndex],
          ),

          // 🔻 MENÚ
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
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

// =====================================================
// 🔵 SEMANA 3: HOME CON CONTENIDO REAL
// =====================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey(0),
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 40),
        const Text(
          "Inicio",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),

        const SizedBox(height: 20),

        // Tarjetas
        _card("Noticias", Icons.article),
        _card("Eventos", Icons.event),
        _card("Recomendados", Icons.star),
      ],
    );
  }

  Widget _card(String text, IconData icon) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

// =====================================================
// 🔵 SEMANA 3: SEARCH CON INPUT + LISTA
// =====================================================

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  final List<String> items = [
    "Flutter",
    "Dart",
    "API",
    "Aplicaciones",
    "Programación",
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = items
        .where((e) => e.toLowerCase().contains(query))
        .toList();

    return Padding(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),

          TextField(
            onChanged: (value) {
              setState(() {
                query = value.toLowerCase();
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Buscar...",
              hintStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white24,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Lista dinámica
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filtered[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// 🔵 SEMANA 4: PERFIL CON INTERACCIÓN
// =====================================================

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int likes = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey(2),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white24,
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 10),

        const Text(
          "Usuario",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),

        const SizedBox(height: 20),

        // 🔵 interacción
        Text("Likes: $likes", style: const TextStyle(color: Colors.white)),

        ElevatedButton(
          onPressed: () {
            setState(() {
              likes++;
            });
          },
          child: const Text("Me gusta"),
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Editando perfil...")));
          },
          child: const Text("Editar perfil"),
        ),
      ],
    );
  }
}
