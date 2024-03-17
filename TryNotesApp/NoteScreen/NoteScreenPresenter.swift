//
//  NoteScreenPresenter.swift
//  TryNotesApp
//
//  Created by Александр on 17.03.2024.
//

import Foundation

class NoteScreenPresenter {
    
    func saveOrUpdate(note: Note, atIndex index: Int?) {
        var savedNotes = NotesManager.shared.loadNotes()
        if let index = index {
            savedNotes[index] = note
        } else {
            savedNotes.append(note)
        }
        NotesManager.shared.saveNotes(savedNotes)
    }
    
    func indexOf(note: Note) -> Int? {
        let savedNotes = NotesManager.shared.loadNotes()
        return savedNotes.firstIndex(where: { $0.id == note.id })
    }
    
    func getAllNotes() -> [Note] {
        return NotesManager.shared.loadNotes()
    }
}
