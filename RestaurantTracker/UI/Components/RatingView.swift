//
//  RatingView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI

struct RatingView: View {
    let rating: Int
    
    var body: some View {
        HStack {
            ForEach(0..<5, id: \.description) { number in
                Image(systemName: number >= rating ? "star" : "star.fill")
            }
        }
    }
}

#Preview {
    RatingView(rating: 3)
}
