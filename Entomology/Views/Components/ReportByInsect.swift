//
//  ReportByInsect.swift
//  Entomology
//
//  Created by Paul Pacheco on 25/07/23.
//

import SwiftUI

struct ReportCountItem: View {
	//var text: String = ""
	//var image: UIImage = UIImage(named: "ant")!
	var insect: InsectModel
	var geospace: GeometryProxy
	
	var body: some View {
		HStack(spacing: 16) {
			ZStack {
				// Text("\(String(format: "%02d", count))")
				Text("\(String(format: "%02d", insect.totalCount))")
					.zIndex(2)
				Circle()
					.foregroundColor(.green)
					.zIndex(1)
					.frame(height: 40)
			}
			Text("\(insect.speciesName)")
			Spacer()
			if let image = UIImage(data: insect.localePhoto) {
				Image(uiImage: image)
					.resizable()
					.scaledToFill()
					.clipShape(Circle())
					.frame(width: 50, height: 50)
					.clipped()
			} else {
				Image("ant")
			}
		}
		.frame(height: geospace.size.height * 0.1)
		//.padding()
		.listRowBackground(Color.clear)
		.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
	}
}

struct ReportByInsect: View {
	@Binding var insects: [InsectModel]
    var body: some View {
		GeometryReader { geo in
			VStack(spacing: 0) {
				Text("Tu resumen")
					.font(.custom("Roboto-regular", size: 24))
					.foregroundColor(Color(red: 0.1, green: 0.11, blue: 0.1))
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.all, 24)
				List {
						ForEach(insects, id: \.self) { item in
							ReportCountItem(insect: item, geospace: geo)
								.padding(.horizontal, 16)
								.padding(.vertical, 4)
						}.listStyle(.plain)
					
				}
				.listStyle(.plain)
				
			}
			.background(Color(red: 0, green: 0.43, blue: 0.19).opacity(0.11))
			.background(Color(red: 0.99, green: 0.99, blue: 0.97))
			.cornerRadius(28)
			.frame(maxWidth: .infinity)
		}
    }
}

struct ReportByInsect_Previews: PreviewProvider {
    static var previews: some View {
		let imageData = UIImage(named: "ant")!.pngData()
		let data = [
			[
				"localePhoto": imageData,
				"locate": "Fujisawa, Japan",
				"moreInfoUrl": "-",
				"speciesName": "Hormiga",
				"totalCount": 19
			] as [String : Any],
			[
				"localePhoto": imageData,
				"locate": "Tokyo, Japan",
				"moreInfoUrl": "-",
				"speciesName": "Hormiga 2",
				"totalCount": 29
			]
		]
		
		let list = InsectModel.convertToModel(for: data)
		
		return ReportByInsect(insects: .constant(list))
			.backgroundColor(Color("background"))
    }
}
