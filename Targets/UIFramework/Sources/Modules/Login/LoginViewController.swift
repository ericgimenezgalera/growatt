//
//  LoginViewController.swift
//  UIFramework
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

//
//  CreateDeviceViewController.swift
//  UIFramework
//
//  Created by Qustodio on 21/02/2020.
//

import Foundation
import UIKit

public final class LoginViewController: UIViewController, LoginViewControllerProtocol {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .blue
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        return nil
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
