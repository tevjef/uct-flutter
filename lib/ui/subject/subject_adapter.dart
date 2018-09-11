import '../../data/lib.dart';
import '../widgets/lib.dart';

class SubjectTitleItem extends Item {
  Function callback;
  Subject subject;

  SubjectTitleItem(this.subject, this.callback) : super(subject.topicName);

  @override
  int itemType() => 1;

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double> animation]) {
    final insets = new EdgeInsets.symmetric(
        horizontal: 32.0, vertical: Dimens.spacingStandard);

    return new InkWell(
      onTap: () {
        callback(context, subject);
      },
      child: new Container(
          padding: insets,
          child: new Text(
            "${subject.name} (${subject.number})",
            style: Styles.caption,
          )),
    );
  }
}
