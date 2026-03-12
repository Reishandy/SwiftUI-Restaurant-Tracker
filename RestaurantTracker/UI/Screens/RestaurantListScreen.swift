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
    private var fromSearch: Bool

    init(
        titleAndNoteFilter: String = "",
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
        // Binding needs the _ in front of var name

        _restaurants = Query(
            filter: predicate,
            sort: \Restaurant.timestamp,
            order: .reverse
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

            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
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
        RestaurantListScreen(selectedRestaurant: .constant(nil))
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack {
        RestaurantListScreen(
            titleAndNoteFilter: "for",
            selectedRestaurant: .constant(nil)
        )
        .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty") {
    NavigationStack {
        RestaurantListScreen(selectedRestaurant: .constant(nil))
            .modelContainer(for: Restaurant.self, inMemory: true)
    }
}
