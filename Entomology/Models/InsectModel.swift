//
//  Insect.swift
//  Entomology
//
//  Created by Paul Pacheco on 29/06/23.
//

import Foundation
import UIKit

struct InsectModel: Hashable {
	var localePhoto: Data
	var locate: String
	var moreInfoUrl: String
	var speciesName: String
	var totalCount: Int
	
	static func convertToModel(for listDict: [[String: Any]]) -> [InsectModel] {
		listDict.map { item -> InsectModel in
			let localePhoto: Data = item["localePhoto"] as? Data ?? UIImage(named: "ant")!.pngData()!
			let locate: String = item["locate"] as? String ?? ""
			let moreInfoUrl: String = item["moreInfoUrl"] as! String
			let speciesName: String = item["speciesName"] as! String
			let totalCount: Int = item["totalCount"] as? Int ?? 0
			return InsectModel(localePhoto: localePhoto, locate: locate, moreInfoUrl: moreInfoUrl, speciesName: speciesName, totalCount: totalCount)
		}
	}
}
	
