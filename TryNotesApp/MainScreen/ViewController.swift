//
//  ViewController.swift
//  TryNotesApp
//
//  Created by Александр on 13.03.2024.
//

import UIKit
import SnapKit

private enum ViewControllerStrings {
    static let topTitle = "Notes"
    static let buttonText = "Create"
    static let baseTitle = "Note"
    static let baseDiscription = "Discription"
}

private extension CGFloat {
    static let cornerRadius = 8.0
    static let borderWidth = 1.0
}

final class ViewController: UIViewController {

// MARK: - Properties
    
    var notes: [Note] = []
    weak var mainScreenCooredinator: MainScreenCoordinator?
    
    private lazy var notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var topBarView: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = ViewControllerStrings.topTitle
        label.textColor = .white
        label.textAlignment = .center
        label.font = Font.boldMiddleM
        label.layer.cornerRadius = CGFloat.cornerRadius
        label.layer.borderWidth = CGFloat.borderWidth
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private lazy var newNoteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle(ViewControllerStrings.buttonText, for: .normal)
        button.layer.cornerRadius = CGFloat.cornerRadius
        button.layer.borderWidth = CGFloat.borderWidth
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    
    
// MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarhy()
        setupLayout()
        addTarget()
        navigationBarStile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
        loadInitialNote()
    }
    
    private func loadInitialNote() {
        if notes.isEmpty {
            let allNotes = NotesManager.shared.loadNotes()
            if let existingNote = allNotes.first {
                notes.append(existingNote)
            } else {
                let defaultNote = Note(title: "\(ViewControllerStrings.baseTitle)", description: "")
                notes.append(defaultNote)
            }
            notesTableView.reloadData()
        }
    }
    
// MARK: - Odjc func
    
    @objc private func newNoteButtonTapped() {
        mainScreenCooredinator?.runNoteVC()
    }
}

// MARK: - UI  Configuration

private extension ViewController {
    
    func setupView() {
        view.backgroundColor = .lightGray
    }
    
    func setupHierarhy() {
        view.addSubview(topBarView)
        view.addSubview(newNoteButton)
        view.addSubview(notesTableView)
    }
    
    func addTarget() {
        newNoteButton.addTarget(self, action: #selector(newNoteButtonTapped), for: .touchUpInside)
    }
    
    func setupLayout() {
        topBarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constraint.constant44)
            $0.leading.trailing.equalToSuperview().inset(Constraint.constant8)
            $0.height.equalTo(Constraint.constant44)
        }
        
        notesTableView.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.bottom).offset(Constraint.constant8)
            $0.leading.trailing.equalToSuperview().inset(Constraint.constant8)
            $0.bottom.equalTo(newNoteButton.snp.top).offset(Constraint.constant12)
        }
        
        newNoteButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constraint.constant28)
            $0.trailing.equalToSuperview().inset(Constraint.constant16)
            $0.height.width.equalTo(Constraint.constant64)
        }
    }
    
    func navigationBarStile() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    func loadNotes() {
        notes = NotesManager.shared.loadNotes()
        notesTableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.id, for: indexPath) as! NoteTableViewCell
        
        let note = notes[indexPath.row]
        
        cell.cellTitle.text = note.title
        cell.cellDescription.text = note.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes[indexPath.row]
        showNoteDetail(selectedNote)
    }
    
    func showNoteDetail(_ note: Note) {
        let noteDetailVC = NoteViewController()
        noteDetailVC.note = note
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes[indexPath.row]
            NotesManager.shared.deleteNoteFromUserDefaults(noteToDelete)
            
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
