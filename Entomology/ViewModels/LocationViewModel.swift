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
	
	private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) async {
		lastSeenLocation = locations.first
		await fetchCountryAndCity(for: locations.first)
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		updateAuthorizationStatus()
	}
	
	func fetchCountryAndCity(for location: CLLocation?) async {
		guard let location = location else {
			print("Invalid location...")
			return
		}
		let geocoder = CLGeocoder()
		let placemarks = try? await geocoder.reverseGeocodeLocation(location)
		if placemarks != nil {
			self.currentPlacemark = placemarks?.first
		}
		//placemarks, error in
//			guard error != nil else {
//				print("error geodecoding... \(error)")
//				return
//			}
//			self.currentPlacemark = placemarks?.first
//		}
	}
}
