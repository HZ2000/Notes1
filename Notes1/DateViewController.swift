//
//  DateViewController.swift
//  Notes1
//
//  Created by Gev Darbinyan on 28/06/2019.
//  Copyright © 2019 com.inYerevan. All rights reserved.
//

import UIKit
import Foundation

class DateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
        
    }
    
    lazy var datepick : DateFormatter = {
        let datepicker1 = DateFormatter()
        datepicker1.dateStyle = .long
        datepicker1.timeStyle = .long
        return datepicker1
    }()
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func dataPickerAction(_ sender: Any) {
        dateLabel.text = datepick.string(from: datePicker.date)
    }
    @IBAction func datepickerTapped(_ sender: UIButton) {
    }
}
