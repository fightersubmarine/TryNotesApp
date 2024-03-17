//
//  AppCoordinator.swift
//  TryNotesApp
//
//  Created by Александр on 13.03.2024.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    private var window: UIWindow
    
    private var navigationController: UINavigationController = {
       let navigationController = UINavigationController()
        
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    override func start() {
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController)
        add(coordinator: mainScreenCoordinator)
        mainScreenCoordinator.start()
    }
    
}
