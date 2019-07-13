//
//  NotesListViewController.swift
//  Notes1
//
//  Created by Gev Darbinyan on 27/06/2019.
//  Copyright © 2019 com.inYerevan. All rights reserved.
//


import UIKit

struct Note {
    var title: String
    var description: String
    var image: UIImage?
    
    init(title: String, description: String, image: UIImage? = nil ) {
        self.title = title
        self.description = description
        self.image = image
    }
}

class NotesListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, UICollectionViewDelegate , UICollectionViewDataSource, AddNoteViewControllerDelegate , UICollectionViewDelegateFlowLayout {
    
    
    private var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120.0
        title = "Notes"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            collectionView.isHidden = true
            tableView.isHidden = false
        } else {
            collectionView.isHidden = false
            tableView.isHidden = true
        }
    }
    @IBAction private func addAction() {
        guard let addViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController else { return }
        addViewController.delegate = self
        let navVC = UINavigationController(rootViewController: addViewController)
        present(navVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        var reuseIdentifier = "NoteTableViewCell"
        if note.image != nil {
            reuseIdentifier += "+Image"
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
        cell.setup(with: note)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let note = notes[indexPath.row]
        var reuseIdentifier = "NoteCollectionViewCell"
        if note.image != nil {
            reuseIdentifier += "+Image"
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NotesCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(with: note)
        return cell
    }
    
    
    // MARK: - AddNoteViewControllerDelegate
    func noteCreated(note: Note) {
        notes.append(note)
        tableView.reloadData()
        collectionView.reloadData()
    }
}
