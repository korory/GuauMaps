////
////  InfoCardView.swift
////  GuauMaps
////
////  Created by Arnau Rivas Rivas on 5/9/24.
////

import SwiftUI

// Vista SwiftUI para mostrar la tarjeta de información
struct InfoCardView: View {
    let location: LocationModel
    @State private var selectedImageIndex: Int = 0 // Para rastrear la imagen actual
    
    var body: some View {
        VStack(alignment: .leading) {
            imageCarrousel
            bottomInformation
            ratingView
        }
        .padding(.trailing, 10)
        .padding(.leading, 10)
        .padding(.bottom, 10)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 8)
    }
}

extension InfoCardView {
    private var imageCarrousel: some View {
        TabView(selection: $selectedImageIndex) {
            ForEach(0..<location.imageUrls.count, id: \.self) { index in
                AsyncImage(url: URL(string: location.imageUrls[index])) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 140)
                            .clipped()
                            .cornerRadius(8)
                            .padding(.bottom, 10)
                            .padding(.top, 10)
                    } else if phase.error != nil {
                        // En caso de error
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 140)
                            .foregroundColor(.gray)
                            .cornerRadius(8)
                            .padding(.top, 10)
                    } else {
                        // Placeholder mientras se carga la imagen
                        ProgressView()
                            .frame(width: 100, height: 100)
                            .padding(.top, 10)
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 160)
    }
    
    private var bottomInformation: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(location.title)
                    .font(.headline)
                    .padding(.bottom, 2)
                Text(location.snippet)
                    .font(.subheadline)
            }
            Spacer()
            navigateToDetailScreen
        }
    }
    
    private var ratingView: some View {
        StarRatingView(rating: location.rating)
            .padding(.top, 1)
    }
    
    private var navigateToDetailScreen: some View {
        VStack {
            NavigationLink(destination: CardDetailView(titleString: location.title, images: location.imageUrls)) {
                Image(systemName: "arrow.forward")
                    .resizable()
                    .frame(width: 27, height: 22)
                    .foregroundColor(.gray)
                    .padding(.top, 25)
                    .padding(.trailing, 10)
            }
        }
    }
}
