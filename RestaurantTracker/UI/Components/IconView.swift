//
//  IconView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI

struct IconView: View {
    let imageData: Data?
    
    var body: some View {
        ZStack {
            if let imageData = imageData {
                if let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                }
            } else {
                Image(systemName: "photo")
                    .font(.largeTitle)
            }
            
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 120)
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
    }
}

#Preview {
    IconView(imageData: nil)
}
