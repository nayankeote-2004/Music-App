import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final Widget? searchBar;
  final double statusBarHeight;
  final Widget? accountIcon; 

  const BannerCard({
    Key? key,
    this.searchBar,
    this.statusBarHeight = 0,
    this.accountIcon, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20 + statusBarHeight, 20, 20),
      decoration: BoxDecoration(
        color: Colors.pink[800],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                if (searchBar != null) Expanded(child: searchBar!),
                if (searchBar != null && accountIcon != null)
                  const SizedBox(width: 12), 
                if (accountIcon != null) accountIcon!,
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: searchBar != null ? 80 : 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Claim your',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    'Free Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair Display',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'for custom Music Production',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pink[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.8,
              child: Container(
                width: screenWidth * 0.25, 
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/vincyl.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          
          Positioned(
            right: -40,
            bottom: -15,
            child: Container(
              width: screenWidth * 0.3, 
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/piano.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
