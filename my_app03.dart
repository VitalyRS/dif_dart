import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recambio+',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class Category {
  final IconData icon;
  final String name;

  const Category(this.icon, this.name);
}

class Product {
  final String imagePath;
  final String name;
  final String price;

  const Product(this.imagePath, this.name, this.price);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MainScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recambio+')),
      body: _screens[_selectedIndex],
      drawer: _buildDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Меню навигации',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Главная'),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Настройки'),
            onTap: () {
              Navigator.pop(context);
              // Переход на экран настроек
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('О приложении'),
            onTap: () {
              Navigator.pop(context);
              // Переход на экран "О приложении"
            },
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Category> categories = [
    Category(Icons.directions_car, 'Автозапчасти'),
    Category(Icons.motorcycle, 'Мототехника'),
    Category(Icons.build, 'Инструменты'),
    Category(Icons.electric_bolt, 'Электроника'),
    Category(Icons.car_repair, 'Кузовные детали'),
    Category(Icons.local_gas_station, 'Топливная система'),
    Category(Icons.settings, 'Фильтры'),
    Category(Icons.electric_car, 'Аккумуляторы'),
    Category(Icons.tire_repair, 'Шины и диски'),
    Category(Icons.car_crash, 'Тормозная система'),
    Category(Icons.air, 'Кондиционеры'),
    Category(Icons.lightbulb, 'Освещение'),
    Category(Icons.volume_up, 'Аудиосистемы'),
    Category(Icons.security, 'Безопасность'),
  ];

  static const List<Product> products = [
    Product('assets/products/engine_oil.jpg', 'Моторное масло', '2990 ₽'),
    Product('assets/products/brake_pads.jpg', 'Тормозные колодки', '4490 ₽'),
    Product('assets/products/battery.jpg', 'Аккумулятор', '7990 ₽'),
    Product('assets/products/filter.jpg', 'Воздушный фильтр', '1290 ₽'),
    Product('assets/products/tire.jpg', 'Летняя резина', '5990 ₽'),
    Product('assets/products/lamp.jpg', 'Лампа ближнего света', '990 ₽'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CategoryScreen(category: category),
                          ),
                        ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(category.icon, size: 40),
                        const SizedBox(height: 4),
                        Text(category.name),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Поиск запчастей...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap:
                  () => showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text('Специальное предложение'),
                          content: const Text(
                            'Скидка 50% на все масла до конца месяца!',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Закрыть'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Действие при нажатии на кнопку акции
                              },
                              child: const Text('Перейти'),
                            ),
                          ],
                        ),
                  ),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/promo_banner.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'АКЦИЯ: Скидки до 50%',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(product: product),
                        ),
                      ),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.asset(
                              product.imagePath,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                product.price,
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              product.imagePath,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 200),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Описание товара:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Высококачественная запчасть для вашего автомобиля. '
                    'Гарантия 1 год. Оригинальный производитель.',
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Добавить в корзину'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Экран поиска', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          IconButton(
            icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
            iconSize: 64,
            color: _isLiked ? Colors.red : Colors.grey,
            onPressed: () {
              setState(() => _isLiked = !_isLiked);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(_isLiked ? 'Лайк!' : 'Дизлайк :(')),
              );
            },
          ),
          Text(_isLiked ? 'Вам нравится!' : 'Нажмите на сердце'),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showLoginModal = false;

  void _openLoginModal() {
    setState(() {
      _showLoginModal = true;
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Регистрация', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Зарегистрироваться'),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _showLoginModal = false;
                  });
                },
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        _showLoginModal = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Экран профиля', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openLoginModal,
            child: const Text('Логин'),
          ),
        ],
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final Category category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 100),
            const SizedBox(height: 20),
            Text(
              'Экран категории: ${category.name}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
