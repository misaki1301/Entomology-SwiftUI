//
//  GeoLocation.swift
//  Entomology
//
//  Created by Paul Pacheco on 2/06/23.
//

import Foundation

struct GeoLocation: Codable, ModelEntity {
	
	typealias T = GeoLocation
	
	var lat: Double?
	var lng: Double?
	
	mutating func setLatLng(latitude: Double, longitude: Double) {
		self.lat = latitude
		self.lng = longitude
	}
	
	func toJson() -> String {
		return ""
	}
	
	func toString() -> String {
		return ""
	}
	
	func fromJson(json: String?) -> GeoLocation? {
		return nil
	}
	
	func copyWith(_ model: GeoLocation) -> GeoLocation {
		return GeoLocation(lat: model.lat ?? self.lat, lng: model.lng ?? self.lng)
	}
	
}
