//
//  CountRecordModel.swift
//  Entomology
//
//  Created by Paul Pacheco on 29/06/23.
//

import Foundation

struct CountRecordModel {
	var count: Int
	var comment: String
	var geoLocate: String
	var createdAt: Date
	var updatedAt: Date?
	var insect: InsectModel
	var entomologist: EntomologistModel
}
