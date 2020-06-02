//
//  MapScreen.swift
//  ImobiliareApp2
//
//  Created by user169246 on 5/2

//  Copyright © 2020 Costache_Adriana. All rights reserved.
//

import UIKit
import MapKit
import MapKit
import CoreLocation
import FirebaseDatabase

class MapScreen: UIViewController{
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    let geoCoder = CLGeocoder()
    var databaseHandle = DatabaseHandle()
    var postData =  [String]()
    var locationsList = [LocModel]()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var directionsArray: [MKDirections] = []
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
   
    
  
     override func viewDidLoad() {
        super.viewDidLoad()
       checkLocationServices()
       createAnnotation(location: annotationLocatin)
      
          }
           
          func setupLocationManager() {
              locationManager.delegate = self
              locationManager.desiredAccuracy = kCLLocationAccuracyBest
          }
          
          
          func centerViewOnUserLocation() {
              if let location = locationManager.location?.coordinate {
                  let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                  mapView.setRegion(region, animated: true)
              }
          }
          
          
          func checkLocationServices() {
              if CLLocationManager.locationServicesEnabled() {
                  setupLocationManager()
                  checkLocationAuthorization()
              } else {
                //alerta  catre useri
              }
          }
          
          
          func checkLocationAuthorization() {
              switch CLLocationManager.authorizationStatus() {
              case .authorizedWhenInUse:
                  startTackingUserLocation()
              case .denied:
                  // Show alert instructing them how to turn on permissions
                  break
              case .notDetermined:
                  locationManager.requestWhenInUseAuthorization()
              case .restricted:
                  // Show an alert
                  break
              case .authorizedAlways:
                  break
              @unknown default:
                  break
              }
          }
          
          
          func startTackingUserLocation() {
              mapView.showsUserLocation = true
              centerViewOnUserLocation()
              locationManager.startUpdatingLocation()
              previousLocation = getCenterLocation(for: mapView)
          }
          
          
          func getCenterLocation(for mapView: MKMapView) -> CLLocation {
              let latitude = mapView.centerCoordinate.latitude
              let longitude = mapView.centerCoordinate.longitude
              
              return CLLocation(latitude: latitude, longitude: longitude)
          }
          
          
          func getDirections() {
              guard let location = locationManager.location?.coordinate else {
                
                  return
              }
              
              let request = createDirectionsRequest(from: location)
              let directions = MKDirections(request: request)
              resetMapView(withNew: directions)
              
              directions.calculate { [unowned self] (response, error) in
                  
                  guard let response = response else { return }
                  
                  for route in response.routes {
                      self.mapView.addOverlay(route.polyline)
                      self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                  }
              }
          }
          
          
          func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
              let destinationCoordinate = getCenterLocation(for: mapView).coordinate
              let startingLocation = MKPlacemark(coordinate: coordinate)
              let destination = MKPlacemark(coordinate: destinationCoordinate)
              
              let request = MKDirections.Request()
              request.source = MKMapItem(placemark: startingLocation)
              request.destination = MKMapItem(placemark: destination)
              request.transportType = .automobile
              request.requestsAlternateRoutes = true
              
              return request
          }
          
          
          func resetMapView(withNew directions: MKDirections) {
              mapView.removeOverlays(mapView.overlays)
              directionsArray.append(directions)
              let _ = directionsArray.map { $0.cancel() }
          }
          
          
          
          
    let annotationLocatin = [[ "latitude" : 52.45600939264076, "longitude" :1.8896484375000002],
                             ["latitude": 48.864714761802794, "longitude" : 2.2851562500000004],
        ["latitude":44.402391829093915, "longitude": 26.059570312500004],
        ["latitude" :37.9661626, "longitude" : 38.364257]]
    
    
    func createAnnotation(location: [[String : Any]]){
        for location in location {
            let annotations = MKPointAnnotation()
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"]as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            mapView.addAnnotation(annotations)
        }
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton) { getDirections()
    }
}


      extension MapScreen: CLLocationManagerDelegate {
          
          func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
              checkLocationAuthorization()
          }
      }


      extension MapScreen: MKMapViewDelegate {
          
          func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
              let center = getCenterLocation(for: mapView)
              
              guard let previousLocation = self.previousLocation else { return }
              
              guard center.distance(from: previousLocation) > 50 else { return }
              self.previousLocation = center
              
              geoCoder.cancelGeocode()
              
              geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
                  guard let self = self else { return }
                  
                  if let _ = error {
                    
                      return
                  }
                  
                  guard let placemark = placemarks?.first else {
                      return
                  }
                  
                  let streetNumber = placemark.subThoroughfare ?? ""
                  let streetName = placemark.thoroughfare ?? ""
                  
                  DispatchQueue.main.async {
                      self.addressLabel.text = "\(streetNumber) \(streetName)"
                  }
              }
          }
          
          
          func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
              let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
              renderer.strokeColor = .blue
              
              return renderer
          }
      }
