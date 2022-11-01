import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../skee_ui/skee_container.dart';
import '../../../widgets/flutter_widgets.dart';
import '../../../widgets/we_buttons.dart';
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
            color: Colors.white,
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Column(
                  children: [
                    Image.network(
                      'https://thumbs.dreamstime.com/b/fitness-news-chalkboard-background-concept-77312565.jpg',
                      height: 120,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WEText.title(
                          news.title,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontsize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 50,
                  right: 4,
                  child: WeButtons.filled(
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
        appBar: AppBar(),
        body: WebView(
          initialUrl: url,
        ));
  }
}
