//
//  RegisterUserView.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import SwiftUI

struct RegisterUserView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@EnvironmentObject var locationViewModel: LocationViewModel
	@EnvironmentObject var entomologistViewModel: EntomologistViewModel
	@EnvironmentObject var viewRouter: ViewRouter
	@State private var isEditing: Bool = false
	@State private var username: String = ""
	// @State private var locationPermission: Bool = false
	@State private var profileImage: UIImage = .init(named: "newphoto")!
	@State private var showChangeImageProfile = false
	@State private var alertVisible = false

	private func saveEntomologist() {
		do {
			let entomologist = Entomologist(context: viewContext)
			entomologist.geoLocate = "Desconocido"
			print(locationViewModel.currentPlacemark?.locality)
			if let currentPlacemark = locationViewModel.currentPlacemark {
				entomologist.geoLocate = currentPlacemark.locality
			}
			entomologist.name = username
			entomologist.urlPhoto = profileImage.pngData()
			entomologistViewModel.saveEntomologist(for: entomologist)
			viewRouter.currentPage = .homePage
		} catch {
			print("error saving entomologist: \(error)")
		}
	}

	var body: some View {
		VStack {
			Spacer()
			Image(uiImage: profileImage)
				.resizable()
				.clipShape(Circle())
				.frame(width: 120, height: 120)
				.onTapGesture {
					showChangeImageProfile.toggle()
				}
				.sheet(isPresented: $showChangeImageProfile) {
					UserProfileImageView(imageProfile: $profileImage)
				}
			VStack(alignment: .leading) {
				Text("Nombre").padding(.leading, 34)
				TextField("Nombre", text: $username, onEditingChanged: { isEditing = $0 })
					.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditing))
			}
			.padding(.horizontal, 42)
			Spacer()
			HStack {
				HStack {
					Toggle("Location", isOn: $locationViewModel.isPermissionActive)
						.labelsHidden()
						.onTapGesture {
							locationViewModel.isPermissionActive.toggle()
							print("LOCATION \(locationViewModel.isPermissionActive)")
							if locationViewModel.authorizationStatus == .denied || locationViewModel.authorizationStatus == .restricted {
								alertVisible = true
							}
						}
						.onChange(of: locationViewModel.isPermissionActive) { _ in
							locationViewModel.requestPermission()
						}
					VStack(alignment: .leading) {
						Text("Compartenos tu ubicacion")
							.font(.custom("Roboto-Regular", size: 16))
							.foregroundColor(Color("textfield_font"))
						Text("Deja que Entomology conozca tu ubicacion para gestionar tus registros")
							.font(.custom("Roboto-Regular", size: 14))
							.foregroundColor(Color("textfield_font"))
					}.padding(.leading, 16)
				}.padding(.horizontal, 24)
					.padding(.vertical, 12)
			}.background(Color("card_background"))
				.padding(.horizontal, 26)
			Spacer()
			HStack(spacing: 110.0) {
				Button(action: {}) {
					Text("Omitir").padding(.vertical, 10)
						.padding(.horizontal, 24)
				}.buttonStyle(MaterialButtonStyle())
				Button(action: saveEntomologist) {
					Text("Guardar").padding(.vertical, 10)
						.padding(.horizontal, 24)
				}.buttonStyle(MaterialButtonStyle())
			}
			Spacer()
		}
		.alert(isPresented: $alertVisible) {
			Alert(title: Text("Necesitas activar la geolocalización"), message: Text("Ir a Configuración?"), primaryButton: .default(Text("Configuración"), action: {
				UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
			}), secondaryButton: .default(Text("Cancelar")))
		}
		.backgroundColor(Color("background"))
		.onTapGesture {
			hideKeyboard()
		}
	}
}

struct RegisterUserView_Previews: PreviewProvider {
	static var previews: some View {
		RegisterUserView()
			.environmentObject(LocationViewModel())
			.environmentObject(EntomologistViewModel())
	}
}
