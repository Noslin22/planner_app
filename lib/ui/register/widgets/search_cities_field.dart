import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';
import 'package:planner_app/utils/extensions/accents_extension.dart';
import 'package:searchfield/searchfield.dart';

import '../../../data/service/cities/model/city_model.dart';
import '../../core/theme/app_colors.dart';

class SearchCitiesField extends StatelessWidget {
  const SearchCitiesField({
    super.key,
    required this.viewModel,
  });
  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context);
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
        boxShadow: const [
          BoxShadow(
            color: AppColors.zinc800,
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
      ),
      suggestionState: Suggestion.hidden,
      searchInputDecoration: SearchInputDecoration(
        hintText: localizations.where,
        icon: const Icon(
          Icons.place,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
