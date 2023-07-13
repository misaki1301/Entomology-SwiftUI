//
//  CardCountRecord.swift
//  Entomology
//
//  Created by Paul Pacheco on 21/06/23.
//

import SwiftUI

struct CardCountRecord: View {
	var name = ""
	var count = 0
	var location = ""
	var localeImage: Data?
	var imageUrl: String
	var countRecord: CountRecord
	var body: some View {
		ZStack {
			NavigationLink(destination: InsectDetailView(record: countRecord)) {
				EmptyView()
			}.opacity(0)
			InsectCard(name: name, count: count, location: location, imageData: localeImage, imageUrl: imageUrl)
		}
		.listRowBackground(Color.clear)
		.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
		.padding(.bottom, 16)
	}
}

struct CardCountRecord_Previews: PreviewProvider {
    static var previews: some View {
		let context = CoreDataProvider.preview.viewContext
		let record = CountRecord(context: context)
		record.count = 5
		let insect = Insect(context: context)
		insect.speciesName = "Abeja"
		record.insect = insect
		let localeImage = UIImage(named: "ant")?.pngData()
		return CardCountRecord(name: insect.speciesName ?? "", count: record.count, location: "Lima, Peru", localeImage: localeImage, imageUrl: "", countRecord: record)
			.padding(.horizontal, 26)
    }
}
