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
        
        if let s = student {
            textFieldId.text = s.id
            textFieldName.text = s.name
            textFieldEmail.text = s.emailAddress
            textFieldBirthDate.text = dateFormatter.string(from: s.birthDate)
            textFieldIOSProg.text = String(s.marks[0])
            textFieldIntroSwift.text = String(s.marks[1])
            textFieldProgJava.text = String(s.marks[2])
            textFieldDatabase.text = String(s.marks[3])
            textFieldAndroid.text = String(s.marks[4])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let studentResultViewController = segue.destination as? StudentResultViewController {
            studentResultViewController.student = student
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
            
            if validateStudent(birthDate, email, name, id, iosProgMark, introSwiftMark, progJavaMark, databaseMark, androidMark) {
                
                let marks = [Double(iosProgMark)!, Double(introSwiftMark)!, Double(progJavaMark)!, Double(databaseMark)!, Double(androidMark)!]
                
                student = Student(id: id, name: name, emailAddress: email, birthDate: dateFormatter.date(from: birthDate)!, marks: marks)
            }
            
            self.performSegue(withIdentifier: "saveStudentSegue", sender: nil)
        }
        
    }
    
    fileprivate func validateStudent(_ birthDate: String, _ email: String, _ name: String, _ id: String, _ iosProgMark: String, _ introSwiftMark: String, _ progJavaMark: String, _ databaseMark: String, _ androidMark: String) -> Bool {
        
        if !isValidBirthdate(birthDate: birthDate) {
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
        
        if !isValidNumber(number: iosProgMark) {
            errorMessages.append("Invalid IOS Programming Mark")
        }
        
        if !isValidNumber(number: introSwiftMark) {
            errorMessages.append("Invalid Introduction to Swift Mark")
        }
        
        if !isValidNumber(number: progJavaMark) {
            errorMessages.append("Invalid Java Programming Mark")
        }
        
        if !isValidNumber(number: databaseMark) {
            errorMessages.append("Invalid Database and Design Mark")
        }
        
        if !isValidNumber(number: androidMark) {
            errorMessages.append("Invalid Android Mark")
        }
        
        if (errorMessages.count > 0) {
            showInvalidStudentAlert()
        }
        
        return errorMessages.count == 0
    }
    
    fileprivate func showInvalidStudentAlert() {
        var message = ""
        for error in errorMessages {
            message += "\n" + error
        }
        let invalidStudentMessage = UIAlertController(title: "Invalid Student", message: message, preferredStyle: .alert)
        
        invalidStudentMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.errorMessages = [String]()
        }))
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
    
    func isValidBirthdate(birthDate: String) -> Bool {
        if birthDate != dateFormatter.string(from: Date()) {
            if let _ = dateFormatter.date(from: birthDate) {
                return true
            }
        }
        return false
    }
    
    func isValidId(id: String) -> Bool {
        var result = false
        if (!id.isEmpty) {
            let firstCharacter = id[id.index(id.startIndex, offsetBy: 0)]
            result = (id.count == 10 && (firstCharacter == "c" || firstCharacter == "C"))
        }
        return result
    }
    
    func isValidNumber(number: String) -> Bool {
        return !number.isEmpty && Double(number) != nil
    }

}
