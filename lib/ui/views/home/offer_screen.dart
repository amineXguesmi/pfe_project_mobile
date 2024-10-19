import 'package:flutter/material.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:mobile_app/ui/views/home/apply_job_sceen.dart';
import 'package:provider/provider.dart';

import '../../../core/models/offer.dart';
import '../../../core/viewmodels/offer_view_model.dart';
import '../../presentation/presentation.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key, required this.offer});

  final Offer offer;

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: context.height * 0.3,
                  width: context.width,
                  color: const Color(0xFF5E569B),
                ),
                Container(
                  height: context.height * 0.7,
                  width: context.width,
                  color: Colors.white,
                ),
              ],
            ),
            Padding(
              padding: Paddings.allXs,
              child: Column(
                children: [
                  xxxxlSpacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(context.width * 0.02),
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.3)),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.width * 0.25,
                      ),
                      const Text(
                        'Job Detail',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  xxxlSpacer(),
                  xlSpacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(widget.offer.imageUrl ?? ''),
                    ),
                  ),
                  xxxsSpacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.offer.title.length > 20
                                ? '${widget.offer.title.substring(0, 20)}...'
                                : widget.offer.title,
                            style: TextStyles.body1Medium(),
                          ),
                          Text(
                            widget.offer.companyId.toString(),
                            style: TextStyles.calloutMedium(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: widget.offer.isFavorite
                            ? () {
                                context.read<OfferViewModel>().removeFavoriteOffer(widget.offer);
                                setState(() {});
                              }
                            : () {
                                context.read<OfferViewModel>().addFavoriteOffer(widget.offer);
                                setState(() {});
                              },
                        child: Icon(
                          widget.offer.isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                          color: widget.offer.isFavorite ? Colors.red : Colors.grey.shade500,
                          size: 34,
                        ),
                      ),
                    ],
                  ),
                  mdSpacer(),
                  Container(
                    padding: Paddings.allSm,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 30,
                              color: Colors.blueAccent,
                            ),
                            const Text('Location :'),
                            xsSpacer(),
                            Text(widget.offer.location, style: const TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.timer, size: 30, color: Color(0xFF5E569B)),
                            const Text('Job Type :'),
                            xsSpacer(),
                            Expanded(
                                child: Text(widget.offer.showCategories(),
                                    style: const TextStyle(fontWeight: FontWeight.bold)))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.euro,
                              size: 30,
                              color: Colors.orange,
                            ),
                            const Text('salary :'),
                            xsSpacer(),
                            Text(
                              widget.offer.salary.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  mdSpacer(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Job Description",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  xsSpacer(),
                  Text(widget.offer.description),
                ],
              ),
            ),
            Padding(
              padding: Paddings.allXl,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ApplyJobScreen(
                                offer: widget.offer,
                              )),
                    );
                  },
                  child: Container(
                    height: context.height * 0.06,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5E569B),
                      borderRadius: BorderRadius.all(
                        Radius.circular(context.height * 0.1),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Apply for this job",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
