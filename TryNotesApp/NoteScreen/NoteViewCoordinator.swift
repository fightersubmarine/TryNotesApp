//
//  NoteViewCoordinator.swift
//  TryNotesApp
//
//  Created by Александр on 13.03.2024.
//


import UIKit

class NoteViewCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let noteViewController = NoteViewController()
        noteViewController.noteViewCoordinator = self
        navigationController.pushViewController(noteViewController, animated: true)
    }
}
