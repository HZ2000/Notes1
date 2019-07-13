//
//  NotesCollectionViewCell.swift
//  Notes1
//
//  Created by Gev Darbinyan on 07/07/2019.
//  Copyright © 2019 com.inYerevan. All rights reserved.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var noteImageView: UIImageView?
    //@IBOutlet weak var dateLabel: UILabel!
    
    func setup(with note: Note) {
        titleLabel.text = note.title
        descriptionLabel.text = note.description
        if let noteImageView = self.noteImageView {
            noteImageView.image = note.image
        }
        //dateLabel.text = note.date
    }
    
}
