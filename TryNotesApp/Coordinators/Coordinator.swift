//
//  Coordinator.swift
//  TryNotesApp
//
//  Created by Александр on 13.03.2024.
//

import Foundation

protocol Coordinator: AnyObject  {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
