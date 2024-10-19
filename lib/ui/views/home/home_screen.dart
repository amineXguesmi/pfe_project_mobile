import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/core/models/offer.dart';
import 'package:mobile_app/core/viewmodels/offer_view_model.dart';
import 'package:mobile_app/ui/presentation/extensions/list_spacing.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:mobile_app/ui/views/notif_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/viewmodels/employee_view_model.dart';
import '../../presentation/presentation.dart';
import '../../widgets/company_card.dart';
import '../../widgets/offer_card.dart';
import '../../widgets/offer_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  String location = '';
  String keyword = '';
  List<Offer> filteredOffers = [];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    filteredOffers = context.read<OfferViewModel>().offers;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    const duration = Duration(seconds: 3);
    _timer = Timer.periodic(duration, (timer) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentScrollPosition = _scrollController.position.pixels;
        final newScrollPosition = currentScrollPosition + context.height * 0.26;

        if (newScrollPosition >= maxScrollExtent) {
          _scrollController.animateTo(
            0.0,
            duration: duration,
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            newScrollPosition,
            duration: duration,
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _applyFilter() {
    setState(() {
      filteredOffers = context.read<OfferViewModel>().offers.where((offer) {
        final matchesLocation = location.isEmpty || offer.location.startsWith(location.toUpperCase());
        final matchesKeyword =
            keyword.isEmpty || offer.categories.any((category) => category.title.startsWith(keyword.toUpperCase()));
        return matchesLocation && matchesKeyword;
      }).toList();
    });
  }

  Widget _searchWidget() => Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: context.width,
            height: context.height * 0.3,
            color: const Color(0xFF5E569B),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.height * 0.05),
            child: Container(
              width: context.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.md),
              ),
              child: Padding(
                padding: Paddings.allSm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Keyword",
                      style: TextStyles.calloutBold(color: Colors.black),
                    ),
                    xxsSpacer(),
                    TextField(
                      onChanged: (value) => keyword = value.trim(),
                      decoration: InputDecoration(
                        hintText: 'Search for anything',
                        hintStyle: TextStyles.body0Semibold(color: Colors.grey.withOpacity(0.8)),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.sm),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: TextStyles.calloutRegular(color: Colors.black),
                    ),
                    xxsSpacer(),
                    Text(
                      'Location',
                      style: TextStyles.calloutBold(color: Colors.black),
                    ),
                    xxsSpacer(),
                    TextField(
                      onChanged: (value) => location = value.trim(),
                      decoration: InputDecoration(
                        hintText: 'City, etc.',
                        hintStyle: TextStyles.body0Semibold(color: Colors.grey.withOpacity(0.8)),
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.sm),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: TextStyles.calloutRegular(color: Colors.black),
                    ),
                    mdSpacer(),
                    GestureDetector(
                      onTap: () {
                        _applyFilter(); // Apply filter when the button is pressed
                      },
                      child: Container(
                        width: context.width,
                        height: context.height * 0.06,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5E569B),
                          borderRadius: BorderRadius.circular(Dimensions.sm),
                        ),
                        child: Center(
                          child: Text(
                            'Search',
                            style: TextStyles.buttonMedium(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget _appBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm, vertical: Dimensions.xxs),
        child: Consumer<EmployeeViewModel>(
          builder: (context, employeeViewModel, _) {
            return Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/avatar_3.jpg'),
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
                      employeeViewModel.employee?.name ?? 'Dustin Bates',
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
            );
          },
        ),
      );

  List<Widget> _topCompanyWidget() => [
        Padding(
          padding: Paddings.horizontalSm,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Top Companies',
                style: TextStyles.buttonBold(color: Colors.black),
              ),
              const Spacer(),
              Text(
                'see all',
                style: TextStyles.buttonRegular(color: Colors.grey.withOpacity(0.8)),
              ),
            ],
          ),
        ),
        xsSpacer(),
        SizedBox(
          height: context.height * 0.3,
          child: ListWheelScrollView(
            itemExtent: context.height * 0.26,
            controller: _scrollController,
            children: List.generate(
              context.read<EmployeeViewModel>().companies.length,
              (index) => CompanyCard(company: context.read<EmployeeViewModel>().companies[index]),
            ).toList(),
          ),
        ),
      ];

  List<Widget> _carouselOffersWidget() => [
        Padding(
          padding: Paddings.horizontalSm,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Popular Today🔥',
                style: TextStyles.buttonBold(color: Colors.black),
              ),
              const Spacer(),
              filteredOffers.isEmpty
                  ? const Center()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        filteredOffers.length,
                        (index) => OfferIndicator(
                          key: ValueKey(index),
                          isSelected: index == selectedIndex,
                          color: Colors.red,
                        ),
                      ).withSpacing(xxxxsSpacer()),
                    ),
            ],
          ),
        ),
        xsSpacer(),
        CarouselSlider(
          options: CarouselOptions(
            enableInfiniteScroll: filteredOffers.isNotEmpty && filteredOffers.length > 1,
            autoPlay: true,
            aspectRatio: 1.6,
            viewportFraction: 0.9,
            clipBehavior: Clip.none,
            onPageChanged: (index, reason) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          items: filteredOffers.map((offer) {
            return OfferCard(offer: offer);
          }).toList(),
        ),
      ];

  Widget _body() => Container(
        color: Colors.grey.withOpacity(0.1),
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              xxlSpacer(),
              _appBar(),
              smSpacer(),
              _searchWidget(),
              smSpacer(),
              ..._carouselOffersWidget(),
              smSpacer(),
              ..._topCompanyWidget(),
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
