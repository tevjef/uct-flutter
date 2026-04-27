import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

class SubjectTitleItem extends Item {
  final Function callback;
  final Subject subject;

  bool hasLabel;

  SubjectTitleItem(this.subject, this.callback, {this.hasLabel = true})
      : super(subject.topicName);

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double>? animation]) {
    const insets = EdgeInsets.symmetric(
        horizontal: 32.0, vertical: Dimens.spacingStandard);

    return InkWell(
      onTap: () {
        callback(context, subject);
      },
      child: Container(
          padding: insets,
          child: Text(
            AppLocalizations.of(context)!
                .headerMessage(subject.name, subject.number),
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.bold),
          )),
    );
  }

  @override
  String getFastScrollLabel() {
    return subject.name.substring(0, 1).toUpperCase();
  }
}
