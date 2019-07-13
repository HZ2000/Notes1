//
//  NoteTableViewCell.swift
//  Notes1
//
//  Created by Gev Darbinyan on 27/06/2019.
//  Copyright © 2019 com.inYerevan. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var noteImageView: UIImageView?
    
    func setup(with note: Note) {
        titleLabel.text = note.title
        descriptionLabel.text = note.description
        if let noteImageView = self.noteImageView {
            noteImageView.image = note.image
        }
    }
}

