
import 'package:flutter/material.dart';

class ZikrDetailPage extends StatefulWidget {
  final Map<String, dynamic> zikr;
  const ZikrDetailPage({super.key, required this.zikr});

  @override
  State<ZikrDetailPage> createState() => _ZikrDetailPageState();
}

class _ZikrDetailPageState extends State<ZikrDetailPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    final int repeat = widget.zikr['repeat'];
    return Scaffold(
      appBar: AppBar(title: const Text("Zikr"), actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text("Repeat: $repeat",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              widget.zikr['arabic'],
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 30),
            _buildItem("Transliteration", widget.zikr['transliteration']),
            _buildItem("Translation", widget.zikr['translation']),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  Text("Tasbeeh", style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Text("$_count / $repeat",
                      style:
                          const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Slider(
                    value: _count.toDouble(),
                    max: repeat.toDouble(),
                    onChanged: (value) {
                      setState(() => _count = value.toInt());
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_count < repeat) {
                        setState(() => _count++);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Tap",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
      ],
    );
  }
}
