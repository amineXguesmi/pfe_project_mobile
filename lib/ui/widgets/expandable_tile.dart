import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../presentation/presentation.dart';

class ExpandableTile extends StatefulWidget {
  final String title;
  final IconData leadingIcon;
  final Widget expandedBody;

  const ExpandableTile({
    this.leadingIcon = FontAwesomeIcons.infoCircle,
    required this.title,
    required this.expandedBody,
    super.key,
  });

  @override
  ExpandableTileState createState() => ExpandableTileState();
}

class ExpandableTileState extends State<ExpandableTile> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title, style: TextStyles.buttonMedium()),
          leading: widget.leadingIcon == FontAwesomeIcons.infoCircle
              ? null
              : Icon(
                  widget.leadingIcon,
                  color: Colors.black.withOpacity(0.8),
                  size: Dimensions.xmd,
                ),
          trailing: Icon(
            _isExpanded ? FontAwesomeIcons.arrowDown : Icons.arrow_forward_ios,
            color: Colors.grey,
            size: Dimensions.sm,
          ),
          onTap: _toggleExpand,
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: widget.expandedBody,
          ),
      ],
    );
  }
}
