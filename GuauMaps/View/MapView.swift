//
//  MapView.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 29/8/24.
//

import SwiftUI
import GoogleMaps
import CoreLocation

struct MapView: UIViewRepresentable {
    // Make Coordinator to handle map events
    class Coordinator: NSObject, CLLocationManagerDelegate {
        var mapView: GMSMapView?
        var locationManager = CLLocationManager()

        override init() {
            super.init()
            locationManager.delegate = self
        }

        // Location manager delegate method
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
                mapView?.isMyLocationEnabled = true
                mapView?.settings.myLocationButton = true
            }
        }
    }

    // Make coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    // Create UIView
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        context.coordinator.mapView = mapView

        // Request location authorization
        context.coordinator.locationManager.requestWhenInUseAuthorization()
        return mapView
    }

    // Update UIView
    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}
