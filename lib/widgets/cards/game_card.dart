import 'package:appcentflutterassignment/core/constants/app_constants.dart';
import 'package:appcentflutterassignment/core/extensions/padding_extensions.dart';
import 'package:appcentflutterassignment/models/game_model.dart';
import 'package:appcentflutterassignment/views/gamedetails/game_details_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  GameModel? gameModel;
  GameCard({super.key, required this.gameModel});

  @override
  Widget build(BuildContext context) {
    if (gameModel == null) {
      return const SizedBox();
    } else {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GameDetailsView(
                gameID: gameModel!.id,
              ),
            ),
          );
        },
        child: Padding(
          padding: context.paddingExtraLow,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: gameModel!.backgroundImage ??
                    AppConstants.instance.imageNotFoundUrl,
                width: 150,
                height: 80,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.none,
              ),
              Expanded(
                child: Padding(
                  padding: context.paddingLowLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gameModel!.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.orangeAccent,
                          ),
                          Text(gameModel!.rating.toString()),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              gameModel!.released.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
