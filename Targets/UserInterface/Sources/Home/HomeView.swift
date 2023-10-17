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

public struct HomeView: BaseView {
    @StateObject private var viewModel: HomeViewModel
    let homeEnergyProgressVar = SwiftUiMultiProgressViewImpl<HomeEnergyStorage>("Home Energy")
    let solarProductionProgressVar = SwiftUiMultiProgressViewImpl<SolarProductionStorage>("Solar Production")
    var didAppear: ((HomeView) -> Void)?

    public init() {
        self.init(viewModel: HomeViewModel())
    }

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack {
            Form {
                if let currentProduction = viewModel.currentProduction {
                    Section(header: Text("CURRENT PRODUCTION"), content: {
                        LabeledContent("Solar production", value: "\(currentProduction.totalSolar) W")
                            .id(HomeConstants.totalSolarId)
                        LabeledContent("Used at home", value: "\(currentProduction.useInLocal) W")
                            .id(HomeConstants.useInLocalId)
                        LabeledContent("Export to Grid", value: "\(currentProduction.exportToGrid) W")
                            .id(HomeConstants.exportToGridId)
                        LabeledContent("Import from Grid", value: "\(currentProduction.importFromGrid) W")
                            .id(HomeConstants.importFromGridId)
                    })
                }
                Section(header: Text("DAILY PRODUCTION"), content: {
                    homeEnergyProgressVar.frame(height: 120)
                    solarProductionProgressVar.frame(height: 120)
                })

                if let socialContribution = viewModel.socialContribution {
                    Section(header: Text("SOCIAL CONTRIBUTION"), content: {
                        HStack {
                            Spacer()
                            VStack {
                                Image(systemName: "tree")
                                Text("\(socialContribution.tree)")
                                    .id(HomeConstants.treeId)
                            }
                            Spacer()
                            VStack {
                                Image(systemName: "carbon.dioxide.cloud", variableValue: 100)
                                Text("\(Int(socialContribution.co2))")
                                    .id(HomeConstants.co2Id)
                            }
                            Spacer()
                        }
                    })
                }
            }.onAppear {
                viewModel.loadProductionData(
                    homeEnergyProgressBar: homeEnergyProgressVar,
                    solarProductionProgressBar: solarProductionProgressVar
                )
                didAppear?(self)
            }
        }
        .disabled(viewModel.isLoading)
        .overlay(Group {
            if viewModel.isLoading {
                ZStack {
                    Color(white: 0, opacity: 0.75)
                    ProgressView().tint(.white)
                }
                .ignoresSafeArea()
                .id(HomeConstants.spinnerId)
            }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let model = HomeViewModel()
        model.currentProduction = Production(totalSolar: 1, exportToGrid: 2, importFromGrid: 3, useInLocal: 5)
        model.socialContribution = SocialContribution(co2: 9999, tree: 12345, coal: 54321)
        let homeView = HomeView(viewModel: model)
        return homeView
    }
}
