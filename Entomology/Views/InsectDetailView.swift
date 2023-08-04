//
//  InsectDetailView.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import MapKit
import SwiftUI

struct InsectDetailView: View {
	internal let inspection = Inspection<Self>()
	@State var record: CountRecord
	@State private var region: MKCoordinateRegion
	
	init(record: CountRecord) {
		let coordinate = CLLocationCoordinate2D(latitude: record.geolocate?.latitude ?? 0, longitude: record.geolocate?.longitude ?? 0)
		self.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
		self.record = record
		//self.region = record.geo
	}

	var body: some View {
		VStack {
			InsectDetailCard(
				name: record.insect?.speciesName ?? "",
				count: record.count,
				image: record.insect?.localePhoto,
				imageUrl: record.insect?.urlPhoto ?? "",
				url: record.insect?.moreInfoUrl ?? "",
				createdAt: record.createdAt,
				comment: record.comment,
				city: record.location,
				latitude: record.geolocate?.latitude ?? 0,
				longitude: record.geolocate?.longitude ?? 0,
				record: $record, location: $region
			)
			.padding(.horizontal, 26)
		}.onAppear {
			let coordinate = CLLocationCoordinate2D(latitude: record.geolocate?.latitude ?? 0, longitude: record.geolocate?.longitude ?? 0)
			region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
		}
		.onReceive(inspection.notice) {
			self.inspection.visit(self, $0)
		}
		.backgroundColor(Color("background"))
	}
}

struct InsectDetailView_Previews: PreviewProvider {
	static var previews: some View {
		let record = CountRecord(context: CoreDataProvider.preview.viewContext)
		record.comment = "Este es un ejemplo de comentario para preview"
		record.count = 5
		record.createdAt = Date()
		record.location = "Narnia"
		let insect = Insect(context: CoreDataProvider.preview.viewContext)
		insect.speciesName = "Abeja"
		insect.urlPhoto = "https://static.wikia.nocookie.net/agustin-sepulveda-fanon/images/7/7b/Abeja.png/revision/latest/thumbnail/width/360/height/360?cb=20180620011627&path-prefix=es"
		let coordinates = CLLocationCoordinate2D(latitude: 35.30487705019497, longitude: 139.48254879527659)
		let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
		let locate = GeoLocate(context: CoreDataProvider.preview.viewContext)
		locate.latitude = 35.30487705019497
		locate.longitude = 139.48254879527659
		record.geolocate = locate
		record.insect = insect

		return InsectDetailView(record: record)
	}
}
