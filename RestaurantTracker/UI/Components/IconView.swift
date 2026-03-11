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
                        .resizable()
                        .frame(width: 120, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            } else {
                Image(systemName: "photo")
                    .font(.largeTitle)
            }
            
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 120, height: 100)
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
    }
}

#Preview {
    IconView(imageData: nil)
}
