import 'dart:core';

import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  final String title;
  final String description;
  final String goToText;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.description,
    required this.goToText,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool _isTapped = false;

  void _handleTapDown(_) {
    setState(() {
      _isTapped = true;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isTapped = false;
    });
  }

  void _handleTapUp(_) {
    setState(() {
      _isTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color titleAndIconColor = _isTapped ? Colors.brown : Colors.blue;
    final Color goToTextColor = Colors.brown.shade300;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _handleTapDown,
      onTapCancel: _handleTapCancel,
      onTapUp: _handleTapUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(20),
        height: size.height * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color.fromARGB(255, 241, 240, 240),
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: titleAndIconColor,
                  ),
                ),
                Icon(widget.icon, color: titleAndIconColor, size: 26),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  widget.goToText,
                  style: TextStyle(
                    color: goToTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.arrow_right_alt, color: goToTextColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




class DuaCard extends StatelessWidget {
  final String title;
  final String arabic;
  final String transliteration;
  final String translation;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;

  const DuaCard({
    super.key,
    required this.title,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade50),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title + favorite icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onFavoriteToggle,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),

          /// Arabic
          const Text(
            "Arabic",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            arabic,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Scheherazade', // or any Arabic-friendly font
              height: 1.8,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 12),

          /// Transliteration
          const Text(
            "Transliteration",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            transliteration,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),

          /// Translation
          const Text(
            "Translation (EN)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            translation,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
