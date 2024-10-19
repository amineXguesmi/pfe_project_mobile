import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:mobile_app/ui/views/entreprise/update_company_bottom_sheet.dart';
import 'package:mobile_app/ui/views/notif_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/viewmodels/componay_view_model.dart';
import '../../../core/viewmodels/offer_view_model.dart';
import '../../presentation/theme/dimensions.dart';
import '../../presentation/theme/text_styles.dart';
import '../../widgets/media_querry.dart';
import '../../widgets/offer_widget.dart';
import 'create_offer_bottom_sheet.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  late ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Mediaquery media = Mediaquery(mediaHeight: deviceHeight, mediaWidth: deviceWidth);

    return Consumer<OfferViewModel>(builder: (context, offerProvider, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    xlSpacer(),
                    _appBar(),
                    SizedBox(
                      width: context.width,
                      height: context.height * 0.85,
                      child: FadingEdgeScrollView.fromSingleChildScrollView(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: offerProvider.offers
                                .map((e) => OfferWidget(
                                      offer: e,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: media.getHeight(20),
              right: media.getwidht(15),
              child: SpeedDial(
                overlayOpacity: 0.2,
                spaceBetweenChildren: 15,
                animatedIcon: AnimatedIcons.menu_close,
                backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
                curve: Curves.slowMiddle,
                useRotationAnimation: true,
                children: [
                  SpeedDialChild(
                    child: Icon(
                      Icons.add,
                      color: Colors.purple,
                      size: media.getwidht(25),
                    ),
                    label: "Create new Offer",
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const CreateOfferBottomSheet(),
                      );
                    },
                    labelBackgroundColor: const Color.fromRGBO(143, 148, 251, 0.6),
                    labelStyle: TextStyle(
                      fontSize: media.getwidht(16),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Courgette',
                      color: Colors.purple,
                    ),
                  ),
                  SpeedDialChild(
                    onTap: () {
                      offerProvider.orderOfferBySalary();
                    },
                    child: Icon(
                      Icons.lightbulb,
                      color: Colors.purple,
                      size: media.getwidht(25),
                    ),
                    label: "Order Offer",
                    labelBackgroundColor: const Color.fromRGBO(143, 148, 251, 0.6),
                    labelStyle: TextStyle(
                      fontSize: media.getwidht(16),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Courgette',
                      color: Colors.purple,
                    ),
                  ),
                  SpeedDialChild(
                    onTap: () {
                      offerProvider.getCompanyOffers();
                    },
                    child: Icon(
                      FontAwesomeIcons.arrowRotateRight,
                      color: Colors.purple,
                      size: media.getwidht(25),
                    ),
                    label: "All Offers",
                    labelBackgroundColor: const Color.fromRGBO(143, 148, 251, 0.6),
                    labelStyle: TextStyle(
                      fontSize: media.getwidht(16),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Courgette',
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _appBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm, vertical: Dimensions.xxs),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  enableDrag: true,
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => UpdateCompanyBottomSheet(),
                );
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/avatar_3.jpg'),
              ),
            ),
            xsSpacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi Welcome 🙌',
                  style: TextStyles.calloutRegular(color: Colors.grey.withOpacity(0.8)),
                ),
                Text(
                  context.read<CompanyViewModel>().company!.companyName ?? 'Dustin Bates',
                  style: TextStyles.buttonBold(color: Colors.black),
                ),
              ],
            ),
            const Spacer(),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotificationScreen()),
                    );
                  },
                  icon: const Icon(Icons.notifications_none),
                  iconSize: Dimensions.xmd,
                ),
                Positioned(
                  top: 16,
                  left: 24,
                  child: Container(
                    width: context.width * 0.024,
                    height: context.width * 0.024,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF85358),
                      borderRadius: BorderRadius.circular(Dimensions.md),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
