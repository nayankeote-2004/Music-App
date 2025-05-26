import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/banner_card.dart';
import '../widgets/service_card.dart';
import '../widgets/search_bar.dart';
import '../providers/providers.dart';
import 'service_detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);
    final servicesAsyncValue = ref.watch(servicesStreamProvider);
    
    // Get the status bar height for internal padding
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.black,
      // No appBar, so content can extend to status bar
      body: Column(
        children: [
          // Banner card starts from the very top of the screen
          BannerCard(
            statusBarHeight: statusBarHeight,
            searchBar: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomSearchBar(),
            ),
            accountIcon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // Remaining content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Hire hand-picked Pros for popular music services',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: servicesAsyncValue.when(
                      data: (services) {
                        return ListView.builder(
                          itemCount: services.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: ServiceCard(
                                serviceItem: services[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ServiceDetailScreen(
                                        service: services[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      loading: () => ListView.builder(
                        itemCount: 5, // Show 5 placeholder items while loading
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 60,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image placeholder
                                  Container(
                                    width: 80,
                                    height: 80, // Match height for a square aspect ratio
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Content placeholders
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 18,
                                            width: 150,
                                            color: Colors.grey.shade800,
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            height: 14,
                                            width: 100,
                                            color: Colors.grey.shade800,
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            height: 12,
                                            width: 80,
                                            color: Colors.grey.shade800,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      error: (error, stack) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.pink,
                              size: 60,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Error loading services',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => ref.refresh(servicesStreamProvider),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(top: BorderSide(color: Color(0xFF222222), width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => ref.read(selectedTabProvider.notifier).state = index,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Tracks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'Projects',
            ),
          ],
        ),
      ),
    );
  }
}
