//
//  PhotoSource.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//

import Foundation

enum PhotoSource: Identifiable {
	case photoLibrary
	case camera

	var id: Int {
		hashValue
	}
}
