//
//  ModelInsect.swift
//  Entomology
//
//  Created by Paul Pacheco on 2/06/23.
//

import Foundation

struct ModelInsect: Codable, ModelEntity {
	typealias T = ModelInsect
	
	var speciesName: String?
	var urlPhoto: String?
	var geoLocate: String?
	var moreInfoUrl: String?
	
	func changePhotoUrl(photo: String?) {
		
	}
	
	func changeMoreInfoUrl(info: String?) {
		
	}
	
	func changeGeoLocationPhoto(location: GeoLocation) {
		
	}
	
	func fromJson(json: String?) -> ModelInsect? {
		return nil
	}
	
	func copyWith(_ model: ModelInsect) -> ModelInsect {
		return ModelInsect(
			speciesName: model.speciesName ?? self.speciesName,
			urlPhoto: model.urlPhoto ?? self.speciesName,
			geoLocate: model.geoLocate ?? self.geoLocate,
			moreInfoUrl: model.moreInfoUrl ?? self.moreInfoUrl)
	}
	
	func toJson() -> String {
		return ""
	}
	
	func toString() -> String {
		return ""
	}
	
	
}
