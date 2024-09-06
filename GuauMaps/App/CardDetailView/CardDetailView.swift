//
//  CardDetailView.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 5/9/24.
//

import SwiftUI

struct CardDetailView: View {
    @State private var selectedImageIndex: Int = 0 // Para rastrear la imagen actual
    
    let titleString: String
    let images: [String]
    
    var body: some View {
        VStack {
            imageCarrousel
            Text(titleString)
                .font(.largeTitle)
                .padding()
            Spacer()
            // Agrega más detalles según sea necesario
        }
        .navigationTitle("Detalles") // Opcional: título de la navegación
    }
}

extension CardDetailView {
    private var imageCarrousel: some View {
        TabView(selection: $selectedImageIndex) {
            ForEach(0..<images.count, id: \.self) { index in
                AsyncImage(url: URL(string: images[index])) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width, height: 370)
                            //.clipped()
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
        .edgesIgnoringSafeArea(.all)
    }
}
