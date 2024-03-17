//
//  BaseCoordinator.swift
//  TryNotesApp
//
//  Created by Александр on 13.03.2024.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Child should implement funcStart")
    }
}
