import 'package:food_delivery/core/helper/localized_state_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/l10n/app_localizations.dart';

import '../blocs/home_cubit.dart';
import '../blocs/home_state.dart';
import '../../core/widgets/app_nav.dart';
import '../widgets/home/home_categories.dart';
import '../../core/widgets/ui_parts.dart';
import '../widgets/home/nearby_vendors_card.dart';
import '../widgets/home/home_search_field.dart';
import '../widgets/home/offers_carousel.dart';
import '../widgets/home/hot_offers_list.dart';
import '../widgets/home/popular_meals_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(l10n.homeScreen),
      ),
      bottomNavigationBar: const AppNav(index: 0),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => RefreshIndicator(
            onRefresh: () => context.read<HomeCubit>().load(),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: [
                const SizedBox(height: 12),
                const NearbyVendorsCard(),
                const SizedBox(height: 16),
                const HomeSearchField(),
                const SizedBox(height: 16),
                OffersCarousel(),
                SectionHeading(l10n.categories),
                HomeCategories(
                  categories: state.categories,
                  selected: state.selectedCategory,
                  onSelected: context.read<HomeCubit>().selectCategory,
                ),
                SectionHeading(l10n.hotOffers),
                HotOffersList(offers: state.offers),
                SectionHeading(l10n.popularMeals),
                if (state.loading)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (state.error != null)
                  Column(
                    children: [
                      Text(
                        localizedStateError(context, state.error),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () => state.selectedCategory == null
                            ? context.read<HomeCubit>().load()
                            : context.read<HomeCubit>().selectCategory(
                                state.selectedCategory,
                              ),
                        child: Text(l10n.tryAgain),
                      ),
                    ],
                  ),
                if (!state.loading &&
                    state.error == null &&
                    state.meals.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(l10n.noMealsFound),
                    ),
                  ),
                if (state.meals.isNotEmpty)
                  PopularMealsGrid(meals: state.meals),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
