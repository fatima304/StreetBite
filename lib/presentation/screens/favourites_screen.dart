import 'package:food_delivery/core/constants/app_images.dart';

import '../../core/widgets/app_back_button.dart';

import 'package:food_delivery/core/routing/routes.dart';
import 'package:food_delivery/core/routing/app_router.dart';
import 'package:food_delivery/core/helper/localized_state_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/l10n/app_localizations.dart';

import '../blocs/favourites_cubit.dart';
import '../widgets/common/meal_image.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(l10n.favourites),
      ),
      body: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.meals.isEmpty) {
            return Center(
              child: Text(
                localizedStateError(context, state.error),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (state.meals.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppImages.emptyFavourites,
                      height: 220,
                      errorBuilder: (_, _, _) =>
                          const Icon(Icons.favorite_border_rounded, size: 100),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.noFavouritesYet,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.noFavouritesDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.home,
                          (_) => false,
                        ),
                        child: Text(l10n.exploreMeals),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(18),
            itemCount: state.meals.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final meal = state.meals[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  leading: MealImage(
                    imageUrl: meal.imageUrl,
                    width: 64,
                    height: 64,
                    borderRadius: 10,
                    placeholderIcon: Icons.restaurant,
                    placeholderSize: 24,
                  ),
                  title: Text(
                    meal.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('\$${meal.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite_rounded, color: Colors.red),
                    onPressed: () =>
                        context.read<FavouritesCubit>().toggle(meal),
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.mealDetails,
                    arguments: MealDetailsArgs(
                      mealId: meal.id,
                      initialMeal: meal,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
