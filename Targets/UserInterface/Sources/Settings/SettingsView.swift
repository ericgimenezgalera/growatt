//
//  SettingsView.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI

public struct SettingsView: View {
    @AppStorage(usernameUserDefaultsKey) var username: String = ""
    var navigationViewModel: NavigationViewModel
    @StateObject private var viewModel = SettingsViewModel()
    public init(_ navigationViewModel: NavigationViewModel) {
        self.navigationViewModel = navigationViewModel
    }

    public var body: some View {
        NavigationView {
            Form {
                profileView()
                if let plantDetails = viewModel.plantDetails {
                    Section(header: Text("PLANT DETAILS"), content: {
                        HStack {
                            LabeledContent("Name", value: plantDetails.name)
                        }
                        HStack {
                            LabeledContent("Power", value: "\(plantDetails.power) W")
                        }
                    })
                    Section(header: Text("INVERTER DETAILS"), content: {
                        HStack {
                            LabeledContent("Device Model", value: plantDetails.inverterModel)
                        }
                        HStack {
                            LabeledContent("Serial Number", value: plantDetails.inverterSerialNumber)
                        }
                    })
                    Section(header: Text("DATALOG DETAILS"), content: {
                        HStack {
                            LabeledContent("Device model", value: plantDetails.datalogType)
                        }
                        HStack {
                            LabeledContent("Serial Number", value: plantDetails.datalogSerialNumber)
                        }
                    })
                } else {
                    Section(header: Text("PLANT DETAILS"), content: {
                        ProgressView().frame(alignment: .center)
                    })
                }
            }
        }.onAppear {
            viewModel.getPlantData()
        }
    }

    func profileView() -> some View {
        Group {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(username)
                        .font(.title)
                    Spacer()
                    Button(action: {
                        viewModel.logout(navigationViewModel: navigationViewModel)
                    }, label: {
                        Text("Logout")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    })
                    .background(Color.red)
                    .cornerRadius(25)
                }
                Spacer()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(MockNavigationViewModel())
    }
}
