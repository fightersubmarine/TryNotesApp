//
//  NoteModel.swift
//  TryNotesApp
//
//  Created by Александр on 17.03.2024.
//

import Foundation

struct Note: Codable {
    var title: String?
    var description: String?
    let id: UUID
    
    init(title: String, description: String, id: UUID) {
        self.title = title
        self.description = description
        self.id = id
    }
    
    init(title: String?, description: String?) {
        self.title = title
        self.description = description
        self.id = UUID()
    }
}
