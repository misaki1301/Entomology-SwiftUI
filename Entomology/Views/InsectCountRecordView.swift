//
//  InsectCountRecordView.swift
//  Entomology
//
//  Created by Paul Pacheco on 9/06/23.
//

import SwiftUI

struct InsectCountRecordView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@EnvironmentObject var viewRouter: ViewRouter
	@EnvironmentObject var entomologistViewModel: EntomologistViewModel
	@EnvironmentObject var locationViewModel: LocationViewModel
	internal let inspection = Inspection<Self>()
	@State var name = "Especie"
	@State var image = UIImage(named: "ant")!
	@State var count = 0
	@State var url = ""
	@State var comment = ""
	@State private var isEditing = false

	var body: some View {
		VStack {
			HStack {
				Text("Location")
				Text("\(locationViewModel.currentPlacemark?.locality ?? "unkwown country") \(locationViewModel.currentPlacemark?.country ?? "unkwown country")")
			}
			VStack {
				Spacer(minLength: 152)
				VStack {
					Text("\(String(format: "%02d", count))")
						.font(.custom("Roboto-Regular", size: 57))
						.padding(7)
						.accessibilityIdentifier("counter_text")
						.foregroundColor(Color("font_label_primary"))
				}.background(Color("counter_background"))
					.cornerRadius(8)
				HStack(spacing: 16) {
					Image(uiImage: image)
						.resizable()
						.scaledToFit()
					Text("\(name)")
						.font(.custom("Roboto-Regular", size: 16))
						.lineLimit(1)
						.foregroundColor(Color("font_label_primary"))
					HStack(spacing: 48) {
						MaterialFabButton(action: incrementCount, icon: "minus", color: "fab_minus_background")
							.accessibilityIdentifier("fab_minus")
						MaterialFabButton(action: incrementCount, icon: "plus")
							.accessibilityIdentifier("fab_plus")
					}.padding(.trailing, 16)
				}
				.frame(height: 80)
				.background(Color("bar_background"))
				.padding(.bottom, 46)
				if count > 0 {
					VStack {
						TextEditor(text: $comment)
							.scrollContentBackground(.hidden)
							.background(Color.white)
							.lineLimit(3)
							.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditing))
							.frame(height: 184)
							.cornerRadius(16)
							.foregroundColor(Color("font_label_primary")).padding(.horizontal, 18)
							.padding(.bottom, 46)
						MaterialButton(text: "Guardar", action: saveToEntomologist)
					}
				} else {
					Spacer(minLength: 282)
				}
			}
			Spacer(minLength: 130)
		}
		.onAppear {
			Task {
				let location = locationViewModel.lastSeenLocation
				await locationViewModel.fetchCountryAndCity(for: location)
			}
		}
		.onReceive(inspection.notice) {
			self.inspection.visit(self, $0)
		}
		.padding(16)
		.backgroundColor(Color("background"))
	}

	private func incrementCount() {
		if count >= 1 {
			count -= 1
		} else {
			count += 1
		}
	}
	
	private func saveToEntomologist() {
		do {
			let lastSeenLocation = locationViewModel.lastSeenLocation
			let place = locationViewModel.currentPlacemark
			let insect1 = Insect(context: viewContext)
			insect1.geoLocate = "\(place?.locality ?? "Unknown city"), \(place?.country ?? "Unknown country")"
			insect1.moreInfoUrl = url
			insect1.speciesName = name
			insect1.localePhoto = image.pngData()
			// try viewContext.save()
			let locate = GeoLocate(context: viewContext)
			locate.latitude = lastSeenLocation?.coordinate.latitude ?? 0
			locate.longitude = lastSeenLocation?.coordinate.longitude ?? 0
			let newRecord = CountRecord(context: viewContext)
			newRecord.comment = comment
			newRecord.count = count
			newRecord.createdAt = Date()
			newRecord.entomologist = entomologistViewModel.currentEntomologist
			newRecord.location = "\(place?.locality ?? "Unknown city"), \(place?.country ?? "Unknown country")"
			newRecord.insect = insect1
			newRecord.geolocate = locate
			try viewContext.save()
			entomologistViewModel.getUser()
			viewRouter.returnToHome = false
		} catch let error as NSError {
			// swiftlint:disable:next no_direct_standard_out_logs
			print("Save error: \(error), \(error.userInfo)")
		}
	}
}

struct InsectCountRecordView_Previews: PreviewProvider {
	static var previews: some View {
		InsectCountRecordView()
			.environmentObject(ViewRouter())
			.environmentObject(EntomologistViewModel())
			.environmentObject(LocationViewModel())
			.environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext)
	}
}
