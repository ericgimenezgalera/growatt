//
//  ContentView.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import SwiftUI
import UserInterface

struct ContentView: View {
    @StateObject private var navigationModel: NavigationViewModelImpl = .init()

    public init() {}

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
        return LoginView(navigationModel)
    }

    func generateMenuView() -> some View {
        MenuView(navigationModel).navigationBarBackButtonHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
