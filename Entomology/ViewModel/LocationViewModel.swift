//
//  LocationViewModel.swift
//  Entomology
//
//  Created by Paul Pacheco on 2/06/23.
//

import Foundation
import CoreLocation
import UIKit

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
	
	@Published var authorizationStatus: CLAuthorizationStatus
	@Published var isPermissionActive = false
	
	private let locationManager: CLLocationManager
	
	override init() {
		locationManager = CLLocationManager()
		authorizationStatus = locationManager.authorizationStatus
		super.init()
		
		isPermissionActive = self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse
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
	
}
