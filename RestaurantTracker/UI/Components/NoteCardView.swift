//
//  NoteCardView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI
import PhotosUI

struct NoteCardView: View {
    @Bindable var restaurant: Restaurant
    
    var body: some View {
        VStack {
            CardSubHeadingView(text: "Notes")

            TextField("Notes", text: $restaurant.notes, axis: .vertical)
                .lineLimit(1...10)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .glassEffect(in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NoteCardView(restaurant: SampleData.shared.restaurantSample)
}
