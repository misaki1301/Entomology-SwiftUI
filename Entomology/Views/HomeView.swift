//
//  HomeView.swift
//  Entomology
//
//  Created by Paul Pacheco on 5/06/23.
//

import MapKit
import SwiftUI

struct HomeView: View {
	@EnvironmentObject var entomologistViewModel: EntomologistViewModel
	@EnvironmentObject var viewRouter: ViewRouter
	@State private var region = MKCoordinateRegion(
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
		let current = entomologistViewModel.currentEntomologist
		NavigationView {
			VStack(spacing: 0) {
				VStack(spacing: 0) {
					HStack {
						if let image = current?.urlPhoto {
							Image(uiImage: UIImage(data: image)!)
								.resizable()
								.clipShape(Circle())
								.frame(width: 65, height: 65)
						} else {
							Image("newphoto")
								.resizable()
								.clipShape(Circle())
								.frame(width: 65, height: 65)
						}
						Spacer()
					}.padding(.bottom, 24)
					HStack(spacing: 16) {
						Text("Nuevo conteo")
						Spacer()
						NavigationLink(destination: InsectFormView(), isActive: $viewRouter.returnToHome) {
							Image(systemName: "plus")
						}.buttonStyle(MaterialFabButtonStyle())
					}
					.padding(.horizontal, 16.0)
					.frame(maxWidth: .infinity, maxHeight: 80)
					.background(Color("bar_background"))
					.padding(.bottom, 16)
					//Text("\(current?.countRecords?.count ?? 0)")
					VStack {
						List {
							ZStack {
								NavigationLink(destination: InsectDetailView()) {
									EmptyView()
								}.opacity(0)
								InsectCard(name: "Hormiga", count: 3)
							}
							.listRowBackground(Color.clear)
							.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
							.padding(.bottom, 16)
							ZStack {
								NavigationLink(destination: InsectDetailView()) {
									EmptyView()
								}.opacity(0)
								InsectCard(name: "Hormiga", count: 3)
							}
							.listRowBackground(Color.clear)
							.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
						}
						.listRowBackground(Color.red)
						.listStyle(.plain)
						.listRowSeparator(.hidden)
						// .listRowInsets()

					}.padding(.bottom, 16)
					HStack {
						MaterialButton(text: "Informes", action: {})
						Spacer()
						MaterialButton(text: "Registros", action: {})
					}
				}.padding(.horizontal, 26)
			}.backgroundColor(Color("background"))
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
			.environmentObject(EntomologistViewModel())
			.environmentObject(ViewRouter())
	}
}
