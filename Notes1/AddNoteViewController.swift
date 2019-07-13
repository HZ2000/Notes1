//
//  AddNoteViewController.swift
//  Notes1
//
//  Created by Gev Darbinyan on 27/06/2019.
//  Copyright © 2019 com.inYerevan. All rights reserved.
//

import UIKit
import AVKit
import MessageUI

protocol AddNoteViewControllerDelegate: class {
    func noteCreated(note: Note)
}

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate , UITextViewDelegate {
    
    weak var delegate: AddNoteViewControllerDelegate?
    
    @IBOutlet private weak var titleField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageSelectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSelectButton.layer.cornerRadius = 6.0
        imageSelectButton.layer.borderWidth = 0.5
        imageSelectButton.layer.borderColor = UIColor.blue.cgColor
        imageSelectButton.setTitleColor(.blue, for: .normal)
        descriptionTextView.layer.cornerRadius = 6.0
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        emailValidationLabel.isHidden = true
    }
    
    @IBAction private func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func saveAction() {
        if let title = titleField.text, let description = descriptionTextView.text {
            let note = Note(title: title, description: description, image: imageView.image)
            delegate?.noteCreated(note: note)
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length + range.location > (titleField.text?.characters.count)! {
            
            return false
        }
        
        let newLenght = (titleField.text?.characters.count)! + string.count - range.length
        return newLenght <= 15
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.length + range.location > (descriptionTextView.text?.characters.count)! {
            
            return false
        }
        
        let newLenght = (descriptionTextView.text?.characters.count)! + text.count - range.length
        return newLenght <= 60
    }
    
    @IBAction private func imageSelectAction() {
        openImagePicker()
    }
    
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBAction func callButtonPressed(_ sender: UIButton) {
        let url: NSURL = URL(string: "Telephone: \(String(describing: self.phoneNumber.text ?? nil))")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        /*if MFMessageComposeViewController.canSendText() {
         let controller = MFMessageComposeViewController();            controller.recipients = [self.phoneNumber.text] as! [String]
         controller.messageComposeDelegate = self as! MFMessageComposeViewControllerDelegate
         self.present(controller, animated: true, completion: nil)
         } else {
         print("Can't Send the Text.")
         }*/
        emailValidationLabel.isHidden = true
        
        guard let email = emailTextField.text , (emailTextField.text?.characters.count)! != 0 else {
            emailValidationLabel.isHidden = false
            emailValidationLabel.text = "Please enter your Email."
            return
        }
        
        if isVaildEmail(emailID: email) == false {
            emailValidationLabel.isHidden = false
            emailValidationLabel.text = "Please enter valid Email address."
        }
        
        /* func emailButtonSender(_ sender: UIButton) {
         //let mailComposeViewController = configureMailController()
         
         if MFMailComposeViewController.canSendMail()  {
         //   self.present(mailComposeController, animated: true, completion: nil)
         } else {
         showMailError()
         }        }
         
         func configureMailController() -> MFMailComposeViewController {
         var mailComposerVC = MFMailComposeViewController()
         mailComposerVC.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
         mailComposerVC.setToRecipients([(self.emailTextField.text ?? nil)!])
         mailComposerVC.setSubject("\(self.subjectTextField.text)")
         mailComposerVC.setMessageBody("\(self.emailMessageTextField.text)", isHTML: false)
         
         return mailComposerVC
         }*/
        
        /*func showMailError() {
         let sendMailErrorAlert = UIAlertController(title: "Couldn't send an Email.", message: "This device does not capable to send an Email.", preferredStyle: .alert)
         let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
         sendMailErrorAlert.addAction(dismiss)
         self.present(sendMailErrorAlert, animated: true, completion: nil)
         }
         
         func mailComposeController(_ controller: MFMailComposeViewController , didFinishWith result: MFMailComposeResult , Error: Error?) {
         controller.dismiss(animated: true, completion: nil)
         }*/
        
        
        
    }
    
    func isVaildEmail(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with:emailID)
    }
    
    
}

/*extension AddNoteViewController : MFMessageComposeViewControllerDelegate {
 public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
 
 }*/
