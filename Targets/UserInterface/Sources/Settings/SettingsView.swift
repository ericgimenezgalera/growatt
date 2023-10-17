//
//  SettingsView.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI

public struct SettingsView: BaseView {
    @AppStorage(usernameUserDefaultsKey) var username: String = ""
    @StateObject private var viewModel: SettingsViewModel
    var navigationViewModel: NavigationViewModel
    var didAppear: ((SettingsView) -> Void)?

    public init(_ navigationViewModel: NavigationViewModel) {
        self.init(navigationViewModel, viewModel: SettingsViewModel())
    }

    init(_ navigationViewModel: NavigationViewModel, viewModel: SettingsViewModel) {
        self.navigationViewModel = navigationViewModel
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationView {
            Form {
                profileView()
                if let plantDetails = viewModel.plantDetails {
                    Section(header: Text("PLANT DETAILS"), content: {
                        HStack {
                            LabeledContent("Name", value: plantDetails.name)
                                .id(SettingsConstants.plantNameId)
                        }
                        HStack {
                            LabeledContent("Power", value: "\(plantDetails.power) W")
                                .id(SettingsConstants.plantPowerId)
                        }
                    })
                    Section(header: Text("INVERTER DETAILS"), content: {
                        HStack {
                            LabeledContent("Device Model", value: plantDetails.inverterModel)
                                .id(SettingsConstants.inverterModelId)
                        }
                        HStack {
                            LabeledContent("Serial Number", value: plantDetails.inverterSerialNumber)
                                .id(SettingsConstants.inverterSerialNumberId)
                        }
                    })
                    Section(header: Text("DATALOG DETAILS"), content: {
                        HStack {
                            LabeledContent("Device model", value: plantDetails.datalogType)
                                .id(SettingsConstants.datalogModelId)
                        }
                        HStack {
                            LabeledContent("Serial Number", value: plantDetails.datalogSerialNumber)
                                .id(SettingsConstants.datalogSerialNumberId)
                        }
                    })
                } else {
                    Section(header: Text("PLANT DETAILS"), content: {
                        ProgressView()
                            .frame(alignment: .center)
                            .id(SettingsConstants.sipnnerId)
                    })
                }
            }
        }.onAppear {
            viewModel.getPlantData()
            didAppear?(self)
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
                        .id(SettingsConstants.usernameId)
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
                    .id(SettingsConstants.logoutId)
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
