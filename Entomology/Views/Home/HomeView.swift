//
//  HomeView.swift
//  Entomology
//
//  Created by Paul Pacheco on 5/06/23.
//

import MapKit
import SwiftUI
import SwiftPrettyPrint
import MountainViewUI

struct HomeView: View {
	internal let inspection = Inspection<Self>()
	
	@Environment(\.managedObjectContext) private var viewContext
	@EnvironmentObject var entomologistViewModel: EntomologistViewModel
	@EnvironmentObject var viewRouter: ViewRouter

	@FetchRequest(fetchRequest: CountRecord.getByDate())
	private var countRecordsResults: FetchedResults<CountRecord>
	
	@State var listInsectsCount: [InsectModel] = []
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
	@State var showRecords: Bool = true

	var body: some View {
		let current = entomologistViewModel.currentEntomologist
		NavigationView {
			VStack(spacing: 0) {
				VStack(spacing: 0) {
					// Image Profile
					HStack {
						if let image = current?.urlPhoto {
							Image(uiImage: UIImage(data: image)!)
								.resizable()
								.scaledToFill()
								.clipShape(Circle())
								.frame(width: 65, height: 65)
								.accessibilityIdentifier("profileImage")
						} else {
							Image("newphoto")
								.resizable()
								.scaledToFill()
								.clipShape(Circle())
								.frame(width: 65, height: 65)
								.accessibilityIdentifier("profileImagePlaceholder")
						}
						Spacer()
					}.padding(.bottom, 24)
					// Record Section
					if showRecords {
						VStack {
							HStack(spacing: 16) {
								Image(systemName: "circle.fill")
									.font(.custom("", size: 12))
									.foregroundColor(.black.opacity(0.8))
								Text("Nuevo conteo")
									.accessibilityIdentifier("new_count_label")
									.foregroundColor(Color("font_label_primary"))
								Spacer()
								NavigationLink(destination: InsectFormView(), isActive: $viewRouter.returnToHome) {
									Image(systemName: "plus")
								}
								.buttonStyle(MaterialFabButtonStyle())
								.accessibilityIdentifier("new_count_record_button")
							}
							.padding(.horizontal, 16.0)
							.frame(maxWidth: .infinity, maxHeight: 80)
							.background(Color("bar_background"))
							.padding(.bottom, 16)
							VStack {
								List(countRecordsResults) {
									CardCountRecord(
										name: $0.insect?.speciesName ?? "",
										count: $0.count, location: $0.location,
										localeImage: $0.insect?.localePhoto,
										imageUrl: $0.insect?.urlPhoto ?? "",
										countRecord: $0
									)
									.listRowSeparator(.hidden)
									.accessibilityIdentifier("item_list_\($0.id)")
								}
								.accessibilityIdentifier("list_home")
								.listRowBackground(Color.red)
								.listStyle(.plain)
							}
							.accessibilityIdentifier("list_holder")
							.padding(.bottom, 16)
						}
					} else {
						VStack {
							ReportByInsect(insects: $listInsectsCount)
								.frame(height: 468)
								.onAppear {
									loadResumeBySpecimen()
								}
							Spacer()
						}
					}
					HStack {
						if !showRecords {
							MountainViewButton(text: "Informes", action: {}, buttonStyle: MountainOutlinedButtonStyle())
							Spacer()
							MountainViewButton(text: "Registros", action: {showRecords.toggle()}, buttonStyle: MountainButtonStyle())
						} else {
							MountainViewButton(text: "Informes", action: {showRecords.toggle()
							}, buttonStyle: MountainButtonStyle())
							Spacer()
							MountainViewButton(text: "Registros", action: {}, buttonStyle: MountainOutlinedButtonStyle())
						}
					}.padding(.horizontal, 25)
				}.padding(.horizontal, 26)
			}.backgroundColor(Color("background"))
		}
		.onAppear {
			entomologistViewModel.getUser()
		}
		.onReceive(inspection.notice) {
			self.inspection.visit(self, $0)
		}
	}
	
	private func loadResumeBySpecimen() {
		let listDict = Insect.fetchTotalCountPerInsect()
		listInsectsCount = InsectModel.convertToModel(for: listDict ?? [])
		Pretty.prettyPrint($listInsectsCount)
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
			HomeView()
				.environmentObject(EntomologistViewModel())
				.environmentObject(ViewRouter())
				.environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext)
	}
}
