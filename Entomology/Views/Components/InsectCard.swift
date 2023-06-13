//
//  InsectCard.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import MapKit
import SwiftUI

struct InsectCard: View {
	var name: String
	var count: Int
	var image: UIImage = .init(named: "ant")!
	var body: some View {
		HStack(spacing: 16) {
			ZStack {
				Circle().foregroundColor(Color("font_primary")).frame(width: 40, height: 40)
				Text("\(String(format: "%02d", count))")
					.foregroundColor(.white)
			}.padding(.leading, 16)
			VStack(alignment: .leading, spacing: 4) {
				Text("Hormiga")
					.font(.custom("Roboto-Medium", size: 16))
				Text("Ciudad 00/00/0000")
					.font(.custom("Roboto-Regular", size: 14))
			}.frame(maxWidth: .infinity, alignment: .leading)
			Spacer()
			Image(uiImage: image)
				.resizable()
				.scaledToFit()
		}
		.background(Color("card_background"))
		.cornerRadius(12)
		.frame(height: 80)
		.listRowSeparator(.hidden)
		.listRowBackground(Color("background"))
		.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
	}
}

struct InsectDetailCard: View {
	var name: String
	var count: Int
	var image: UIImage = .init(named: "ant")!
	var url: String
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
					Text("Hormiga")
						.font(.custom("Roboto-Medium", size: 16))
					Text("Ciudad 00/00/0000")
						.font(.custom("Roboto-Regular", size: 14))
				}.frame(maxWidth: .infinity, alignment: .leading)
				Spacer()
				Image(uiImage: image)
					.resizable()
					.scaledToFit()
			}
			.frame(height: 80)
			.listRowSeparator(.hidden)
			.listRowBackground(Color("background"))
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
			Map(coordinateRegion: $location)
				.frame(height: 204)
			Text("El comentario que se realizara para el conteo")
				.font(.custom("Roboto-Regular", size: 16))
				.padding(16)
			Text("Url: \(url)")
				.padding(16)
			HStack {
				Spacer()
				MaterialButton(text: "Guardar", action: {})
				MaterialButton(text: "Editar", action: {})
			}.padding(16)
		}
		.background(Color("card_background"))
		.cornerRadius(12)
	}
}

struct InsectCard_Previews: PreviewProvider {
	static var previews: some View {
		let coordinates = CLLocationCoordinate2D(latitude: 35.30487705019497, longitude: 139.48254879527659)
		let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
		InsectCard(name: "Hormiga", count: 3)
		InsectDetailCard(name: "Hormiga", count: 5, url: "", location: .constant(region))
	}
}
