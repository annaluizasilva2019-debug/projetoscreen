
import 'dart:async';
import 'package:flutter/material.dart';

const Color pink = Color(0xFFF18BB8);
const Color lightPink = Color(0xFFFFC3DC);
const Color background = Color(0xFF0B090B);
const Color surface = Color(0xFF171217);
const Color muted = Color(0xFFC9B9C2);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AnnaLuizaApp());
}

class AnnaLuizaApp extends StatelessWidget {
  const AnnaLuizaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anna Luiza Lash Design',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: pink,
          brightness: Brightness.dark,
          surface: background,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scale = Tween<double>(
      begin: 0.86,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MainNavigation(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -90,
            right: -100,
            child: _GlowCircle(size: 280),
          ),
          Positioned(
            bottom: -120,
            left: -110,
            child: _GlowCircle(size: 300),
          ),
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 290,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Realce o que te faz única',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: lightPink,
                          fontSize: 19,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Icon(
                        Icons.favorite_border,
                        color: pink,
                        size: 23,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 38,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: pink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;

  const _GlowCircle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            pink.withOpacity(0.15),
            pink.withOpacity(0),
          ],
        ),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    ServicesScreen(),
    AppointmentsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 72,
        backgroundColor: const Color(0xFF100D10),
        indicatorColor: pink.withOpacity(0.17),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: pink),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.spa_outlined),
            selectedIcon: Icon(Icons.spa, color: pink),
            label: 'Serviços',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month, color: pink),
            label: 'Agenda',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: pink),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFF392331),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 142,
                      height: 66,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showMessage(
                          context,
                          'Você não tem novas notificações.',
                        );
                      },
                      icon: const Icon(
                        Icons.notifications_none,
                        color: pink,
                        size: 27,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                const Text(
                  'Olá, linda! ♡',
                  style: TextStyle(
                    color: pink,
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Que bom ter você por aqui!\nCuidar de você também é uma forma de amor-próprio.',
                  style: TextStyle(
                    color: muted,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 23),
                _BookingCard(
                  onTap: () {
                    showMessage(
                      context,
                      'Entre em contato para consultar os horários disponíveis.',
                    );
                  },
                ),
                const SizedBox(height: 27),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Nossos serviços',
                      style: _sectionStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        final nav = context
                            .findAncestorStateOfType<_MainNavigationState>();
                        nav?.setState(() {
                          nav.selectedIndex = 1;
                        });
                      },
                      child: const Text(
                        'Ver todos →',
                        style: TextStyle(color: pink),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _ServiceCard(
                        icon: Icons.remove_red_eye_outlined,
                        title: 'Alongamento\nde cílios',
                        onTap: () {
                          showMessage(
                            context,
                            'Confira as opções de alongamento na aba Serviços.',
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: _ServiceCard(
                        icon: Icons.autorenew,
                        title: 'Manutenção',
                        onTap: () {
                          showMessage(
                            context,
                            'A manutenção ajuda a manter seus cílios sempre bonitos.',
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: _ServiceCard(
                        icon: Icons.water_drop_outlined,
                        title: 'Remoção',
                        onTap: () {
                          showMessage(
                            context,
                            'A remoção deve ser feita com cuidado profissional.',
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const _BeautyBanner(),
                const SizedBox(height: 27),
                const Text(
                  'Acesso rápido',
                  style: _sectionStyle,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _QuickAction(
                      icon: Icons.calendar_month_outlined,
                      label: 'Agendar',
                      onTap: () {
                        showMessage(
                          context,
                          'Entre em contato para agendar seu horário.',
                        );
                      },
                    ),
                    _QuickAction(
                      icon: Icons.chat_bubble_outline,
                      label: 'WhatsApp',
                      onTap: () {
                        showMessage(
                          context,
                          'Adicione o link do WhatsApp do estúdio aqui.',
                        );
                      },
                    ),
                    _QuickAction(
                      icon: Icons.camera_alt_outlined,
                      label: 'Instagram',
                      onTap: () {
                        showMessage(
                          context,
                          'Adicione o Instagram do estúdio aqui.',
                        );
                      },
                    ),
                    _QuickAction(
                      icon: Icons.location_on_outlined,
                      label: 'Localização',
                      onTap: () {
                        showMessage(
                          context,
                          'Adicione o endereço do estúdio aqui.',
                        );
                      },
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

const TextStyle _sectionStyle = TextStyle(
  color: Colors.white,
  fontSize: 19,
  fontWeight: FontWeight.w600,
);

class _BookingCard extends StatelessWidget {
  final VoidCallback onTap;

  const _BookingCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [lightPink, pink],
        ),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: background,
              size: 27,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Próximo atendimento',
                  style: TextStyle(
                    color: background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Nenhum agendamento',
                  style: TextStyle(
                    color: Color(0xFF49313D),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: onTap,
            style: FilledButton.styleFrom(
              backgroundColor: background,
              foregroundColor: lightPink,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
            ),
            child: const Text('Agendar →'),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 132,
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: surface,
          border: Border.all(
            color: pink.withOpacity(0.65),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: pink,
              size: 29,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: lightPink,
                fontSize: 12,
                height: 1.3,
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: pink,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _BeautyBanner extends StatelessWidget {
  const _BeautyBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF593344),
            Color(0xFF21151D),
            Color(0xFF120F12),
          ],
        ),
        border: Border.all(
          color: pink.withOpacity(0.4),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: pink,
                  size: 25,
                ),
                SizedBox(height: 12),
                Text(
                  'Cílios que valorizam o seu olhar ♡',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Mais autoestima, todos os dias.',
                  style: TextStyle(
                    color: lightPink,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.remove_red_eye,
            color: pink,
            size: 66,
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                color: const Color(0xFF38212D),
                shape: BoxShape.circle,
                border: Border.all(
                  color: pink.withOpacity(0.3),
                ),
              ),
              child: Icon(
                icon,
                color: pink,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: lightPink,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      ('Volume Fox', 'Efeito alongado e marcante', 'R\$ 120,00'),
      ('Brasileiro', 'Volume e definição', 'R\$ 100,00'),
      ('Egípcio', 'Leveza e delicadeza', 'R\$ 100,00'),
      ('Volume Luxo', 'Olhar mais preenchido', 'R\$ 120,00'),
      ('Manutenção', 'Conservação do alongamento', 'R\$ 80,00'),
      ('Remoção', 'Retirada profissional', 'R\$ 35,00'),
    ];

    return _PageLayout(
      title: 'Nossos serviços',
      subtitle: 'Escolha o cuidado que combina com você.',
      child: Column(
        children: services.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: pink.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF38212D),
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: pink,
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.$1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.$2,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  item.$3,
                  style: const TextStyle(
                    color: pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PageLayout(
      title: 'Agendamentos',
      subtitle: 'Seus próximos momentos de autocuidado.',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: pink.withOpacity(0.3),
          ),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: pink,
              size: 54,
            ),
            SizedBox(height: 15),
            Text(
              'Nenhum agendamento por enquanto',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Entre em contato com o estúdio para reservar seu horário.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: muted,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PageLayout(
      title: 'Seu perfil',
      subtitle: 'Informações do Anna Luiza Lash Design.',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: pink.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 220,
            ),
            const SizedBox(height: 18),
            const Text(
              'Anna Luiza Lash Design',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Realce o que te faz única.',
              style: TextStyle(color: muted),
            ),
            const SizedBox(height: 22),
            const Divider(
              color: Color(0xFF49313D),
            ),
            const ListTile(
              leading: Icon(
                Icons.favorite_border,
                color: pink,
              ),
              title: Text(
                'Beleza com cuidado e carinho',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                color: pink,
              ),
              title: Text(
                'Endereço a definir',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _PageLayout({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: pink,
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              subtitle,
              style: const TextStyle(
                color: muted,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 25),
            child,
          ],
        ),
      ),
    );
  }
}
