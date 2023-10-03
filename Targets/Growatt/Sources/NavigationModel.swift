//
//  NavigationModel.swift
//  Growatt
//
//  Created by Eric Gimènez Galera on 3/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI
import UserInterface

class NavigationViewModelImpl: ObservableObject, NavigationViewModel {
    @MainActor @Published var path = NavigationPath()

    @MainActor func navigate(route: any Hashable) async {
        await MainActor.run {
            switch route {
            case is SettingsNavigationRoute:
                path.removeLast()
            default:
                path.append(route)
            }
        }
    }
}
