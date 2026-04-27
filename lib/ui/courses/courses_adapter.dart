import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

class CourseTitleItem extends Item {
  Course course;
  Function callback;

  CourseTitleItem(this.course, this.callback) : super(course.topicName);

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double>? animation]) {
    int total = course.sections.length;
    int open = 0;
    for (var section in course.sections) {
      if (section.status == AppLocalizations.of(context)!.openStatus) {
        open++;
      }
    }

    double percent = 0.0;
    if (total != 0) {
      percent = open.toDouble() / total.toDouble();
    }

    double rightBorderRadius = 6.0;
    double leftBorderRadius = 6.0;

    if (percent < 1 && percent > 0.0) {
      rightBorderRadius = 0.0;
      leftBorderRadius = 0.0;
    }

    return Container(
      margin: const EdgeInsets.only(
          left: Dimens.spacingStandard,
          right: Dimens.spacingStandard,
          top: 6.0,
          bottom: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!
                          .headerMessage(course.name, course.number),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .numOfOpen(open.toString(), total.toString()),
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ])),
          //https://github.com/flutter/flutter/issues/3782#issuecomment-309079424
          Positioned.fill(
              child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  color: Colors.transparent,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        Container(
                          height: 4.0,
                          alignment: Alignment.bottomRight,
                          child: FractionallySizedBox(
                            alignment: Alignment.bottomRight,
                            widthFactor: 1 - percent,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        Radius.circular(leftBorderRadius),
                                    bottomRight: const Radius.circular(6.0)),
                              ),
                              padding: const EdgeInsets.all(4.0),
                            ),
                          ),
                        ),
                        Container(
                          height: 4.0,
                          alignment: Alignment.bottomLeft,
                          child: FractionallySizedBox(
                            alignment: Alignment.bottomLeft,
                            widthFactor: percent,
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: const Radius.circular(6.0),
                                    bottomRight:
                                        Radius.circular(rightBorderRadius)),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            callback(context, course);
                          },
                        )
                      ])))
        ],
      ),
    );
  }
}
