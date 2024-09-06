//
//  StarRatingView.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 5/9/24.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double // Puntuación del 0 al 10
    private let maxRating = 5 // Número máximo de estrellas
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { index in
                let starRating = (rating / 2) // Convertir de 0-10 a 0-5
                let fullStar = Double(index) < starRating
                let halfStar = Double(index) < (starRating + 0.5) && !fullStar
                
                Image(systemName: fullStar ? "star.fill" : (halfStar ? "star.leadinghalf.fill" : "star"))
                    .foregroundColor(.yellow)
                    .imageScale(.large)
            }
        }
    }
}

#Preview {
    StarRatingView(rating: 5.2)
}
