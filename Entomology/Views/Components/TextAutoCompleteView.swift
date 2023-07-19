//
//  TextAutoCompleteView.swift
//  Entomology
//
//  Created by Paul Pacheco on 13/07/23.
//

import SwiftUI

struct MenuItem: View {
	var text = ""
	var body: some View {
		Text(text)
			.font(.custom("Roboto-Regular", size: 16))
			.padding(.horizontal, 16)
			.padding(.vertical, 8)
			//.frame(height: 56)
	}
}

struct ClearButton: ViewModifier {
	@Binding var text: String
	func body(content: Content) -> some View {
		ZStack(alignment: .trailing) {
			content

			if !text.isEmpty {
				Button(action: { text = "" }) {
					Image(systemName: "multiply.circle.fill")
						.foregroundStyle(.gray)
				}
				.padding(.trailing, 8)
			}
		}
	}
}

extension View {
	func clearButton(text: Binding<String>) -> some View {
		modifier(ClearButton(text: text))
	}
}

struct TextAutoCompleteView: View {
	@FetchRequest
	private var insects: FetchedResults<Insect>
	
	@Binding var text: String
	@Binding var selected: Insect?
	@State private var isAnimated = false
	
	init(text: Binding<String>, selected: Binding<Insect?>) {
		self._selected = selected
		self._text = text
		_insects = FetchRequest(fetchRequest: Insect.searchByName(searchTerm: text.wrappedValue))
	}

	var body: some View {
		ZStack(alignment: .top) {
			TextField("Nombre de la especie", text: $text)
				.frame(width: 200, height: 56)
				.padding(.horizontal, 16)
				.clearButton(text: $text)
				.overlay {
				RoundedRectangle(cornerRadius: 4)
					.inset(by: 1)
					.stroke(Color(red: 0, green: 0.43, blue: 0.19), lineWidth: 2)
				}
				.overlay(alignment: .topLeading) {
					VStack {
						LazyVStack(alignment: .leading, spacing: 0) {
							ForEach(insects, id: \.self) { item in
								MenuItem(text: item.speciesName ?? "")
							}
							NavigationLink(destination: CreateInsectView()) {
								MenuItem(text: "Otro")
							}
						}
						.frame(width: 232)
						.background(Color("card_background"))
						.cornerRadius(4)
						.shadow(radius: 2)
						.offset(x: 0, y: 56)
						.zIndex(200)
						.opacity((!text.isEmpty || !insects.isEmpty) ? 1 : 0)
					}.onAppear {
						withAnimation(isAnimated ? .easeIn : .easeOut) {
							self.isAnimated.toggle()
						}
					}
				}
				.zIndex(200)
			}
	}
}

struct TextAutoCompleteView_Previews: PreviewProvider {
	static var previews: some View {
		let context = CoreDataProvider.preview.persistentContainer.viewContext
		TextAutoCompleteView(text: .constant("mor"), selected: .constant(Insect(context: context)))
			.backgroundColor(Color("background"))
			.environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext)
	}
}
