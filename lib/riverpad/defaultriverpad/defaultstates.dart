


class DefaultStates {
  final bool showpassord;
  final bool checkbox;

  DefaultStates({this.checkbox = false,this.showpassord = false});
  DefaultStates copyWith({
    bool?showpassord,
     bool?checkbox
}){
    return DefaultStates(
      showpassord: showpassord??this.showpassord,
      checkbox: checkbox??this.checkbox
    );
  }
}