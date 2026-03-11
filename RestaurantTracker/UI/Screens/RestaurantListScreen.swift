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
    private var fromSearch: Bool

    init(titleAndNoteFilter: String = "") {
        let predicate = #Predicate<Restaurant> { restaurant in
            titleAndNoteFilter.isEmpty
                || restaurant.name.localizedStandardContains(titleAndNoteFilter)
                || restaurant.notes.localizedStandardContains(
                    titleAndNoteFilter
                )
        }

        fromSearch = !titleAndNoteFilter.isEmpty

        _restaurants = Query(
            filter: predicate,
            sort: \Restaurant.timestamp,
            order: .reverse
        )
    }

    var body: some View {
        Group {
            if !restaurants.isEmpty {
                // TODO: Deal with that remaining single divider line below
                List {
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
        .navigationTitle("RestoTrack")  // TODO: Possibly make this inline with the buttons
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
                Button("Pick for me!") {
                    // TODO: Do something with the logic
                }
                .frame(maxWidth: .infinity)
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
        RestaurantListScreen()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack {
        RestaurantListScreen(titleAndNoteFilter: "for")
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty") {
    NavigationStack {
        RestaurantListScreen()
            .modelContainer(for: Restaurant.self, inMemory: true)
    }
}
