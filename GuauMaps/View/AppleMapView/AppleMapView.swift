//
//  AppleMapView.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 6/9/24.
//

import SwiftUI
import MapKit

struct AppleMapView: UIViewRepresentable {
    @ObservedObject var viewModel: AppleMapViewModel

    func makeUIView(context: Context) -> MKMapView {
        let mapView = viewModel.mapView
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {}
}
