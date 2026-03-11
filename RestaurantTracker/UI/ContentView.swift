//
//  ContentView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        FilteredRestaurantListScreen()
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}
