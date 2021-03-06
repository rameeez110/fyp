//
//  Teacher.swift
//  fyp
//
//  Created by Rameez Hasan on 12/16/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class Teacher {
    var id = Int()
    var status = String()
    var profilePicName = String()
    var qualification = String()
    var availablity = String()
    var userID = String()
    var meta = String()
    var name = String()
    var followStatus = String()
}

class TeacherLocalModel {
    var id = Int()
    var status = String()
    var profilePicName = String()
    var qualification = Int()
    var availablity = String()
    var userID = String()
    var serverID = String()
    var name = String()
    var firstChoice = String()
    var secondChoice = String()
    var thirdChoice = String()
    var fourthChoice = String()
    var isSelected = Bool()
}
