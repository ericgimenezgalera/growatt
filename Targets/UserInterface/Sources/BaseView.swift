//
//  BaseView.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 15/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI

protocol BaseView: View {
    var didAppear: ((Self) -> Void)? { get set }
}
