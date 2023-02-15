import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class TmpVideoView {
  final int id;
  TmpVideoView(this.id);
  bool inited = false;
  void init() {
    if (inited) return;
    inited = true;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('vid-${id}', (int viewId) {
      final element = VideoElement();
      element.id = 'video-${id}';
      element.style.border = 'none';
      element.autoplay = true;
      element.src = 'https://www.w3schools.com/html/mov_bbb.mp4';
      return element;
    });
  }

  Widget getWidget() {
    init();
    return HtmlElementView(
      viewType: 'vid-$id',
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video Bug',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Scaffold(
          appBar: AppBar(
            title: const Text("Video bug"),
          ),
          body: Center(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: 20,
                  itemBuilder: (ctx, index) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                      child: Stack(
                        children: [
                          TmpVideoView(index).getWidget(),
                          Center(child: Text('Video $index')),
                        ],
                      ),
                    );
                  })),
        ),
      ),
    );
  }
}
