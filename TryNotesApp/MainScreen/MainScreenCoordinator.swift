//
//  MainScreenCoordinator.swift
//  TryNotesApp
//
//  Created by Александр on 13.03.2024.
//

import UIKit

class MainScreenCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let mainViewController = ViewController()
        mainViewController.mainScreenCooredinator = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func runNoteVC() {
        let noteViewCoordinator = NoteViewCoordinator(navigationController: navigationController)
        add(coordinator: noteViewCoordinator)
        noteViewCoordinator.start()
    }
}
