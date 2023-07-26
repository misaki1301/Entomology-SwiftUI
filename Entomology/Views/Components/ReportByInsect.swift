//
//  ReportByInsect.swift
//  Entomology
//
//  Created by Paul Pacheco on 25/07/23.
//

import SwiftUI

struct ReportCountItem: View {
	var text: String = ""
	var image: UIImage = UIImage(named: "ant")!
	var geospace: GeometryProxy
	
	var body: some View {
		HStack(spacing: 16) {
			ZStack {
				Text("103")
					.zIndex(2)
				Circle()
					.foregroundColor(.green)
					.zIndex(1)
					.frame(height: 40)
			}
			Text("Especie nombre")
			Spacer()
			Image("ant")
				.resizable()
				.scaledToFill()
				.clipShape(Circle())
				.frame(width: 50, height: 50)
				.clipped()
		}
		.frame(height: geospace.size.height * 0.1)
		//.padding()
		.listRowBackground(Color.clear)
		.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
	}
}

struct ReportByInsect: View {
    var body: some View {
		GeometryReader { geo in
			VStack {
				List {
					Section {
						ReportCountItem(geospace: geo)
						ReportCountItem(geospace: geo)
					} header: {
						Text("Tu resumen")
							.font(.custom("Roboto-regular", size: 24))
							.foregroundColor(Color(red: 0.1, green: 0.11, blue: 0.1))
							.frame(maxWidth: .infinity, alignment: .leading)
							.padding(.all, 24)
					}
					
				}
				.listStyle(.plain)
				
			}
			.background(Color(red: 0, green: 0.43, blue: 0.19).opacity(0.11))
			.background(Color(red: 0.99, green: 0.99, blue: 0.97))
			.frame(maxWidth: .infinity)
		}
    }
}

struct ReportByInsect_Previews: PreviewProvider {
    static var previews: some View {
        ReportByInsect()
			.backgroundColor(Color("background"))
    }
}
