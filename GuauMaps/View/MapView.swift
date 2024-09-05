////
////  MapView.swift
////  GuauMaps
////
////  Created by Arnau Rivas Rivas on 29/8/24.
////

import SwiftUI
import GoogleMaps
import CoreLocation

struct MapView: UIViewRepresentable {
    @Binding var selectedLocation: LocationModel? // Para almacenar la ubicación seleccionada
    
    // Make Coordinator to handle map events
    class Coordinator: NSObject, CLLocationManagerDelegate, GMSMapViewDelegate {
        var mapView: GMSMapView?
        var locationManager = CLLocationManager()
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
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
        
        // GMSMapViewDelegate: Detectar cuando se pulsa un marcador
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if let location = marker.userData as? LocationModel {
                parent.selectedLocation = location // Actualizar la ubicación seleccionada
            }
            return true
        }
    }
    
    // Make coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    // Create UIView
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = context.coordinator // Asignar delegado del mapa
        
        context.coordinator.mapView = mapView
        
        // Request location authorization
        context.coordinator.locationManager.requestWhenInUseAuthorization()
        
        // Leer las ubicaciones desde el mock JSON y añadir marcadores
        if let locations = loadLocationsFromJSON() {
            for location in locations {
                addMarker(for: location, on: mapView)
            }
        }
        
        return mapView
    }
    
    // Update UIView
    func updateUIView(_ uiView: GMSMapView, context: Context) {}
    
    // Función para cargar ubicaciones desde un archivo JSON
    func loadLocationsFromJSON() -> [LocationModel]? {
        if let url = Bundle.main.url(forResource: "locations_mock", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let locations = try JSONDecoder().decode([LocationModel].self, from: data)
                return locations
            } catch {
                print("Error al cargar o decodificar el archivo JSON: \(error)")
            }
        }
        return nil
    }
    
    // Función para añadir un marcador en el mapa
    func addMarker(for location: LocationModel, on mapView: GMSMapView) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.title = location.title
        marker.snippet = location.snippet
        marker.userData = location // Almacenar la información de la ubicación en el marcador
        
        // Personalizar el ícono del marcador si existe
        if let customIcon = UIImage(named: location.iconName) {
            marker.icon = customIcon
        }
        
        marker.map = mapView
    }
}
