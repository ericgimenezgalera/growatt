//
//  SettingsView.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation
import SwiftUI

public struct SettingsView: View {
    public class ViewState: ObservableObject {
        @Published var username: String
        @Published var plantDetails: PlantDetails?
        let logoutViewState: AsyncButtonViewState
        var output: Output?

        init(
            username: String,
            logoutViewState: AsyncButtonViewState
        ) {
            self.username = username
            self.logoutViewState = logoutViewState
        }
    }

    protocol Output: AnyObject {
        func onAppear() async
    }

    @ObservedObject var viewState: ViewState
    @ObservedObject var logoutViewState: AsyncButtonViewState

    public init(viewState: ViewState) {
        self.viewState = viewState
        logoutViewState = viewState.logoutViewState
    }

    public var body: some View {
        NavigationView {
            Form {
                profileView()
                if let plantDetails = viewState.plantDetails {
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
            await viewState.output?.onAppear()
        }.overlay(Group {
            if viewState.logoutViewState.showProgressView {
                ZStack {
                    Color(white: 0, opacity: 0.75)
                    ProgressView().tint(.white)
                }
                .ignoresSafeArea()
                .id(LoginConstants.spinnerViewId)
            }
        })
    }

    func profileView() -> some View {
        Group {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(viewState.username)
                        .font(.title)
                        .id(SettingsConstants.usernameId)
                    Spacer()
                    AsyncButton(viewState: viewState.logoutViewState, label: {
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
            .padding(.vertical)
        }
    }
}

#Preview {
    let viewState = SettingsView.ViewState(
        username: "Test User",
        logoutViewState: .init()
    )

    viewState.plantDetails = .init(
        name: "Test plant",
        power: 9999,
        datalogType: "Fake type",
        datalogSerialNumber: "fake S/N",
        inverterModel: "Fake inverter model",
        inverterSerialNumber: "Fake inverter serial number"
    )

//    viewState.logoutViewState.showProgressView = true

    return SettingsView(viewState: viewState)
}
