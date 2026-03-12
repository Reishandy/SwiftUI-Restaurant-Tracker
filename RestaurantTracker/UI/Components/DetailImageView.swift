//
//  DetailImageView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 12/03/26.
//

import PhotosUI
import SwiftUI

struct DetailImageView: View {
    @Bindable var restaurant: Restaurant
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PhotosPicker(
                selection: $selectedPhoto,
                matching: .images,
                photoLibrary: .shared()
            ) {
                ImageContainerView(
                    imageData: restaurant.photoData,
                    width: .infinity,
                    height: 400
                )
                .transition(.blurReplace)
            }
            .foregroundStyle(.secondary)
            .onChange(of: selectedPhoto) { oldPhoto, newPhoto in
                Task {
                    if let data = try? await newPhoto?.loadTransferable(
                        type: Data.self
                    ) {
                        restaurant.photoData = data
                    }
                }
            }

            if restaurant.photoData != nil {
                Button("Delete Image", systemImage: "trash.circle") {
                    restaurant.photoData = nil
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.glassProminent)
                .tint(.red)
                .padding()
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: restaurant.photoData)
    }
}

#Preview {
    DetailImageView(restaurant: SampleData.shared.restaurantSample)
}
