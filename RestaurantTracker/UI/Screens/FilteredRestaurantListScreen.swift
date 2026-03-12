//
//  FilteredRestaurantListScreen.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftData
import SwiftUI

struct FilteredRestaurantListScreen: View {
    @State private var searchText = ""
    @State private var selectedRestaurant: Restaurant?

    var body: some View {
        NavigationSplitView {
            RestaurantListScreen(
                titleAndNoteFilter: searchText,
                selectedRestaurant: $selectedRestaurant
            )
            .searchable(text: $searchText, placement: .toolbar)
        } detail: {
            if let selectedRestaurant = selectedRestaurant {
                RestaurantDetailScreen(restaurant: selectedRestaurant)
            } else {
                Text("Select a restaurant")
                    .navigationTitle("Restaurant")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    FilteredRestaurantListScreen()
        .modelContainer(SampleData.shared.modelContainer)
}
