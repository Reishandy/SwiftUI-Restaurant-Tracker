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

    var body: some View {
        NavigationSplitView {
            RestaurantListScreen(titleAndNoteFilter: searchText)
                .searchable(text: $searchText, placement: .navigationBarDrawer)
        } detail: {
            Text("Select a restaurant")
                .navigationTitle("Restaurant")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredRestaurantListScreen()
        .modelContainer(SampleData.shared.modelContainer)
}
