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
	var date: Date = .init()

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
					.foregroundColor(Color("font_label_primary"))
					.frame(maxWidth: .infinity, alignment: .leading)
				Text("\(location) \(date.formatted(date: .numeric, time: .omitted))")
					.font(.custom("Roboto-Regular", size: 14))
					.foregroundColor(Color("font_label_primary"))
					.frame(maxWidth: .infinity, alignment: .leading)
			}.frame(maxWidth: .infinity, alignment: .leading)
			//Spacer()
			if let imageData {
				Image(uiImage: UIImage(data: imageData)!)
					.resizable()
					.scaledToFill()
					.frame(width: 80, height: 80, alignment: .center)
					.clipped()
					
			} else {
				AsyncImage(url: URL(string: imageUrl)!) { image in
					image.resizable()
						.scaledToFill()
						.frame(width: 80, height: 80, alignment: .center)
						.clipped()
						
				} placeholder: {
					ProgressView()
				}
			}
		}
		.background(Color("card_background"))
		.cornerRadius(12)
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.inset(by: 0.5)
				.stroke(Color(red: 0.76, green: 0.79, blue: 0.75), lineWidth: 1)
		)
		.frame(height: 80)
		.clipped()
		.listRowSeparator(.hidden)
		.listRowBackground(Color("background"))
		.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
	}
}

struct InsectCard_Previews: PreviewProvider {
	static var previews: some View {
		InsectCard(
			name: "Hormiga",
			count: 3,
			location: "Narnia",
			imageData: nil,
			imageUrl: "https://static01.nyt.com/images/2017/05/17/pageoneplus/17a2_video/sciencetake-bee-pollen2-superJumbo.jpg",
			date: Date()
		)
		.padding(.horizontal, 26)
	}
}
