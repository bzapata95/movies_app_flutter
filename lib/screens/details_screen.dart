import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get argument
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
                [_PosterAndTitle(), _Overview(), _Overview(), _Overview()]),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black26,
          child: Text('Movie.title', style: TextStyle(fontSize: 16)),
        ),
        background: const FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage('https://via.placeholder.com/500x300'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com/200x300'),
                height: 150,
              )),
          const SizedBox(width: 20),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('movie.title',
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
            Text('movie.originalTitle',
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
            Row(children: [
              Icon(Icons.star_outline, size: 15, color: Colors.grey),
              SizedBox(width: 5),
              Text('movie.voteAverage', style: textTheme.caption)
            ])
          ])
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Ea elit laboris eiusmod laborum id consequat in aute labore velit officia. Amet reprehenderit proident nostrud velit. Ex magna minim occaecat ea do quis nulla. Ex duis exercitation amet est ullamco anim consectetur mollit commodo pariatur cupidatat commodo cillum aliquip. Aliquip velit nostrud consectetur non dolore voluptate in fugiat aute sit anim enim magna tempor. Aute non proident dolor dolore laborum consectetur veniam culpa mollit laboris. Enim consequat deserunt irure nisi dolore. Fugiat sit irure aliqua et velit sint non officia qui. Non tempor exercitation mollit proident eiusmod velit excepteur deserunt deserunt duis Lorem pariatur. Occaecat quis in enim commodo in aute amet mollit laboris ad fugiat id. Commodo sunt magna ullamco voluptate laborum id.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
