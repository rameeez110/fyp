//
//  Enums.swift
//  fyp
//
//  Created by Rameez Hasan on 4/28/18.
//  Copyright © 2018 AnyCart. All rights reserved.
//

import UIKit

enum Qualification: Int{
    case Bachelors = 0 , MPhil , Masters , Phd , Hod
}

enum Days: String{
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
}

enum Program: String{
    case BSCS = "BSCS"
    case BSSE = "BSSE"
}

enum Shift: String{
    case Morning = "Morning"
    case Evening = "Evening"
}

enum Section: String{
    case SectionA = "Section A"
    case SectionB = "Section B"
}

enum Availablity: String{
    case Morning = "Morning"
    case Evening = "Evening"
    case Both = "Both"
}

enum Semester: String{
    case First = "1st"
    case Second = "2nd"
    case Third = "3rd"
    case Fourth = "4th"
    case Fifth = "5th"
    case Sixth = "6th"
    case Seventh = "7th"
    case Eighth = "8th"
}

enum Choice: String{
    case First = "First"
    case Second = "Second"
    case Third = "Third"
    case Fourth = "Fourth"
}

enum TheoryRoom: String{
    case FF15 = "FF-15"
    case FF16 = "FF-16"
    case GF23 = "GF-23"
    case GF22 = "GF-22"
    case SF23 = "SF-23"
    case SF22 = "SF-22"
}

enum LabRoom: String{
    case FF02 = "First"
    case FF03 = "Second"
    case FF07 = "Third"
    case FF08 = "Fourth"
}

