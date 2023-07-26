//
//  InsectDetailCard.swift
//  Entomology
//
//  Created by Paul Pacheco on 21/06/23.
//

import MapKit
import SwiftUI

struct AnnotatedItem: Identifiable {
	let id = UUID()
	var name: String
	var coordinate: CLLocationCoordinate2D
}

struct InsectDetailCard: View {
	var name: String
	var count: Int
	var image: Data?
	var imageUrl: String
	var url: String
	var createdAt: Date = .init()
	var comment: String = ""
	var city: String?
	var latitude: Double
	var longitude: Double
	@Binding var location: MKCoordinateRegion
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			HStack(spacing: 16) {
				ZStack {
					Circle().foregroundColor(Color("font_primary")).frame(width: 40, height: 40)
					Text("\(String(format: "%02d", count))")
						.foregroundColor(.white)
				}.padding(.leading, 16)
				VStack(alignment: .leading, spacing: 4) {
					Text("\(name)")
						.font(.custom("Roboto-Medium", size: 16))
						.foregroundColor(Color("font_label_primary"))
					Text("\(city ?? "lugar desconocido") \(createdAt.formatted(date: .numeric, time: .omitted))")
						.font(.custom("Roboto-Regular", size: 14))
						.foregroundColor(Color("font_label_primary"))
				}.frame(maxWidth: .infinity, alignment: .leading)
				Spacer()
				if let image {
					Image(uiImage: UIImage(data: image)!)
						.resizable()
						.scaledToFit()
				} else {
					if let url = URL(string: imageUrl) {
						AsyncImage(url: url) { image in
							image.resizable()
								.scaledToFit()

						} placeholder: {
							ProgressView()
						}
					} else {
						Image("ant")
							.scaledToFit()
					}
				}
			}
			.frame(height: 80)
			.listRowSeparator(.hidden)
			.listRowBackground(Color("background"))
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
			Map(coordinateRegion: $location, annotationItems: [AnnotatedItem(name: "Record", coordinate: .init(latitude: latitude, longitude: longitude))]) {
				MapMarker(coordinate: $0.coordinate, tint: .green)
			}
			.frame(height: 204)
			Text("\(comment)")
				.font(.custom("Roboto-Regular", size: 16))
				.foregroundColor(Color("font_label_primary"))
				.padding(16)
			Text("Url: \(url)")
				.foregroundColor(Color("font_label_primary"))
				.padding(16)
			HStack {
				Spacer()
				MaterialOutlinedButton(text: "Guardar", action: {})
				MaterialFlatButton(text: "Editar", action: {})
			}.padding(16)
		}
		.background(Color("card_background"))
		.cornerRadius(12)
	}
}

struct InsectDetailCard_Previews: PreviewProvider {
	static var previews: some View {
		let coordinates = CLLocationCoordinate2D(latitude: 35.30487705019497, longitude: 139.48254879527659)
		let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
		let image = "https://es.wikipedia.org/wiki/Morpho#/media/Archivo:Morpho_didius_Male_Dos_MHNT.jpg"
		return InsectDetailCard(
			name: "Hormiga",
			count: 5,
			image: nil,
			imageUrl: image,
			url: "",
			comment: "",
			city: "Lando, Canada",
			latitude: 31.231,
			longitude: -123.22,
			location: .constant(region))
	}
}
