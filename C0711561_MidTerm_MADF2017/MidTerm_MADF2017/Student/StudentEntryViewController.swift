//
//  StudentEntryViewController.swift
//  MidTerm_MADF2017
//
//  Created by moxDroid on 2017-10-20.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Student ID : C0711561
//  Student Name : Denis Willian de Toledo de Gois

import UIKit

class StudentEntryViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    
    // Students Details
    @IBOutlet weak var textFieldId: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldBirthDate: UITextField!
    
    //Students Marks
    @IBOutlet weak var textFieldIOSProg: UITextField!
    @IBOutlet weak var textFieldIntroSwift: UITextField!
    @IBOutlet weak var textFieldProgJava: UITextField!
    @IBOutlet weak var textFieldDatabase: UITextField!
    @IBOutlet weak var textFieldAndroid: UITextField!
    
    var student: Student?
    var errorMessages: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let studentResultViewController = segue.destination as? StudentResultViewController {
            studentResultViewController.student = student
        }
    }
    
    fileprivate func validateStudent(_ birthDateFormated: Date, _ email: String, _ name: String, _ id: String) {
        if !isValidBirthdate(birthdate: birthDateFormated) {
            errorMessages.append("Birthdate must not be current date")
        }
        
        if !isValidEmail(email: email) {
            errorMessages.append("Invalid Email format")
        }
        
        if !isValidName(name: name) {
            errorMessages.append("Invalid Name")
        }
        
        if !isValidId(id: id) {
            errorMessages.append("Invalid Student Id")
        }
        
        if (errorMessages.count > 0) {
            showInvalidStudentAlert()
        }
    }
    
    @IBAction func saveStudentTap(_ sender: Any) {
        
        if let id = textFieldId.text,
            let name = textFieldName.text,
            let email = textFieldEmail.text,
            let birthDate = textFieldBirthDate.text,
            let iosProgMark = textFieldIOSProg.text,
            let introSwiftMark = textFieldIntroSwift.text,
            let progJavaMark = textFieldProgJava.text,
            let databaseMark = textFieldDatabase.text,
            let androidMark = textFieldAndroid.text {
            
            guard let birthDateFormated = dateFormatter.date(from: birthDate) else {
                print("invalid error")
                return
            }
            
            validateStudent(birthDateFormated, email, name, id)
            
            let marks = [Double(iosProgMark)!, Double(introSwiftMark)!, Double(progJavaMark)!, Double(databaseMark)!, Double(androidMark)!]
            
            student = Student(id: id, name: name, emailAddress: email, birthDate: birthDateFormated, marks: marks)
            
            self.performSegue(withIdentifier: "saveStudentSegue", sender: nil)
        }
        
    }
    
    fileprivate func showInvalidStudentAlert() {
        var message = ""
        for error in errorMessages {
            message += "\n" + error
        }
        let invalidStudentMessage = UIAlertController(title: "Invalid Student", message: message, preferredStyle: .alert)
        
        invalidStudentMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(invalidStudentMessage, animated: true, completion: nil)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isValidName(name: String) -> Bool {
        let nameRegEx = "[A-Za-z\\s]+"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: name)
    }
    
    func isValidBirthdate(birthdate: Date) -> Bool {
        return birthdate != Date()
    }
    
    func isValidId(id: String) -> Bool {
        let firstCharacter = id[id.index(id.startIndex, offsetBy: 0)]
        return (id.count == 10 && (firstCharacter == "c" || firstCharacter == "C"))
    }

}
