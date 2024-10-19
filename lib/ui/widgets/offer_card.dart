import 'package:flutter/material.dart';
import 'package:mobile_app/ui/presentation/extensions/list_spacing.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:mobile_app/ui/views/home/offer_screen.dart';
import 'package:provider/provider.dart';

import '../../core/models/offer.dart';
import '../../core/viewmodels/offer_view_model.dart';
import '../presentation/presentation.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({super.key, required this.offer});

  final Offer offer;

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OfferScreen(offer: widget.offer),
        ),
      ),
      child: Padding(
        padding: Paddings.horizontalSm,
        child: Container(
          padding: Paddings.allMd,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(widget.offer.imageUrl ?? ''),
                  ),
                  xxxsSpacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.offer.title.length > 20
                            ? '${widget.offer.title.substring(0, 20)}...'
                            : widget.offer.title,
                        style: TextStyles.body1Medium(color: Colors.black),
                      ),
                      Text(
                        widget.offer.companyId == 1 ? 'Google' : 'Facebook',
                        style: TextStyles.calloutMedium(color: Colors.black),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        widget.offer.isFavorite
                            ? context.read<OfferViewModel>().removeFavoriteOffer(widget.offer)
                            : context.read<OfferViewModel>().addFavoriteOffer(widget.offer);
                        setState(() {});
                      },
                      child: Icon(
                        widget.offer.isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                        color: widget.offer.isFavorite ? Colors.red : Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
              smSpacer(),
              SizedBox(
                width: context.width * 0.7,
                height: context.height * 0.05,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.offer.categories
                        .map(
                          (e) => Text(e.title, style: TextStyles.footnoteBold(color: Colors.black)),
                        )
                        .toList()
                        .withSpacing(xxxsSpacer()),
                  ),
                ),
              ),
              xsSpacer(),
              Text(
                widget.offer.description,
                style: TextStyles.footnoteMedium(
                  color: Colors.black,
                ),
              ),
              xsSpacer(),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  xxsSpacer(),
                  Text(
                    widget.offer.location.length > 15
                        ? '${widget.offer.location.substring(0, 15)}...'
                        : widget.offer.location,
                    style: TextStyles.calloutMedium(color: Colors.black),
                  ),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$${widget.offer.salary} ',
                          style: TextStyles.body1Bold(color: Colors.black),
                        ),
                        TextSpan(
                          text: '/year',
                          style: TextStyles.calloutMedium(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
