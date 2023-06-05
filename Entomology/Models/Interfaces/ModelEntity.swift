//
//  ModelEntity.swift
//  Entomology
//
//  Created by Paul Pacheco on 1/06/23.
//

import Foundation

protocol ModelEntity {
	associatedtype T
	
	func toJson() -> String
	func fromJson(json: String?) -> T?
	func toString() -> String
	//func fromString(str: String) -> T
	func copyWith(_ model: T) -> T
}
