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
	@State var name = "Especie"
	@State var image = UIImage(named: "ant")!
	@State var count = 0
	@State var url = ""
	@State var comment = ""
	@State private var isEditing = false
	var body: some View {
		VStack {
			VStack {
				Spacer(minLength: 152)
				VStack {
					Text("\(String(format: "%02d", count))")
						.font(.custom("Roboto-Regular", size: 57))
						.padding(7)
						.accessibilityIdentifier("counter_text")
				}.background(Color("counter_background"))
					.cornerRadius(8)
				HStack(spacing: 16) {
					Image(uiImage: image)
						.resizable()
						.scaledToFit()
					// .frame(width: 45, height: 45)
					Text("\(name)")
						.font(.custom("Roboto-Regular", size: 16))
						.lineLimit(1)
					HStack(spacing: 48) {
						MaterialFabButton(action: { if count >= 1 { count -= 1 }}, icon: "minus", color: "fab_minus_background")
							.accessibilityIdentifier("fab_minus")
						MaterialFabButton(action: { count += 1 }, icon: "plus")
							.accessibilityIdentifier("fab_plus")
					}.padding(.trailing, 16)
				}
				.frame(height: 80)
				.background(Color("bar_background"))
				.padding(.bottom, 46)
				if count > 0 {
					VStack {
						TextEditor(text: $comment)
							.lineLimit(3)
							.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditing))
							.frame(height: 184)
							.padding(.horizontal, 18)
							.padding(.bottom, 46)
						MaterialButton(text: "Guardar", action: saveToEntomologist)
					}
					// Spacer()
				} else {
					Spacer(minLength: 282)
				}
			}
			Spacer(minLength: 130)
		}
		.padding(16)
		.backgroundColor(Color("background"))
	}
	private func saveToEntomologist() {
		do {
			let insect1 = Insect(context: viewContext)
			insect1.geoLocate = "Desconocido"
			insect1.moreInfoUrl = url
			insect1.speciesName = name
			insect1.localePhoto = image.pngData()
			//try viewContext.save()
			let newRecord = CountRecord(context: viewContext)
			newRecord.comment = comment
			newRecord.count = count
			newRecord.entomologist = entomologistViewModel.currentEntomologist
			newRecord.geoLocate = "Desconocido"
			newRecord.insect = insect1
			try viewContext.save()
			entomologistViewModel.getUser()
			viewRouter.returnToHome = false
		} catch let error as NSError {
			print("Save error: \(error), \(error.userInfo)")
		}
	}
}

struct InsectCountRecordView_Previews: PreviewProvider {
	static var previews: some View {
		InsectCountRecordView()
			.environmentObject(ViewRouter())
			.environmentObject(EntomologistViewModel())
			.environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext)
	}
}
