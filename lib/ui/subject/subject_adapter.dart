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
    final insets = new EdgeInsets.symmetric(
        horizontal: 32.0, vertical: Dimens.spacingStandard);

    return new InkWell(
      onTap: () {
        callback(context, subject);
      },
      child: new Container(
          padding: insets,
          child: new Text(
            AppLocalizations.of(context)!.headerMessage(subject.name, subject.number),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
          )),
    );
  }

  @override
  String getFastScrollLabel() {
    return subject.name.substring(0, 1).toUpperCase();
  }
}
