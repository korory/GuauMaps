//
//  GoogleMapsView.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 6/9/24.
//

import SwiftUI

struct GoogleMapsView: View {
    @State private var selectedLocation: LocationModel?
    
    var body: some View {
        //NavigationView {
            ZStack {
                // Mostrar el mapa
                MapView(selectedLocation: $selectedLocation)
                    .edgesIgnoringSafeArea(.all)
                
                // Mostrar la tarjeta si hay una ubicación seleccionada
                if let location = selectedLocation {
                    VStack {
                        InfoCardView(location: location)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .transition(.move(edge: .top))
                        Spacer()
                    }
                    
                }
            //}
        }
    }
}
