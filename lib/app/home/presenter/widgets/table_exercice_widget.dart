// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../widgets/flutter_widgets.dart';

class TableExerciceWidget extends StatefulWidget {
  bool isAddSet;
  TableExerciceWidget({
    Key? key,
    this.isAddSet = false,
  }) : super(key: key);

  @override
  State<TableExerciceWidget> createState() => _TableExerciceWidgetState();
}

class _TableExerciceWidgetState extends State<TableExerciceWidget> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      dividerThickness: 0,
      horizontalMargin: 0,
      columnSpacing: 30,
      columns: [
        if (!widget.isAddSet)
          DataColumn(
            label: WEText.custom(
              'Set',
              fontWeight: FontWeight.w800,
            ),
          ),
        if (!widget.isAddSet)
          DataColumn(
            label: WEText.custom(
              'Previus',
              fontWeight: FontWeight.w800,
            ),
          ),
        if (!widget.isAddSet)
          DataColumn(
            label: WEText.custom(
              '+kg',
              fontWeight: FontWeight.w800,
            ),
          ),
        if (!widget.isAddSet)
          DataColumn(
            label: WEText.custom(
              'Reps',
              fontWeight: FontWeight.w800,
            ),
          ),
        if (!widget.isAddSet)
          DataColumn(
            label: WEText.custom(
              'Done',
              fontWeight: FontWeight.w800,
            ),
          ),
      ],
      rows: [
        DataRow(
          cells: [
            _dataCell('1'),
            _dataCell('1'),
            _dataCell('1'),
            _dataCell('1'),
            _dataCell('1'),
          ],
        )
      ],
    );
  }

  DataCell _dataCell(String label) {
    return DataCell(Container(
      height: 40,
      padding: const EdgeInsets.only(left: 8, top: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: '1',
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
