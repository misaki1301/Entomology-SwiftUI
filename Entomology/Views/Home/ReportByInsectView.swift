//
//  ReportByInsectView.swift
//  Entomology
//
//  Created by Paul Frank Pacheco Carpio on 21/08/23.
//

import SwiftUI
import MountainViewUI
import MapKit

struct CityLocations {
	var latitude: Double
	var longitude: Double
	var location: String
}

struct TotalReportInsectCard: View {
	var insect: InsectCount?
	@State private var region: MKCoordinateRegion = MKCoordinateRegion()
	var body: some View {
		MountainCardView(padding: 0) {
			VStack(alignment: .leading, spacing: 0) {
				HStack(spacing: 16) {
					ZStack {
						Circle().foregroundColor(Color("font_primary")).frame(width: 40, height: 40)
						Text("\(String(format: "%02d", insect?.count ?? 0))")
							.foregroundColor(.white)
					}
					.padding(.leading, 16)
					VStack(alignment: .leading) {
						Text("\(insect?.name ?? "")")
						Text("\(insect?.locations.count ?? 0) ciudades")
						Text("\(insect?.createdAt.formatted(date: .abbreviated, time: .omitted) ?? Date().formatted(date: .abbreviated, time: .omitted) )")
					}
					Spacer()
					if let data = insect?.imageData {
						Image(uiImage: UIImage(data: (insect?.imageData)!)!)
							.resizable()
							.scaledToFill()
							.frame(width: 68, height: 68, alignment: .center)
							.clipped()
					} else {
						AsyncImage(url: URL(string: insect?.imageUrl ?? "")) { img in
							img
								.resizable()
								.scaledToFill()
								.frame(width: 68, height: 68, alignment: .center)
								.clipped()
						} placeholder: {
							ProgressView()
						}
					}
				}
				Map(coordinateRegion: $region,
					interactionModes: .pan, annotationItems: insect?.locations.map({item in
					AnnotatedItem(name: item.location, coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
				}) ?? []) { location in
					MapPin(coordinate: location.coordinate, tint: .red)
				}.frame(height: 188)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.onAppear {
					print("PTMR")
//					guard let count = insect?.locations.count else {
//						return
//					}
					let count = insect?.locations.count ?? 0
					var totalLong: Double = 0
					var totalLat: Double = 0
					for location in insect?.locations ?? [] {
						totalLong += location.longitude
						totalLat += location.latitude
					}
					region.center = CLLocationCoordinate2D(
						latitude: totalLat / Double(count),
						longitude: totalLong / Double(count))
					  region.span = MKCoordinateSpan(
						latitudeDelta: 90, longitudeDelta: 180)
				}
				Text("\(insect?.description ?? "")")
					.padding(16)
			}
	}
	}

struct InsectCount {
	var name: String
	var count: Int
	var location: String
	var imageData: Data?
	var imageUrl: String
	var createdAt: Date
	var description: String
	var locations: [CityLocations]
}

struct ReportByInsectView: View {
	internal let inspection = Inspection<Self>()
	@FetchRequest
	private var countRecords: FetchedResults<CountRecord>
	var insectName: String
	@State
	var locations: [CityLocations] = []
	@State
	var record: InsectCount?
	
	init(insectName: String) {
		self.insectName = insectName
		_countRecords = FetchRequest(fetchRequest: CountRecord.getByName(for: insectName))
		getLocations()
	}
	
    var body: some View {
		ScrollView {
			VStack {
				if record?.locations.count ?? 0 > 0 {
					TotalReportInsectCard(insect: record)
				ForEach(countRecords, id: \.id) { record in
					InsectCard(name: record.insect?.speciesName ?? "", count: record.count, location: record.location, imageData: record.insect?.localePhoto, imageUrl: record.insect?.urlPhoto ?? "")
				}
				} else {
					Image(systemName: "shippingbox.fill")
					Text("No hay registros previos")
				}
			}
		}
		.onAppear {
				getLocations()
		}
		.onReceive(inspection.notice) {
			self.inspection.visit(self, $0)
		}
		.padding(.horizontal, 26)
		.backgroundColor(Color("background"))
    }
	
	private func getLocations() {
		if !countRecords.isEmpty {
			guard let item = countRecords.first else {
				return
			}
			record = InsectCount(
				name: item.insect?.speciesName ?? "",
				count: 0,
				location: item.location,
				imageData: item.insect?.localePhoto,
				imageUrl: item.insect?.urlPhoto ?? "",
				createdAt: item.createdAt,
				description: item.insect?.moreInfoUrl ?? "",
				locations: [])
			record?.count = countRecords.reduce(0, {x, y in x + y.count})
			
			locations = countRecords.map({ item in
				
				return CityLocations(latitude: item.geolocate?.latitude ?? 0, longitude: item.geolocate?.longitude ?? 0, location: item.location)
			})
			record?.locations = locations
			//print(locations)
		}
	}
}

struct ReportByInsectView_Previews: PreviewProvider {
    static var previews: some View {
		ReportByInsectView(insectName: "Morpho")
			.environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}
