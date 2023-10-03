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
    var navigationViewModel: NavigationViewModel

    public init(_ navigationViewModel: NavigationViewModel) {
        self.navigationViewModel = navigationViewModel
    }

    public var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            SettingsView(navigationViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(MockNavigationViewModel())
    }
}
