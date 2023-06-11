//
//  InsectCountRecordView.swift
//  Entomology
//
//  Created by Paul Pacheco on 9/06/23.
//

import SwiftUI

struct InsectCountRecordView: View {
	@EnvironmentObject var viewRouter: ViewRouter
	@State var count = 0
	@State var comment = ""
	@State private var isEditing = false
	@State var image = UIImage(named: "ant")!
	var body: some View {
		VStack {
			VStack {
				Spacer(minLength: 152)
				VStack {
					Text("\(String(format: "%02d", count))")
						.font(.custom("Roboto-Regular", size: 57))
						.padding(7)
				}.background(Color("counter_background"))
					.cornerRadius(8)
				HStack(spacing: 16) {
					Image(uiImage: image)
						.resizable()
						.scaledToFit()
					// .frame(width: 45, height: 45)
					Text("Especie")
						.font(.custom("Roboto-Regular", size: 16))
						.lineLimit(1)
					HStack(spacing: 48) {
						MaterialFabButton(action: { if count >= 1 { count -= 1 }}, icon: "minus", color: "fab_minus_background")
						MaterialFabButton(action: { count += 1 }, icon: "plus")
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
						MaterialButton(text: "Guardar", action: { viewRouter.returnToHome = false })
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
		
	}
}

struct InsectCountRecordView_Previews: PreviewProvider {
	static var previews: some View {
		InsectCountRecordView()
			.environmentObject(ViewRouter())
	}
}
