//
//  NotesManager.swift
//  TryNotesApp
//
//  Created by Александр on 17.03.2024.
//

import Foundation

class NotesManager {
    static let shared = NotesManager()
    
    private let notesKey = "notes"
    
    private init() {}
    
    func saveNotes(_ notes: [Note]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(notes) {
            UserDefaults.standard.set(encoded, forKey: notesKey)
        }
    }
    
    func loadNotes() -> [Note] {
        if let savedNotes = UserDefaults.standard.object(forKey: notesKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode([Note].self, from: savedNotes) {
                return loadedNotes
            }
        }
        return []
    }
    
    func deleteNoteFromUserDefaults(_ note: Note) {
        var notes = loadNotes()
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
            saveNotes(notes)
        }
    }
}
