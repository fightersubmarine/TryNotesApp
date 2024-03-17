//
//  NoteTableViewCell.swift
//  TryNotesApp
//
//  Created by Александр on 13.03.2024.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
//MARK: - Properties
    
    static let id = "NoteTableViewCell"

    lazy var cellTitle: UILabel = {
        let title = UILabel()
        title.font = Font.boldSmallM
        return title
    }()
        
    lazy var cellDescription: UILabel = {
        let label = UILabel()
        label.font = Font.boldSmallS
        label.textColor = .gray
        return label
    }()
    
// MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Private func
    
    private func setupView() {
        selectionStyle = .none
        addSubview(cellTitle)
        addSubview(cellDescription)
    }
    
    private func setupLayout() {
        cellTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constraint.constant12)
            $0.leading.equalToSuperview().offset(Constraint.constant16)
        }
        
        cellDescription.snp.makeConstraints {
            $0.top.equalTo(cellTitle.snp.bottom).offset(Constraint.constant4)
            $0.leading.equalToSuperview().offset(Constraint.constant16)
            $0.bottom.equalToSuperview().inset(Constraint.constant12)
        }
    }

}
