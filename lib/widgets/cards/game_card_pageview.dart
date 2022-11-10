import 'package:appcentflutterassignment/core/constants/app_constants.dart';
import 'package:appcentflutterassignment/core/extensions/theme_extension.dart';
import 'package:appcentflutterassignment/models/game_model.dart';
import 'package:appcentflutterassignment/views/gamedetails/game_details_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GameCardForPageView extends StatelessWidget {
  GameModel? gameModel;
  GameCardForPageView({super.key, required this.gameModel});

  @override
  Widget build(BuildContext context) {
    if (gameModel == null) return const SizedBox();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GameDetailsView(
              gameID: gameModel?.id,
            ),
          ),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: gameModel?.backgroundImage ??
                AppConstants.instance.imageNotFoundUrl,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Text(
              gameModel?.name ?? "-",
              style: context.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 2)
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
