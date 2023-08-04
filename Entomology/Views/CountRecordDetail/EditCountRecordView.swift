//
//  EditCountRecordView.swift
//  Entomology
//
//  Created by Paul Frank Pacheco Carpio on 4/08/23.
//

import SwiftUI

struct EditCountRecordView: View {
	internal let inspection = Inspection<Self>()
	@Environment(\.presentationMode) var presentationMode
	@Binding var record: CountRecord
	@State private var isEditing = false
    var body: some View {
		VStack {
			VStack {
				Spacer(minLength: 152)
				VStack {
					Text("\(String(format: "%02d", record.count))")
						.font(.custom("Roboto-Regular", size: 57))
						.padding(7)
						.accessibilityIdentifier("counter_text")
						.foregroundColor(Color("font_label_primary"))
				}.background(Color("counter_background"))
					.cornerRadius(8)
				HStack(spacing: 16) {
					if let image = record.insect?.localePhoto {
						Image(uiImage: UIImage(data: (record.insect?.localePhoto!)!)!)
							.resizable()
							.scaledToFit()
					} else {
						
					}
					Text("\(record.insect?.speciesName ?? "")")
						.font(.custom("Roboto-Regular", size: 16))
						.lineLimit(1)
						.foregroundColor(Color("font_label_primary"))
					HStack(spacing: 48) {
						MaterialFabButton(action: decrementCount, icon: "minus", color: "fab_minus_background")
							.accessibilityIdentifier("fab_minus")
						MaterialFabButton(action: incrementCount, icon: "plus")
							.accessibilityIdentifier("fab_plus")
					}.padding(.trailing, 16)
				}
				.frame(height: 80)
				.background(Color("bar_background"))
				.padding(.bottom, 46)
				if record.count > 0 {
					VStack {
						if #available(iOS 16, *) {
							TextEditor(text: $record.comment)
								.scrollContentBackground(.hidden)
								.background(Color.white)
								.lineLimit(3)
								.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditing))
								.frame(height: 184)
								.cornerRadius(16)
								.foregroundColor(Color("font_label_primary")).padding(.horizontal, 18)
								.padding(.bottom, 46)
						} else {
							TextEditor(text: $record.comment)
								.background(Color.white)
								.lineLimit(3)
								.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditing))
								.frame(height: 184)
								.cornerRadius(16)
								.foregroundColor(Color("font_label_primary"))
								.padding(.horizontal, 18)
								.padding(.bottom, 46)
						}}
					MaterialButton(text: "Guardar", action: editCountRecord)
				} else {
					Spacer(minLength: 282)
				}
			}
			Spacer(minLength: 130)
		}
		.onReceive(inspection.notice) {
			self.inspection.visit(self, $0)
		}
		.backgroundColor(Color("background"))
    }
	private func incrementCount() {
		record.count += 1
	}
	
	private func decrementCount() {
		if record.count >= 1 {
			record.count -= 1
		}
	}
	
	private func editCountRecord() {
		do {
			try record.save()
			presentationMode.wrappedValue.dismiss()
							DispatchQueue.main.async {
								presentationMode.wrappedValue.dismiss()
							}
		} catch let error as NSError {
			fatalError("Save on existing record error : \(error.localizedDescription)")
		}
	}
}

struct EditCountRecordView_Previews: PreviewProvider {
    static var previews: some View {
		let context = CoreDataProvider.currentContext
		let record = try! context.fetch(CountRecord.getByDate())[0]
		
		return EditCountRecordView(record: .constant(record))
			.environmentObject(ViewRouter())
    }
}
