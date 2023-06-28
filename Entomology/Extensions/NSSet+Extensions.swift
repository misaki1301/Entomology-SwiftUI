//
//  NSSet+Extensions.swift
//  Entomology
//
//  Created by Paul Pacheco on 16/06/23.
//

import Foundation

extension NSSet {
	// swiftlint:disable force_cast
	func toArray<T>() -> [T] {
		let array = self.map { $0 as! T }
		return array
	}
	// swiftlint:enable force_cast
}
