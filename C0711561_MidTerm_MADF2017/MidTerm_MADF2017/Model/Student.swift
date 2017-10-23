//
//  Student.swift
//  MidTerm_MADF2017
//
//  Created by moxDroid on 2017-10-20.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Student ID : C0711561
//  Student Name : Denis Willian de Toledo de Gois

import Foundation

class Student {
    
    var id: String
    var name: String
    var emailAddress: String
    var birthDate: Date
    var marks: [Double]
    
    init(id: String, name: String, emailAddress: String, birthDate: Date, marks: [Double]) {
        self.id = id
        self.name = name
        self.emailAddress = emailAddress
        self.birthDate = birthDate
        self.marks = marks
    }
    
    func getTotalMarks() -> Double {
        var total = 0.0
        for mark in marks {
            total += mark
        }
        return total
    }
    
    func getPercentage() -> Double {
        if shouldCalculatePercentage() {
            return (getTotalMarks() / Double(marks.count))
        }
        return 0.0
    }
    
    func getResult() -> String {
        let per = getPercentage()
        
        var result = "FAIL"
        
        if per >= 95 {
            result = "A+"
        } else if per >= 85 && per < 95 {
            result = "A"
        } else if per >= 75 && per < 85 {
            result = "B+"
        } else if per >= 65 && per < 75 {
            result = "B"
        } else if per >= 55 && per < 65 {
            result = "C+"
        } else if per >= 50 && per < 55 {
            result = "C"
        } else if per >= 45 && per < 50 {
            result = "D+"
        }
        
        return result
    }
    
    func shouldCalculatePercentage() -> Bool {
        return !((marks.filter { $0 < 45 }.count) > 1)
    }
}
