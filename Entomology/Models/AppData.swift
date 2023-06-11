//
//  AppData.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import Foundation
import CoreData

@propertyWrapper
struct Storage<T> {
	private let key: String
	private let defaultValue: T
	
	init(key: String, defaultValue: T) {
		self.key = key
		self.defaultValue = defaultValue
	}
	var wrappedValue: T {
		get {
			//Read value from Userdefaults
			return UserDefaults.standard.string(forKey: key) as? T ?? defaultValue
		}
		set {
			//Set value to UserDefaults
			UserDefaults.standard.set(newValue, forKey: key)
		}
	}
}

struct AppData {
	@Storage(key: "default_user_id", defaultValue: "")
	static var defaultUserId: String
}
