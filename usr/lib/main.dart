import 'package:flutter/material.dart';

void main() {
  runApp(const SwitzerlandTripApp());
}

class SwitzerlandTripApp extends StatelessWidget {
  const SwitzerlandTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viaggio in Svizzera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  late final List<Widget> _slides;

  @override
  void initState() {
    super.initState();
    _slides = [
      _buildSlide(
        title: 'Guida Turistica:\nLa nostra Svizzera',
        subtitle: 'Un viaggio indimenticabile con i miei cugini',
        imageUrl: 'https://images.unsplash.com/photo-1530122037265-a5f1f91d3b99?auto=format&fit=crop&q=80&w=1600',
        content: 'Benvenuti alla nostra presentazione! Abbiamo preparato questa guida per raccontarvi le meraviglie della Svizzera.',
        isCover: true,
      ),
      _buildSlide(
        title: 'Informazioni di base',
        subtitle: 'Cosa sapere sulla Svizzera',
        imageUrl: 'https://images.unsplash.com/photo-1527668752968-14dc70a27c95?auto=format&fit=crop&q=80&w=1600',
        content: '🌍 Posizione: Europa Centrale\n👥 Popolazione: ~8.7 milioni\n⛰️ Perché ci piace: Le montagne sono spettacolari, l\'aria è pulita e ci siamo divertiti tantissimo insieme!',
      ),
      _buildSlide(
        title: 'I Luoghi Visitati',
        subtitle: 'Tra laghi e montagne',
        imageUrl: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?auto=format&fit=crop&q=80&w=1600',
        content: 'Abbiamo esplorato paesaggi mozzafiato, dai laghi cristallini come il Lago di Ginevra, alle cime altissime come il Monte Cervino (Matterhorn).',
      ),
      _buildSlide(
        title: 'Cosa Abbiamo Mangiato',
        subtitle: 'I sapori svizzeri',
        imageUrl: 'https://images.unsplash.com/photo-1589122757599-73d1ceee42c8?auto=format&fit=crop&q=80&w=1600',
        content: '🧀 La famosa Fonduta di formaggio\n🥔 La deliziosa Raclette\n🍫 E ovviamente, tantissimo cioccolato svizzero!',
      ),
      _buildSlide(
        title: 'Grazie per l\'attenzione!',
        subtitle: 'Speriamo vi sia piaciuta',
        imageUrl: 'https://images.unsplash.com/photo-1519865885898-a54a6f2c7eea?auto=format&fit=crop&q=80&w=1600',
        content: 'È stato un viaggio bellissimo da condividere in famiglia. Fateci sapere se volete visitare la Svizzera!',
        isCover: true,
      ),
    ];
  }

  Widget _buildSlide({
    required String title,
    required String subtitle,
    required String imageUrl,
    required String content,
    bool isCover = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: isCover ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: isCover ? TextAlign.center : TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                textAlign: isCover ? TextAlign.center : TextAlign.left,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 48),
              if (!isCover)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Text(
                    content,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.5,
                    ),
                  ),
                )
              else
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1.5,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _slides,
          ),
          Positioned(
            bottom: 32,
            left: 32,
            right: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage > 0
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 32),
                        onPressed: _previousPage,
                      )
                    : const SizedBox(width: 48),
                Row(
                  children: List.generate(
                    _slides.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 12,
                      width: _currentPage == index ? 24 : 12,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.red : Colors.white54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                _currentPage < _slides.length - 1
                    ? IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 32),
                        onPressed: _nextPage,
                      )
                    : const SizedBox(width: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
