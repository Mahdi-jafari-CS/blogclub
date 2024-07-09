import 'package:blogclub/carousel/carousel_slider.dart';
import 'package:blogclub/data.dart';
import 'package:blogclub/gen/assets.gen.dart';
import 'package:blogclub/gen/fonts.gen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // static const defaultFontFamily = 'Avenir';

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xff0D253C);
    const secondarTextyColor = Color(0xff2D4379);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 53, 51, 51),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.avenir)))),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
              headlineMedium: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: primaryTextColor),
              titleMedium: TextStyle(
                  fontSize: 24,
                  color: primaryTextColor,
                  fontFamily: FontFamily.avenir,
                  fontWeight: FontWeight.w700),
              titleSmall: TextStyle(
                  fontSize: 12,
                  color: primaryTextColor,
                  fontFamily: FontFamily.avenir,
                  fontWeight: FontWeight.w400),
              bodyLarge: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 18,
                color: secondarTextyColor,
                fontFamily: FontFamily.avenir,
              ),
              bodySmall: TextStyle(
                  fontSize: 10,
                  color: Color(0xff7B8B82),
                  fontFamily: FontFamily.avenir,
                  fontWeight: FontWeight.w700),
              titleLarge: TextStyle(
                  fontFamily: FontFamily.avenir,
                  color: primaryTextColor,
                  fontWeight: FontWeight.bold))),
      home: Stack(children: [
        const Positioned.fill(
          child: HomeScreen(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _BottomNavigation(),
        )
      ]),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final stories = AppDatabase.stories;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello, Janatan!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                   Assets.img.icons.notification.image(width: 32, height:32)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 16),
                child: Text(
                  "Explore Today's",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              _StoryList(stories: stories),
              const SizedBox(height: 25),
              const _CategoryList(),
              const SizedBox(
                height: 32,
              ),
              const _PostList(),
              const SizedBox(
                height: 68,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categories = AppDatabase.categories;
    return CarouselSlider.builder(
        itemCount: categories.length,
        itemBuilder: (context, index, realindex) {
          return _CategoryItem(
            category: categories[realindex],
            left: realindex == 0 ? 32 : 8,
            right: realindex == categories.length - 1 ? 32 : 8,
          );
        },
        options: CarouselOptions(
            scrollPhysics: const BouncingScrollPhysics(),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.7,
            aspectRatio: 1.2,
            initialPage: 0,
            disableCenter: true,
            enableInfiniteScroll: false));
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final double left;
  final double right;
  const _CategoryItem({
    super.key,
    required this.category,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          Positioned.fill(
              bottom: 24,
              top: 100,
              left: 65,
              right: 65,
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 20, color: Color.fromARGB(15, 202, 166, 9))
                ]),
              )),
          Positioned.fill(
            // left: left,
            // right: right,
            child: Container(
              // ignore: sort_child_properties_last
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    'assets/img/posts/large/${category.imageFileName}',
                    fit: BoxFit.cover,
                  )),
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [Color(0xff0d253c), Colors.transparent])),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
          Positioned(
              bottom: 48,
              left: 48,
              child: Text(
                category.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(color: Colors.white),
              ))
        ],
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    super.key,
    required this.stories,
  });

  final List<StoryData> stories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: stories.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        itemBuilder: (context, index) {
          final story = stories[index];
          return _Story(story: story);
        },
      ),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    super.key,
    required this.story,
  });

  final StoryData story;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 2, 4, 0),
      child: Column(
        children: [
          Stack(children: [
            story.isViewed ? _profileImageViewed() : _profileImageNormal(),
            Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/img/icons/${story.iconFileName}',
                  width: 24,
                  height: 24,
                )),
          ]),
          const SizedBox(
            height: 4,
          ),
          Text(story.name),
        ],
      ),
    );
  }

  Container _profileImageNormal() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
            Color.fromARGB(255, 8, 44, 224),
            Color.fromARGB(255, 20, 157, 181)
          ])),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22)),
        padding: const EdgeInsets.all(5),
        child: _profileImage(),
      ),
    );
  }

  Widget _profileImageViewed() {
    return SizedBox(
      width: 68,
      height: 68,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 2,
        radius: const Radius.circular(24),
        color: const Color(0xff7888B2),
        dashPattern: const [8, 3],
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: _profileImage(),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Image.asset(
        'assets/img/stories/${story.imageFileName}',
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList({super.key});
  @override
  Widget build(BuildContext context) {
    final Posts = AppDatabase.posts;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 32, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Latest News",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'More',
                  style: TextStyle(color: Color(0xff376aed)),
                ))
          ],
        ),
      ),
      ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: Posts.length,
          itemExtent: 141,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final post = Posts[index];
            return _Post(post: post);
          })
    ]);
  }
}

class _Post extends StatelessWidget {
  const _Post({
    super.key,
    required this.post,
  });

  final PostData post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/img/posts/small/${post.imageFileName}',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.caption,
                    style: const TextStyle(
                        fontFamily: FontFamily.avenir,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xff376AEd)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    post.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        CupertinoIcons.hand_thumbsup,
                        size: 16,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        post.likes,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        CupertinoIcons.clock,
                        size: 16,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        post.time,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          size: 16,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          post.isBookmarked
                              ? CupertinoIcons.bookmark_fill
                              : CupertinoIcons.bookmark,
                        ),
                      ))
                    ],
                  )
                ]),
          ))
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Stack(
        children: [
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                height: 65,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color(0xff9b487).withOpacity(0.3),
                    blurRadius: 20,
                  )
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    BottomNavigationItem(
                        title: 'Home',
                        iconFileName: 'Home.png',
                        activeIconFileName: 'Home.png'),
                    BottomNavigationItem(
                        title: 'Articles',
                        iconFileName: 'Articles.png',
                        activeIconFileName: 'Articles.png'),
                    SizedBox(
                      width: 8,
                    ),
                    BottomNavigationItem(
                        title: 'Search',
                        iconFileName: 'Search.png',
                        activeIconFileName: 'Search.png'),
                    BottomNavigationItem(
                        title: 'Menu',
                        iconFileName: 'Menu.png',
                        activeIconFileName: 'Menu.png'),
                        
                  ],
                ),
              )),
          Center(
            child: Container(
              width: 65,
              height: 85,
              alignment: Alignment.topCenter,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
                    borderRadius: BorderRadius.circular(32.5),
                    color: Color(0xff376AED)),
                child: Image.asset('assets/img/icons/plus.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  final String title;
  final String iconFileName;
  final String activeIconFileName;

  const BottomNavigationItem({
    Key? key,
    required this.title,
    required this.iconFileName,
    required this.activeIconFileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/img/icons/$iconFileName'),
        SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
