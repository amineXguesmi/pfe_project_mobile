import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/ui/views/entreprise/applies_screen.dart';
import 'package:provider/provider.dart';

import '../../core/models/offer.dart';
import '../../core/viewmodels/offer_view_model.dart';
import '../views/entreprise/create_offer_bottom_sheet.dart';
import 'media_querry.dart';

class OfferWidget extends StatefulWidget {
  final Offer offer;

  const OfferWidget({
    super.key,
    required this.offer,
  });

  @override
  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Mediaquery media = Mediaquery(mediaHeight: deviceHeight, mediaWidth: deviceWidth);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppliesScreen(
                      offerId: int.parse(widget.offer.id),
                    )));
      },
      child: Padding(
        padding: EdgeInsets.all(media.getwidht(16)),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.4,
            children: [
              SlidableAction(
                onPressed: (context) async {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: true,
                    isDismissible: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => CreateOfferBottomSheet(
                      offer: widget.offer,
                      isForUpdate: true,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(10),
                backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
                icon: Icons.change_circle,
                foregroundColor: Colors.white,
                label: "Change Offer",
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.4,
            children: [
              SlidableAction(
                onPressed: (context) => {
                  Provider.of<OfferViewModel>(context, listen: false).deleteOffer(widget.offer),
                },
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.red,
                icon: FontAwesomeIcons.trash,
                foregroundColor: Colors.white,
                label: "Delete Offer",
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 2),
                blurRadius: 20.0,
                offset: Offset(0, 10),
              )
            ]),
            child: Padding(
              padding: EdgeInsets.all(media.getwidht(8)),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      widget.offer.title,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: media.getwidht(18), fontFamily: 'Courgette'),
                    ),
                  ),
                  const Divider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "offer Description",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: media.getwidht(13), fontFamily: 'Courgette'),
                        ),
                        SizedBox(
                          width: media.getwidht(15),
                        ),
                        Text(widget.offer.description),
                      ],
                    ),
                  ),
                  const Divider(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "offer location",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: media.getwidht(13), fontFamily: 'Courgette'),
                            ),
                            Text(widget.offer.location),
                            Text(
                              "offer company",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: media.getwidht(13), fontFamily: 'Courgette'),
                            ),
                            Text(widget.offer.companyId.toString()),
                            Text(
                              "offer category",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: media.getwidht(13), fontFamily: 'Courgette'),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.offer.categories
                                  .map((e) => Text(
                                        '${e.title} , ',
                                      ))
                                  .toList(),
                            ),
                            Text(
                              "offer skills",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: media.getwidht(13), fontFamily: 'Courgette'),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.offer.skills
                                  .map((e) => Text(
                                        '${e.skill} , ',
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                        widget.offer.useFile
                            ? Image.file(
                                widget.offer.file!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                widget.offer.imageUrl ?? 'assets/app_logo.jpeg',
                                height: 100,
                                width: 100,
                              ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        "Salary",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: media.getwidht(13), fontFamily: 'Courgette'),
                      ),
                      SizedBox(
                        width: media.getwidht(110),
                      ),
                      Text(widget.offer.salary.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
