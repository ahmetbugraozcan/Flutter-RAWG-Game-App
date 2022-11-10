import 'package:appcentflutterassignment/core/constants/enums/lottie_enums.dart';
import 'package:appcentflutterassignment/core/extensions/media_query_extensions.dart';
import 'package:appcentflutterassignment/core/extensions/theme_extension.dart';
import 'package:appcentflutterassignment/core/utils/utils.dart';
import 'package:appcentflutterassignment/models/game_model.dart';
import 'package:appcentflutterassignment/provider/home_provider.dart';
import 'package:appcentflutterassignment/widgets/cards/game_card.dart';
import 'package:appcentflutterassignment/widgets/cards/game_card_pageview.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (context.watch<HomeProvider>().isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (context.read<HomeProvider>().allGames == null) {
                return Center(
                  child: Text(
                    context.read<HomeProvider>().errorText ??
                        "An error occurred. Please try again later.",
                    textAlign: TextAlign.center,
                  ),
                );
              }
              // eğer 3 karakter girilerek arama moduna girildiyse searchı render et idle modunda ise idle ı render et
              switch (context.watch<HomeProvider>().viewType) {
                case HomeViewState.SEARCH:
                  return buildSearchScreen(context);
                case HomeViewState.IDLE:
                  return buildIdleScreen(context);
                default:
                  return buildIdleScreen(context);
              }
            }
          },
        ),
      ),
    );
  }

  Column buildSearchScreen(BuildContext context) {
    return Column(
      children: [
        buildSearchWidget(context),
        Builder(
          builder: (context) {
            if (context.read<HomeProvider>().filteredGamesList.isEmpty) {
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Lottie.asset(
                        Utils.instance.getJSONLottiePath(LottieEnums.notfound),
                        width: context.dynamicWidth(100),
                        height: context.dynamicHeight(40),
                      ),
                    ),
                    Text(
                      "No games found!",
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                controller: context.read<HomeProvider>().scrollController,
                itemCount:
                    context.watch<HomeProvider>().filteredGamesList.length,
                itemBuilder: (context, index) {
                  GameModel? game =
                      context.watch<HomeProvider>().filteredGamesList[index];
                  return GameCard(gameModel: game);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildIdleScreen(BuildContext context) {
    return SingleChildScrollView(
      controller: context.read<HomeProvider>().scrollController,
      child: Column(
        children: [
          buildSearchWidget(context),
          buildPageView(),
          const SizedBox(height: 12),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            //itemcountu böyle vermemin sebebi ilk 3 oyunun pageviewda geri kalanının listviewda gösterilmesi için
            itemCount: context
                .watch<HomeProvider>()
                .allGames!
                .sublist(
                  3,
                  context.watch<HomeProvider>().allGames!.length,
                )
                .length,
            itemBuilder: (context, index) {
              GameModel? game = getAllGamesSublist(context)[index];
              // eğer pagination yükleniyor ise son elemanın altında loading göster
              if (index == getAllGamesSublist(context).length - 1 &&
                  context.watch<HomeProvider>().isPaginationLoading) {
                return Column(
                  children: [
                    GameCard(gameModel: game),
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              } else {
                return GameCard(gameModel: game);
              }
            },
          ),
        ],
      ),
    );
  }

// ilk üç elemanın pageviewda gösterilmesi kalanının listviewda gösterilmesi için bu listeyi oluşturdum
  List<GameModel?> getAllGamesSublist(BuildContext context) {
    return context
        .watch<HomeProvider>()
        .allGames!
        .sublist(3, context.watch<HomeProvider>().allGames!.length);
  }

  SizedBox buildPageView() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          GameModel? gameModel = context.read<HomeProvider>().allGames![index];
          return GameCardForPageView(gameModel: gameModel);
        },
      ),
    );
  }

  TextField buildSearchWidget(BuildContext context) {
    return TextField(
      controller: context.read<HomeProvider>().searchFieldController,
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        suffixIcon: InkWell(
          onTap: () {
            context.read<HomeProvider>().clearSearchField();
          },
          child: const Icon(Icons.close_rounded),
        ),
      ),
    );
  }
}
