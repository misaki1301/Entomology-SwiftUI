//
//  LocationViewModel.swift
//  Entomology
//
//  Created by Paul Pacheco on 2/06/23.
//

import CoreLocation
import Foundation
import UIKit

class LocationViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {
	@Published var authorizationStatus: CLAuthorizationStatus = .denied
	@Published var isPermissionActive: Bool = false
	@Published var lastSeenLocation: CLLocation?
	@Published var currentPlacemark: CLPlacemark?
	
	private let locationManager: CLLocationManager

	override init() {
		locationManager = CLLocationManager()
		authorizationStatus = locationManager.authorizationStatus
		super.init()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 0.4
		locationManager.startUpdatingLocation()
		updateAuthorizationStatus()
	}
	
	func requestPermission() {
		locationManager.requestWhenInUseAuthorization()
		if authorizationStatus == .notDetermined {
			locationManager.requestWhenInUseAuthorization()
			return
		}
	}
	
	func updateLocationEnabled() {
			if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
				locationManager.startUpdatingLocation()
			} else {
				locationManager.stopUpdatingLocation()
			}
		}
	
	func updateAuthorizationStatus() {
		authorizationStatus = locationManager.authorizationStatus
		isPermissionActive = authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
	}
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		authorizationStatus = manager.authorizationStatus
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		lastSeenLocation = locations.first
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		updateAuthorizationStatus()
	}
	
	@MainActor
	func fetchCountryAndCity(for location: CLLocation?) async {
		guard let location = location else {
			return
		}
		let geocoder = CLGeocoder()
		let placemarks = try? await geocoder.reverseGeocodeLocation(location)
		if placemarks != nil {
			self.currentPlacemark = placemarks?.first
		}
	}
}
