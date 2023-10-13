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
    @ObservedObject private var viewModel: HomeViewModel
    let homeEnergyProgressVar = SwiftUiMultiProgressViewImpl<HomeEnergyStorage>("Home Energy")

    let solarProductionProgressVar = SwiftUiMultiProgressViewImpl<SolarProductionStorage>("Solar Production")

    public init() {
        self.init(viewModel: HomeViewModel())
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            Form {
                if let currentProduction = viewModel.currentProduction {
                    Section(header: Text("CURRENT PRODUCTION"), content: {
                        LabeledContent("Solar production", value: "\(currentProduction.totalSolar) W")
                        LabeledContent("Used at home", value: "\(currentProduction.useInLocal) W")
                        LabeledContent("Export to Grid", value: "\(currentProduction.exportToGrid) W")
                        LabeledContent("Import from Grid", value: "\(currentProduction.importFromGrid) W")
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
                                Text("\(socialContribution.tree)").font(.subheadline)
                            }
                            Spacer()
                            VStack {
                                Image(systemName: "carbon.dioxide.cloud", variableValue: 100)
                                Text("\(Int(socialContribution.co2))")
                            }
                            Spacer()
                        }
                    })
                }
            }.onAppear {
                viewModel.loadProductionData(
                    homeEnergyProgressVar: homeEnergyProgressVar,
                    solarProductionProgressVar: solarProductionProgressVar
                )
            }
        }
        .disabled(viewModel.isLoading)
        .overlay(Group {
            if viewModel.isLoading {
                ZStack {
                    Color(white: 0, opacity: 0.75)
                    ProgressView().tint(.white)
                }.ignoresSafeArea()
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
//        model.publishDailyProduction(
//            homeEnergyProgressVar: homeView.homeEnergyProgressVar,
//            solarProductionProgressVar: homeView.solarProductionProgressVar,
//            dailyProduction: DailyProduction(
//                totalSolar: 10,
//                selfConsumed: 2,
//                exportedToGrid: 8,
//                importedFromGrid: 4,
//                totalLocal: 6
//            )
//        )
        return homeView
    }
}
