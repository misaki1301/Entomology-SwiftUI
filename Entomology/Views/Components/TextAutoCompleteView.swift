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
	}
}

struct ClearButton: ViewModifier {
	@Binding var text: String
	func body(content: Content) -> some View {
		ZStack(alignment: .trailing) {
			content
			
			if !text.isEmpty {
				Button(action: {text = ""}) {
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
	@State var text = ""
	@State var items = ["Abeja", "Hormiga"]
	
	init(text: String = "", items: [String] = ["Abeja", "Hormiga"]) {
		_insects =  FetchRequest(fetchRequest: Insect.searchByName(searchTerm: text))
		self.text = text
		self.items = items
	}
	
    var body: some View {
		ZStack(alignment: .leading) {
			VStack(alignment: .leading, spacing: 0) {
				TextField("Nombre de la especie", text: $text)
					.frame(width: 200, height: 56)
					.padding(.horizontal, 16)
					.clearButton(text: $text)
					.overlay {
						RoundedRectangle(cornerRadius: 4)
							.inset(by: 1)
							.stroke(Color(red: 0, green: 0.43, blue: 0.19), lineWidth: 2)
					}
				VStack(spacing: 0) {
					LazyVStack(alignment: .leading, spacing: 0) {
						ForEach(insects, id: \.self) { item in
							MenuItem(text: item.speciesName ?? "")
						}
						//this redirects to create insect
						MenuItem(text: "Otro")
						//Text("\(insects.count)")
					}
				}
				.frame(width: 200)
				.background(Color("card_background"))
				.cornerRadius(4)
				.shadow(radius: 2)
			}
		}
    }
}

struct TextAutoCompleteView_Previews: PreviewProvider {
    static var previews: some View {
		TextAutoCompleteView(text: "").backgroundColor(Color("background"))
			.environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext)
    }
}
