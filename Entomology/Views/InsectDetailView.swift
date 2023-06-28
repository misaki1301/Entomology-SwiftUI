//
//  InsectDetailView.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import MapKit
import SwiftUI

struct InsectDetailView: View {
	@State var record: CountRecord
	@State var region: MKCoordinateRegion = .init(
		center: CLLocationCoordinate2D(
			latitude: 35.30487705019497,
			longitude: 139.48254879527659
		),
		span: MKCoordinateSpan(
			latitudeDelta: 0.02,
			longitudeDelta: 0.02
		)
	)

	var body: some View {
		VStack {
			InsectDetailCard(
				name: record.insect?.speciesName ?? "",
				count: record.count,
				imageUrl: record.insect?.urlPhoto ?? "",
				url: record.insect?.moreInfoUrl ?? "",
				location: $region
			)
			.padding(.horizontal, 26)
		}.backgroundColor(Color("background"))
	}
}

struct InsectDetailView_Previews: PreviewProvider {
	static var previews: some View {
		let record = CountRecord(context: CoreDataProvider.preview.viewContext)
		record.comment = "Este es un ejemplo de comentario para preview"
		record.count = 5
		record.geoLocate = "Narnia"
		let insect = Insect(context: CoreDataProvider.preview.viewContext)
		insect.speciesName = "Abeja"
		insect.urlPhoto = "https://static.wikia.nocookie.net/agustin-sepulveda-fanon/images/7/7b/Abeja.png/revision/latest/thumbnail/width/360/height/360?cb=20180620011627&path-prefix=es"
		let coordinates = CLLocationCoordinate2D(latitude: 35.30487705019497, longitude: 139.48254879527659)
		let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
		let region = MKCoordinateRegion(center: coordinates, span: span)

		return InsectDetailView(record: record, region: region)
	}
}
