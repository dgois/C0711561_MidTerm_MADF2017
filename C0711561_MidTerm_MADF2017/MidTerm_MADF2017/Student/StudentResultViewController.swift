//
//  StudentResultViewController.swift
//  MidTerm_MADF2017
//
//  Created by moxDroid on 2017-10-20.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Student ID : C0711561
//  Student Name : Denis Willian de Toledo de Gois

import UIKit

class StudentResultViewController: UIViewController {

    let dateFormatter = DateFormatter()
    
    var student: Student?
    
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblBirthdate: UILabel!
    
    @IBOutlet weak var lblMarkIOSProgramming: UILabel!
    @IBOutlet weak var lblMarkSwift: UILabel!
    @IBOutlet weak var lblMarkProgramJava: UILabel!
    @IBOutlet weak var lblMarkDatabaseDesign: UILabel!
    @IBOutlet weak var lblMarkAndroid: UILabel!
    
    @IBOutlet weak var lblTotalMarks: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var lblFinalResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let student = student {
            lblId.text = student.id
            lblName.text = student.name
            lblEmail.text = student.emailAddress
            lblBirthdate.text = dateFormatter.string(from: student.birthDate)
            
            lblMarkIOSProgramming.text = String(describing: student.marks[0])
            lblMarkSwift.text = String(describing: student.marks[1])
            lblMarkProgramJava.text = String(describing: student.marks[2])
            lblMarkDatabaseDesign.text = String(describing: student.marks[3])
            lblMarkAndroid.text = String(describing: student.marks[4])

            lblTotalMarks.text = String(describing: student.getTotalMarks())
            lblPercentage.text = String(describing: student.getPercentage())
            lblFinalResult.text = String(describing: student.getResult())
            
            if student.shouldCalculatePercentage() {
                lblFinalResult.textColor = .green
            } else {
                lblFinalResult.textColor = .red
            }
        } else {
            print("Invalid user")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let studentEntryViewController = segue.destination as? StudentEntryViewController {
            studentEntryViewController.student = student
        }
    }

}
