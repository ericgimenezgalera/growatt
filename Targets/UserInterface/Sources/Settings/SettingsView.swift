//
//  SettingsView.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI

public struct SettingsView: View {
    @AppStorage("username") var username: String = ""
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @StateObject private var viewModel = SettingsViewModel()
    public init() {}

    public var body: some View {
        NavigationView {
            Form {
                profileView()
                /* Section(header: Text("CONTENT"), content: {
                     HStack {
                         Image(systemName: "heart")
                         Text("Favorites")
                     }

                     HStack {
                         Image(systemName: "arrow.down.to.line.circle")
                         Text("Downloads")
                     }

                 }) */
            }
        }
    }

    func profileView() -> some View {
        Group {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(username)
                        .font(.title)
                    Text("Growatt username")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        viewModel.logout(navigationViewModel: navigationViewModel)
                    }, label: {
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
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
