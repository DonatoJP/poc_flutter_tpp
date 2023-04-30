import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/app_state.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade200),
    );
    final style =
        theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onPrimary);
    var appState = context.watch<MyAppState>();
    var favourites = appState.favorites;

    var favouritesText = favourites
        .map((e) => Text(
              e.toString(),
              style: style,
            ))
        .toList();

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: favouritesText.isEmpty
          ? [
              Text(
                "No favourites yet!",
                style: style,
              )
            ]
          : [
              Text(
                "Favourites",
                style: theme.textTheme.headlineMedium!
                    .copyWith(color: theme.colorScheme.onSecondary),
              ),
              SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: theme.colorScheme.primary,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: favouritesText.length,
                      prototypeItem: ListTile(
                        title: favouritesText.first,
                      ),
                      itemBuilder: (context, index) => ListTile(
                        title: favouritesText[index],
                      ),
                    ),
                  ),
                ),
              )
            ],
    ));
  }
}
