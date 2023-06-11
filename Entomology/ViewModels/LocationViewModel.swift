//
//  LocationViewModel.swift
//  Entomology
//
//  Created by Paul Pacheco on 2/06/23.
//

import CoreLocation
import Foundation
import UIKit

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
	@Published var authorizationStatus: CLAuthorizationStatus
	@Published var isPermissionActive = false
	@Published var lastSeenLocation: CLLocation?
	@Published var currentPlacemark: CLPlacemark?
	
	private let locationManager: CLLocationManager
	
	override init() {
		locationManager = CLLocationManager()
		authorizationStatus = locationManager.authorizationStatus
		super.init()
		
		isPermissionActive = authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.startUpdatingLocation()
	}
	
	func requestPermission() {
		locationManager.requestWhenInUseAuthorization()
		if authorizationStatus == .notDetermined {
			locationManager.requestWhenInUseAuthorization()
			return
		}
	}
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		authorizationStatus = manager.authorizationStatus
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		lastSeenLocation = locations.first
		fetchCountryAndCity(for: locations.first)
	}
	
	func fetchCountryAndCity(for location: CLLocation?) {
		guard let location = location else {
			return
		}
		let geocoder = CLGeocoder()
		geocoder.reverseGeocodeLocation(location) { placemarks, error in
			self.currentPlacemark = placemarks?.first
		}
	}
}
