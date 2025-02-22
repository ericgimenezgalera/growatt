//
//  MenuView.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI

public struct MenuView: View {
    public class ViewState: ObservableObject {
        let settingsViewState: SettingsView.ViewState

        public init(settingsViewState: SettingsView.ViewState) {
            self.settingsViewState = settingsViewState
        }
    }

    @ObservedObject var viewState: ViewState
    var navigationViewModel: NavigationViewModel

    public init(viewState: ViewState, navigationViewModel: NavigationViewModel) {
        self.navigationViewModel = navigationViewModel
        self.viewState = viewState
    }

    public var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            SettingsView(viewState: viewState.settingsViewState)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    let viewState = MenuView.ViewState(
        settingsViewState: .init(
            username: "Test User",
            logoutViewState: .init()
        )
    )
    MenuView(viewState: viewState, navigationViewModel: MockNavigationViewModel())
}
