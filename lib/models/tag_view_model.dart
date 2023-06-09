class TagViewModel {
  String? tag;

  TagViewModel({this.tag});

  TagViewModel.fromJson(final Map<String, dynamic> json) {
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag'] = tag;
    return data;
  }


  List<TagViewModel> tagListFromJson(final List<dynamic> dynamicList){
    final List<TagViewModel> p = [];
    for (final element in dynamicList) {
      p.add(TagViewModel.fromJson(element));
    }
    return p;
  }

}