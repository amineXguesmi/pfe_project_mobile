import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/ui/presentation/extensions/list_spacing.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:mobile_app/ui/views/home/offer_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/models/offer.dart';
import '../../../core/viewmodels/offer_view_model.dart';
import '../../presentation/presentation.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _currentIndex = 0;
  late final List _searchItems = [
    'All Jobs',
    'Full Time',
    'Part Time',
    'Remote',
    'Internship',
    'Freelance',
    'Temporary',
    'Contract',
    'Commission',
    'Volunteer',
  ];
  Map<String, List<Offer>> _filteredOffers = {};
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _initializeOffers();
  }

  void _initializeOffers() {
    _filteredOffers = context.read<OfferViewModel>().favoriteOffers;
  }

  void _search(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      final favoriteOffers = context.read<OfferViewModel>().favoriteOffers;

      final filteredEntries = favoriteOffers.entries.where((entry) {
        final offers = entry.value;
        final filteredOffers = offers.where((offer) {
          return offer.title.toLowerCase().contains(_searchQuery) ||
              offer.companyId.toString().toLowerCase().contains(_searchQuery) ||
              offer.location.toLowerCase().contains(_searchQuery);
        }).toList();
        return filteredOffers.isNotEmpty;
      }).map((entry) {
        return MapEntry(
            entry.key,
            entry.value.where((offer) {
              return offer.title.toLowerCase().contains(_searchQuery) ||
                  offer.companyId.toString().toLowerCase().contains(_searchQuery) ||
                  offer.location.toLowerCase().contains(_searchQuery);
            }).toList());
      });

      _filteredOffers = Map<String, List<Offer>>.fromEntries(filteredEntries);
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      if (category == 'All Jobs') {
        _filteredOffers = context.read<OfferViewModel>().favoriteOffers;
      } else {
        final favoriteOffers = context.read<OfferViewModel>().favoriteOffers;
        final Map<String, List<Offer>> filteredMap = {};

        favoriteOffers.forEach((date, offers) {
          final filteredOffers = offers.where((offer) {
            return offer.categories.contains(category);
          }).toList();
          if (filteredOffers.isNotEmpty) {
            filteredMap[date] = filteredOffers;
          }
        });

        _filteredOffers = filteredMap;
      }
    });
  }

  Widget _appBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm, vertical: Dimensions.xxs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'My Favorite',
              style: TextStyles.title2Bold(),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      );

  Widget _searchWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
        child: TextField(
          onChanged: (value) => _search(value),
          decoration: InputDecoration(
            hintText: 'Search ',
            hintStyle: TextStyles.body0Semibold(color: Colors.grey.withOpacity(0.8)),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: Icon(FontAwesomeIcons.sliders, size: Dimensions.md, color: Colors.black.withOpacity(0.8)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.sm),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.sm),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.sm),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: Paddings.verticalXxxs,
          ),
          style: TextStyles.calloutRegular(color: Colors.black),
        ),
      );

  Widget _searchItemsWidget() => Container(
        height: context.height * 0.05,
        padding: Paddings.horizontalSm,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
                _filterByCategory(_searchItems[index]);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: Paddings.allXxxs,
                    decoration: BoxDecoration(
                      color: _currentIndex != index ? Colors.white : const Color(0xFF5E569B).withOpacity(0.8),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Dimensions.sm),
                      ),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                    child: Text(
                      _searchItems[index],
                      style: TextStyles.calloutBold(
                        color: _currentIndex != index ? Colors.black.withOpacity(0.5) : Colors.white,
                      ),
                    ),
                  ),
                  xxxsSpacer(),
                ],
              ),
            );
          },
        ),
      );

  Widget _favoriteOffersWidget() {
    return Column(
      children: _filteredOffers.keys.map((date) {
        return Column(
          children: [
            _favoriteOfferInDay(date: date),
            mdSpacer(),
          ],
        );
      }).toList(),
    );
  }

  Widget _favoriteOfferInDay({required String date}) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat("dd MMMM, yyyy", "fr").format(parsedDate);
    return Padding(
      padding: Paddings.horizontalSm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formattedDate, style: TextStyles.body1Medium(color: Colors.grey.shade500)),
          mdSpacer(),
          Column(
            children: _filteredOffers[date]!
                .map((offer) {
                  return _favoriteOfferCard(offer);
                })
                .toList()
                .withSpacing(
                  mdSpacer(),
                ),
          ),
        ],
      ),
    );
  }

  Widget _favoriteOfferCard(Offer offer) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OfferScreen(
                    offer: offer,
                  )),
        ),
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
                    backgroundImage: AssetImage(offer.imageUrl ?? ''),
                  ),
                  xxsSpacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.title.length > 20 ? '${offer.title.substring(0, 20)}...' : offer.title,
                        style: TextStyles.body1Medium(),
                      ),
                      Text(
                        offer.companyId.toString(),
                        style: TextStyles.calloutMedium(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<OfferViewModel>().removeFavoriteOffer(offer);
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 28.0,
                      ),
                    ),
                  ),
                ],
              ),
              smSpacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.grey, size: Dimensions.md),
                  xxxsSpacer(),
                  Text(
                    offer.location,
                    style: TextStyles.calloutMedium(color: Colors.grey),
                  ),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$${offer.salary ~/ 12} ',
                          style: TextStyles.body1Bold(color: Colors.black),
                        ),
                        TextSpan(
                          text: '/Month',
                          style: TextStyles.calloutMedium(color: Colors.grey.shade300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _body() => Container(
        color: Colors.white,
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              xxlSpacer(),
              _appBar(),
              xlSpacer(),
              _searchWidget(),
              smSpacer(),
              _searchItemsWidget(),
              xmdSpacer(),
              _favoriteOffersWidget(),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }
}
