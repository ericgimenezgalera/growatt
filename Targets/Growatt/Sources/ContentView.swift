//
//  ContentView.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import SwiftUI
import UserInterface

struct ContentView: View {
    @StateObject private var loginNavigation: LoginNavigationViewModelImpl = .init()

    public init() {}

    public var body: some View {
        NavigationStack(path: $loginNavigation.path) {
            LoginView()
                .environmentObject(loginNavigation)
                .navigationDestination(for: LoginRoute.self) { routes in
                    switch routes {
                    case .onLogged:
                        HomeView()
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
