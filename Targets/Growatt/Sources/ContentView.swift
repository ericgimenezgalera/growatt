//
//  ContentView.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DependencyInjection
import KeychainWrapper
import SwiftUI
import UserInterface

struct ContentView: View {
    @AppStorage("appVersion") var appVersion: String = ""
    @StateObject private var navigationModel: NavigationViewModelImpl = .init()
    @Injected(\.keychainWrapper) var keychainWrapper: KeychainWrapper

    public init() {
        // If fresh install clean keychain
        guard !appVersion.isEmpty else {
            do {
                if try keychainWrapper.exists(account: passwordKeychainAccount) {
                    try keychainWrapper.delete(account: passwordKeychainAccount)
                }
                appVersion = currentAppVersion
            } catch {}
            return
        }
    }

    public var body: some View {
        NavigationStack(path: $navigationModel.path) {
            generateLoginView()
                .navigationDestination(for: LoginNavigationRoute.self) { routes in
                    switch routes {
                    case .onLogged:
                        generateMenuView()
                    }
                }
                .navigationDestination(for: SettingsNavigationRoute.self) { routes in
                    switch routes {
                    case .onLogout:
                        fatalError("SettingsNavigationRoute.onLogout called to new view")
                    }
                }
        }
    }

    func generateLoginView() -> some View {
        let viewModel = LoginViewModel(navigationViewModel: navigationModel)
        return LoginView(viewState: viewModel.viewState)
    }

    func generateMenuView() -> some View {
        let settingsViewModel = SettingsViewModel(navigationViewModel: navigationModel)
        let homeViewModel = HomeViewModel()
        let viewState = MenuView.ViewState(
            settingsViewState: settingsViewModel.viewState,
            homeViewState: homeViewModel.viewState
        )
        return MenuView(viewState: viewState, navigationViewModel: navigationModel).navigationBarBackButtonHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
