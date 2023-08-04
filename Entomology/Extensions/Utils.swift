//
//  Utils.swift
//  Entomology
//
//  Created by Paul Frank Pacheco Carpio on 31/07/23.
//

import Foundation

func convertToSwiftDictionaries(from nsDictionaries: [NSDictionary]) -> [[String: Any]] {
	return nsDictionaries.compactMap { nsDictionary in
		nsDictionary as? [String: Any]
	}
}
