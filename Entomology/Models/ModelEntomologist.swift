//
//  ModelEntomologist.swift
//  Entomology
//
//  Created by Paul Pacheco on 1/06/23.
//

import Foundation

struct ModelEntomologist: Codable, ModelEntity {
	typealias T = ModelEntomologist
	
	var name: String?
	var urlPhoto: String?
	var geoLocate: String?
	
	func changeUrlPhoto(type: String) {}
	
	func changeGeoLocationPhoto() {}
	
	func toJson() -> String {
		String(describing: self)
	}
	
	func fromJson(json: String?) -> ModelEntomologist? {
		do {
			if let dataFromJsonString = json?.data(using: .utf8) {
				let model = try JSONDecoder().decode(ModelEntomologist.self, from: dataFromJsonString)
				return model
			}
		} catch {
			print(error)
			return nil
		}
		return nil
	}
	
	func toString() -> String {
		return String(describing: self)
	}
	
//	func fromString(str: String) -> ModelEntomologist {
//
//	}
	
	func copyWith(_ model: ModelEntomologist) -> ModelEntomologist {
		return ModelEntomologist(name: model.name ?? self.name, urlPhoto: model.urlPhoto ?? self.urlPhoto, geoLocate: model.geoLocate ?? self.geoLocate)
	}
}
