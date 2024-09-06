////
////  AppleMapViewModel.swift
////  GuauMaps
////
////  Created by Arnau Rivas Rivas on 6/9/24.
////

import SwiftUI
import MapKit
import CoreLocation

class AppleMapViewModel: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    @Published var selectedLocation: LocationModel?
    private var userLocationAnnotation: MKPointAnnotation? // Anotación para la ubicación del usuario
    private var userLocation: CLLocation? // Almacenar la ubicación del usuario
    var locationManager = CLLocationManager()
    var mapView = MKMapView()

    override init() {
        super.init()
        locationManager.delegate = self
        mapView.delegate = self
        mapView.showsUserLocation = true
        requestLocationAuthorization()
        loadAndAddAnnotations()
    }

    // Manejo de permisos de ubicación
    func requestLocationAuthorization() {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    // Actualizar la ubicación del usuario
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location
            let region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            mapView.setRegion(region, animated: true)
            
            // Añadir o actualizar la anotación de la ubicación del usuario
            //updateUserLocationAnnotation(with: location.coordinate)
        }
    }
    
    func centerOnUserLocation() {
            if let location = userLocation {
                let region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                mapView.setRegion(region, animated: true)
            } else {
                print("La ubicación del usuario no está disponible.")
            }
        }

//    // Crear o actualizar la anotación para la ubicación del usuario
//    func updateUserLocationAnnotation(with coordinate: CLLocationCoordinate2D) {
//        if let annotation = userLocationAnnotation {
//            // Si la anotación ya existe, simplemente actualiza su posición
//            annotation.coordinate = coordinate
//        } else {
//            // Si no existe, crea una nueva anotación para la ubicación del usuario
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = coordinate
//            annotation.title = "Tu ubicación"
//            mapView.addAnnotation(annotation)
//            userLocationAnnotation = annotation
//        }
//    }

    // Detectar cuando se selecciona una anotación
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation {
            if let locations = loadLocationsFromJSON() {
                if let location = locations.first(where: {
                    $0.latitude == annotation.coordinate.latitude &&
                    $0.longitude == annotation.coordinate.longitude
                }) {
                    selectedLocation = location // Actualizar la ubicación seleccionada
                }
            }
        }
    }

    // Cargar ubicaciones desde un archivo JSON
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

    // Añadir anotaciones al mapa
    func loadAndAddAnnotations() {
        if let locations = loadLocationsFromJSON() {
            for location in locations {
                addAnnotation(for: location)
            }
        }
    }

    // Función para añadir una anotación en el mapa
    func addAnnotation(for location: LocationModel) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        annotation.title = location.title
        annotation.subtitle = location.snippet
        
        mapView.addAnnotation(annotation)
    }
}
