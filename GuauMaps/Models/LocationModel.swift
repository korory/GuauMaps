//
//  LocationModel.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 5/9/24.
//

import Foundation

struct LocationModel: Codable, Identifiable {
    var id: UUID = UUID()
    let latitude: Double
    let longitude: Double
    let title: String
    let snippet: String
    let iconName: String
    let imageUrls: [String]
    let rating: Double

    // Crear un init personalizado para excluir el campo 'id' del JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.title = try container.decode(String.self, forKey: .title)
        self.snippet = try container.decode(String.self, forKey: .snippet)
        self.iconName = try container.decode(String.self, forKey: .iconName)
        self.imageUrls = try container.decode([String].self, forKey: .imageUrls)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.id = UUID() // Generar un UUID automáticamente
    }
}
