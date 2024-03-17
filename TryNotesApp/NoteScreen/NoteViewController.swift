//
//  NoteViewController.swift
//  TryNotesApp
//
//  Created by Александр on 13.03.2024.
//

import UIKit

private enum NoteViewControllerStrings {
    static let notePlaceholder = "Note name"
    static let topItem = "Note"
}

private extension CGFloat {
    static let cornerRadius = 16.0
    static let cornerRadiusTextField = 8.0
    static let borderWidth = 1.0
}

final class NoteViewController: UIViewController {
    
// MARK: - Properties
    
    weak var noteViewCoordinator: NoteViewCoordinator?
    private let presenter = NoteScreenPresenter()
    var note: Note?
    
    private lazy var noteTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = NoteViewControllerStrings.notePlaceholder
        textField.textColor = .black
        textField.textAlignment = .left
        textField.font = Font.boldMiddleS
        textField.layer.cornerRadius = CGFloat.cornerRadiusTextField
        textField.layer.borderWidth = CGFloat.borderWidth
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var noteTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.textAlignment = .left
        textView.font = Font.boldSmallL
        textView.layer.cornerRadius = CGFloat.cornerRadius
        textView.layer.borderWidth = CGFloat.borderWidth
        textView.layer.borderColor = UIColor.white.cgColor
        return textView
    }()

    
// MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarhy()
        setupLayout()
        navigationBarStile()
        loadNote()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveNote()
    }
    
// MARK: - Helper Func
        
    private func loadNote() {
        if let existingNote = note {
            noteTextField.text = existingNote.title
            noteTextView.text = existingNote.description
        }
    
    }
    
}

// MARK: - UI  Configuration

private extension NoteViewController {
    
    func setupView() {
        view.backgroundColor = .lightGray
    }
    
    func setupHierarhy() {
        view.addSubview(noteTextField)
        view.addSubview(noteTextView)
    }
     
    func setupLayout() {
        
        noteTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constraint.constant8)
            $0.leading.trailing.equalToSuperview().inset(Constraint.constant16)
            $0.height.equalTo(Constraint.constant44)
        }
        
        noteTextView.snp.makeConstraints {
            $0.top.equalTo(noteTextField.snp.bottom).offset(Constraint.constant8)
            $0.leading.trailing.equalToSuperview().inset(Constraint.constant16)
            $0.bottom.equalToSuperview().inset(Constraint.constant24)
        }
    }
    
    func navigationBarStile() {
        navigationController?.navigationBar.topItem?.backButtonTitle = NoteViewControllerStrings.topItem
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func saveNote() {
        let title = noteTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let description = noteTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let noteToSave: Note
        if let existingNote = note {
            noteToSave = Note(title: title.isEmpty ? NoteViewControllerStrings.topItem : title,
                              description: description,
                              id: existingNote.id)
        } else {
            noteToSave = Note(title: title.isEmpty ? NoteViewControllerStrings.topItem : title,
                              description: description)
        }
        
        let index = presenter.indexOf(note: noteToSave)
        presenter.saveOrUpdate(note: noteToSave, atIndex: index)
    }
}

