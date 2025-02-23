import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/favorites/presentation/bloc/favoritesCubit.dart';
import 'package:tura_app/features/favorites/presentation/widgets/favoriteCard.dart';

class Favorites_page extends StatelessWidget {
  const Favorites_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<Favoritescubit, favoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is FavoriteError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('${state.message}'),
              ),
            );
          }
          if (state is FavoriteSuccess) {
            return ListView.builder(
              itemCount: state.response.length,
              itemBuilder: (context, index) => Favoritecard(
                favotite: state.response[index]!,
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
