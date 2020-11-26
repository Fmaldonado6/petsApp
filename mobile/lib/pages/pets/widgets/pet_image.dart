import 'package:flutter/material.dart';
import 'package:mobile/provider/feedback_position_provider.dart';
import 'package:provider/provider.dart';

class PetImage extends StatelessWidget {
  final url;
  final bool focus;
  const PetImage({Key key, this.url, this.focus = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedbackPositionProvider>(context);
    final swipingDirection = provider.swipingDirection;
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: new DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
          ),
          width: size.width * .95,
          height: size.height * .65,
        ),
        focus ? buildBadge(swipingDirection) : Container()
      ],
    );
  }

  Widget buildBadge(SwipingDirection swipingDirection) {
    final isSwipingRight = swipingDirection == SwipingDirection.right;
    final color = isSwipingRight ? Colors.green : Colors.pink;
    final angle = isSwipingRight ? -0.5 : 0.5;

    if (swipingDirection == SwipingDirection.none) {
      return Container();
    } else {
      return Positioned(
        top: 20,
        right: isSwipingRight ? null : 20,
        left: isSwipingRight ? 20 : null,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(
              isSwipingRight ? Icons.thumb_up : Icons.thumb_down,
              color: isSwipingRight ? Colors.green : Colors.red,
            ),
          ),
        ),
      );
    }
  }
}

class PetImageDraggable extends StatelessWidget {
  final url;
  final Function onDragEnd;
  final bool focus;

  const PetImageDraggable(
      {Key key, this.url, this.onDragEnd, this.focus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      onDragCompleted: () {},
      child: PetImage(
        url: url,
      ),
      feedback: PetImage(
        focus: focus,
        url: url,
      ),
      childWhenDragging: Container(),
      onDragEnd: onDragEnd,
    );
  }
}
