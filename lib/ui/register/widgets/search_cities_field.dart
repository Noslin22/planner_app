import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';
import 'package:planner_app/utils/extensions/accents_extension.dart';
import 'package:searchfield/searchfield.dart';

import '../../../domain/models/city_model.dart';
import '../../core/theme/app_colors.dart';

class SearchCitiesField extends StatelessWidget {
  const SearchCitiesField({
    super.key,
    required this.viewModel,
    required this.localizations,
  });
  final RegisterViewModel viewModel;
  final AppLocalization localizations;

  @override
  Widget build(BuildContext context) {
    return SearchField<CityModel>(
      suggestions: viewModel.cities.map((city) => city.toListItem).toList(),
      selectedValue: viewModel.destination?.toListItem,
      onSuggestionTap: (suggestion) {
        final city = suggestion.item;
        if (city != null) {
          viewModel.destination = city;
        }
      },
      onTap: () {
        if (viewModel.destination != null) {
          viewModel.destination = null;
        }
      },
      onSearchTextChanged: (query) {
        final filter = viewModel.cities.where((city) {
          if (query.hasAccent) {
            return city.name.toLowerCase().contains(query.toLowerCase());
          } else {
            return city.name
                .toLowerCase()
                .withoutAccents
                .contains(query.toLowerCase());
          }
        }).toList();
        return filter.map((city) => city.toListItem).toList();
      },
      scrollbarDecoration: ScrollbarDecoration(
        radius: const Radius.circular(10),
        crossAxisMargin: 1,
        trackRadius: const Radius.circular(10),
      ),
      suggestionsDecoration: SuggestionDecoration(
        borderRadius: BorderRadius.circular(10),
        elevation: 10,
        boxShadow: [
          BoxShadow(
            color: AppColors.zinc[800]!,
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
      ),
      searchInputDecoration: SearchInputDecoration(
        hintText: localizations.where,
        icon: const Icon(
          Icons.place,
          color: AppColors.zinc,
        ),
      ),
    );
  }
}
