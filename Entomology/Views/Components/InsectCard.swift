//
//  InsectCard.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import MapKit
import SwiftUI

struct InsectCard: View {
	var name: String
	var count: Int
	var location: String
	var imageData: Data?
	var imageUrl: String
	var body: some View {
		HStack(spacing: 16) {
			ZStack {
				Circle().foregroundColor(Color("font_primary")).frame(width: 40, height: 40)
				Text("\(String(format: "%02d", count))")
					.foregroundColor(.white)
			}.padding(.leading, 16)
			VStack(alignment: .leading, spacing: 4) {
				Text("\(name)")
					.font(.custom("Roboto-Medium", size: 16))
				Text("\(location) 00/00/0000")
					.font(.custom("Roboto-Regular", size: 14))
			}.frame(maxWidth: .infinity, alignment: .leading)
			Spacer()
			if let imageData {
				Image(uiImage: UIImage(data: imageData)!)
					.resizable()
					.scaledToFit()
			} else {
				AsyncImage(url: URL(string: imageUrl)!) { image in
					image.resizable()

				} placeholder: {
					ProgressView()
				}
			}
		}
		.background(Color("card_background"))
		.cornerRadius(12)
		.frame(height: 80)
		.listRowSeparator(.hidden)
		.listRowBackground(Color("background"))
		.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
	}
}

struct InsectCard_Previews: PreviewProvider {
	static var previews: some View {

		InsectCard(name: "Hormiga", count: 3, location: "Narnia", imageData: nil, imageUrl: "https://static01.nyt.com/images/2017/05/17/pageoneplus/17a2_video/sciencetake-bee-pollen2-superJumbo.jpg")
	}
}
