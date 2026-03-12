//
//  RestaurantList.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftData
import SwiftUI

struct RestaurantListScreen: View {
    @Query private var restaurants: [Restaurant]
    @Environment(\.modelContext) private var context

    @State private var newRestaurant: Restaurant?
    @Binding var selectedRestaurant: Restaurant?
    @Binding var sortOption: SortOption
    private var fromSearch: Bool

    init(
        titleAndNoteFilter: String = "",
        sortOption: Binding<SortOption>,
        selectedRestaurant: Binding<Restaurant?>
    ) {
        let predicate = #Predicate<Restaurant> { restaurant in
            titleAndNoteFilter.isEmpty
                || restaurant.name.localizedStandardContains(titleAndNoteFilter)
                || restaurant.notes.localizedStandardContains(
                    titleAndNoteFilter
                )
        }

        self.fromSearch = !titleAndNoteFilter.isEmpty
        self._selectedRestaurant = selectedRestaurant
        self._sortOption = sortOption
        // Binding needs the _ in front of var name

        _restaurants = Query(
            filter: predicate,
            sort: sortOption.wrappedValue.descriptors
        )
    }

    var body: some View {
        ZStack {
            if !restaurants.isEmpty {
                List(selection: $selectedRestaurant) {
                    ForEach(restaurants) { restaurant in
                        RestaurantCardView(restaurant: restaurant)
                    }
                    .onDelete(perform: deleteRestaurants(indexes:))
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView(
                    fromSearch ? "No Result Found" : "No Restaurant",
                    systemImage: fromSearch ? "magnifyingglass" : "fork.knife"
                )
            }
        }
        .navigationTitle("RestoTrack")
        .navigationSubtitle("A simple app to track your food journey")
        .toolbar {
            ToolbarItem {
                Button(
                    "Add restaurant",
                    systemImage: "plus",
                    action: addRestaurant
                )
            }

            ToolbarItem(placement: .secondaryAction) {
                EditButton()
            }

            ToolbarItem(placement: .secondaryAction) {
                Menu {
                    Picker("Sort By", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }

            ToolbarItem(placement: .bottomBar) {
                // TODO: Fix the button width
                Button("Pick for me!") {
                    selectedRestaurant = restaurants.randomElement()
                }
            }
        }
        .sheet(item: $newRestaurant) { restaurant in
            NavigationStack {
                RestaurantDetailScreen(restaurant: restaurant, isNew: true)
            }
            .interactiveDismissDisabled()
        }
    }

    private func addRestaurant() {
        let newRestaurant = Restaurant(
            name: "",
            mapLink: "",
            notes: "",
            rating: 1,
            price: .expensive,
            taste: .trash,
        )
        context.insert(newRestaurant)
        self.newRestaurant = newRestaurant
    }

    private func deleteRestaurants(indexes: IndexSet) {
        for index in indexes {
            context.delete(restaurants[index])
        }
    }
}

#Preview {
    NavigationStack {
        // These preview won't have the randomizer working cause I used nil
        RestaurantListScreen(
            sortOption: .constant(SortOption.newest),
            selectedRestaurant: .constant(nil)
        )
        .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack {
        RestaurantListScreen(
            titleAndNoteFilter: "for",
            sortOption: .constant(SortOption.newest),
            selectedRestaurant: .constant(nil)
        )
        .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty") {
    NavigationStack {
        RestaurantListScreen(
            sortOption: .constant(SortOption.newest),
            selectedRestaurant: .constant(nil)
        )
        .modelContainer(for: Restaurant.self, inMemory: true)
    }
}
