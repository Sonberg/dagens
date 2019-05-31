import 'package:flutter/material.dart';
import 'package:app_dagens/models/tag.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:app_dagens/store/reducer.dart';
import 'package:app_dagens/store/actions.dart';

class TagView extends StatelessWidget {
  final Tag value;
  final bool selected;
  final Function onSelect;

  TagView({this.value, this.selected, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppStore, Function>(
      converter: (store) => (String id) => store.dispatch(
            new ToggleTag(tagId: id),
          ),
      builder: (BuildContext bc, Function toggle) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.only(right: 12, left: 12, top: 0, bottom: 0),
            decoration: BoxDecoration(
              color: this.selected ? Colors.black87 : Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            margin: EdgeInsets.all(4.0),
            child: Center(
              child: Text(
                this.value.value,
                style: TextStyle(
                    color: this.selected ? Colors.white : Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          onTap: () => toggle(this.value.id),
        );
      },
    );
  }
}
