//
//  MainView.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 29/8/24.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    @StateObject private var viewModel = AppleMapViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                showAppleMaps
                showButtonsBar
                if let location = viewModel.selectedLocation {
                    VStack {
                        Spacer()
                        InfoCardView(location: location)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .transition(.move(edge: .top))
                    }
                }
            }
        }
    }
}

extension MainView {
    private var showAppleMaps: some View {
        AppleMapView(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var showButtonsBar: some View {
        HStack {
            Spacer()
            VStack {
                Button(action: {
                    viewModel.centerOnUserLocation()
                }){
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 58, height: 40)
                        .foregroundColor(Color.gray) // Color de fondo gris oscuro
                        .overlay(
                            Image(systemName: "location.fill") // Reemplaza con el nombre de tu imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20) // Tamaño de la imagen
                                .foregroundColor(Color.white) // Color blanco para la imagen
                        )
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
            .padding()
        }
    }
}

//struct MainView: View {
//    @State private var selectedLocation: LocationModel?
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Spacer()
//                NavigationLink(destination: GoogleMapsView()) {
//                    Text("Google Maps")
//                }
//                .padding(.bottom, 40)
//
//                NavigationLink(destination: AppleMapsView()) {
//                    Text("Apple Maps")
//                }
//                Spacer()
//            }
//        }
//    }
//}
