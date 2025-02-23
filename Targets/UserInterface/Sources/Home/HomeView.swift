//
//  HomeView.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation
import MultiProgressView
import SwiftUI

public struct HomeView: View {
    public class ViewState: ObservableObject {
        @Published var isLoading: Bool = true
        @Published var currentProduction: Production?
        @Published var socialContribution: SocialContribution?
        let homeEnergyProgressBarViewState = FullMultiProgressView<HomeEnergyStorage>.ViewState(title: "Home Energy")
        let solarProductionProgressBarViewState = FullMultiProgressView<SolarProductionStorage>
            .ViewState(title: "Solar Production")
        var output: Output?
    }

    protocol Output: AnyObject {
        @MainActor func loadData() async
    }

    @ObservedObject var viewState: ViewState

    public init(viewState: ViewState) {
        self.viewState = viewState
    }

    public var body: some View {
        VStack {
            Form {
                if let currentProduction = viewState.currentProduction {
                    Section(header: Text("CURRENT PRODUCTION"), content: {
                        LabeledContent("Solar production", value: "\(currentProduction.totalSolar) W")
                            .accessibilityLabel(HomeConstants.totalSolarId)
                        LabeledContent("Used at home", value: "\(currentProduction.useInLocal) W")
                            .accessibilityLabel(HomeConstants.useInLocalId)
                        LabeledContent("Export to Grid", value: "\(currentProduction.exportToGrid) W")
                            .accessibilityLabel(HomeConstants.exportToGridId)
                        LabeledContent("Import from Grid", value: "\(currentProduction.importFromGrid) W")
                            .accessibilityLabel(HomeConstants.importFromGridId)
                    })
                }
                Section(header: Text("DAILY PRODUCTION"), content: {
                    SwiftUiMultiProgressViewImpl<HomeEnergyStorage>(viewState: viewState.homeEnergyProgressBarViewState)
                        .frame(height: 120)
                    SwiftUiMultiProgressViewImpl<SolarProductionStorage>(
                        viewState: viewState
                            .solarProductionProgressBarViewState
                    )
                    .frame(height: 120)
                })

                if let socialContribution = viewState.socialContribution {
                    Section(header: Text("SOCIAL CONTRIBUTION"), content: {
                        HStack {
                            Spacer()
                            VStack {
                                Image(systemName: "tree")
                                Text("\(socialContribution.tree)")
                                    .accessibilityLabel(HomeConstants.treeId)
                            }
                            Spacer()
                            VStack {
                                Image(systemName: "carbon.dioxide.cloud", variableValue: 100)
                                Text("\(Int(socialContribution.co2))")
                                    .accessibilityLabel(HomeConstants.co2Id)
                            }
                            Spacer()
                        }
                    })
                }
            }.onAppear {
                await viewState.output?.loadData()
            }
        }
        .disabled(viewState.isLoading)
        .overlay(Group {
            if viewState.isLoading {
                ZStack {
                    Color(white: 0, opacity: 0.75)
                    ProgressView().tint(.white)
                }
                .ignoresSafeArea()
                .id(HomeConstants.spinnerId)
            }
        })
        .refreshable {
            await viewState.output?.loadData()
        }.id(HomeConstants.formId)
    }
}

#Preview {
    let viewState = HomeView.ViewState()

    viewState.currentProduction = Production(totalSolar: 1, exportToGrid: 2, importFromGrid: 3, useInLocal: 5)
    viewState.socialContribution = SocialContribution(co2: 9999, tree: 12345, coal: 54321)
    Task { @MainActor in
        await viewState.homeEnergyProgressBarViewState.updateData(
            section: HomeEnergyStorage.selfConsumed.rawValue,
            to: 0.3
        )
        await viewState.homeEnergyProgressBarViewState.updateData(
            section: HomeEnergyStorage.importedFromGrid.rawValue,
            to: 0.7
        )

        await viewState.solarProductionProgressBarViewState.updateData(
            section: HomeEnergyStorage.selfConsumed.rawValue,
            to: 0.6
        )
        await viewState.solarProductionProgressBarViewState.updateData(
            section: HomeEnergyStorage.importedFromGrid.rawValue,
            to: 0.4
        )
    }
    viewState.isLoading = false

    return HomeView(viewState: viewState)
}
