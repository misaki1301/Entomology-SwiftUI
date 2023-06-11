//
//  InsectDetailView.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import MapKit
import SwiftUI

struct InsectDetailView: View {
	@State private var region: MKCoordinateRegion = MKCoordinateRegion(
		center: CLLocationCoordinate2D(
			latitude: 35.30487705019497,
			longitude: 139.48254879527659),
		span: MKCoordinateSpan(
			latitudeDelta: 0.02,
			longitudeDelta: 0.02
		)
	)

	var body: some View {
		VStack {
			InsectDetailCard(name: "Hormiga", count: 5, url: "", location: $region)
				.padding(.horizontal, 26)
		}.backgroundColor(Color("background"))
	}
}

struct InsectDetailView_Previews: PreviewProvider {
	static var previews: some View {
		let coordinates = CLLocationCoordinate2D(latitude: 35.30487705019497, longitude: 139.48254879527659)
		let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
		let region = MKCoordinateRegion(center: coordinates, span: span)
		//InsectDetailView(region: region)
		InsectDetailView()
	}
}
