import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/core/skee_ui/skee_palette.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/skee_ui/skee_container.dart';
import '../../../widgets/flutter_widgets.dart';
import '../../../widgets/skee_button.dart';
import '../../domain/models/fitness_news_model.dart';

class NewsCardWidget extends StatelessWidget {
  final List<FitnessNewsModel> fitnessNews;
  const NewsCardWidget({
    Key? key,
    required this.fitnessNews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 25, crossAxisSpacing: 20),
        itemCount: fitnessNews.length,
        itemBuilder: (context, index) {
          final news = fitnessNews[index];

          return SkeeContainer(
            color: SkeePalette.cardColor,
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Image.network(
                        'https://thumbs.dreamstime.com/b/fitness-news-chalkboard-background-concept-77312565.jpg',
                        height: 120,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 6),
                        child: SkeeText.title(
                          news.title,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontsize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 65,
                  right: 4,
                  child: SkeeButton.filled(
                    'Go to webiste',
                    height: 22,
                    width: 105,
                    fontsize: 12,
                    ontap: () {
                      Modular.to.push(
                        MaterialPageRoute(
                          builder: (context) => CustomWebView(url: news.url),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomWebView extends StatelessWidget {
  final String url;
  const CustomWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade700,
          elevation: 0,
        ),
        body: WebView(
          initialUrl: url,
        ));
  }
}
