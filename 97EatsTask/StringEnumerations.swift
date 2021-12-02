//
//  StringEnumerations.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation

enum StringKey: String{

    case AppName = "AppName"
    case Ok = "Ok"
    case Delete = "Delete"
    case cancel = "Cancel"
    case FirstName = "Please enter a first name before proceeding"
    case LastName = "Please enter a last name before proceeding"
    case EmailId = "Please enter a emailId before proceeding"
    case DeleteUser = "Are you sure you want to delete the user?"
    
    public var indentifier : String {
                if let path = Bundle.main.path(forResource: "en", ofType: "lproj") {
               if let _ = Bundle(path: path) {
                 return NSLocalizedString(self.rawValue, comment: "")
               }
           }
        return self.rawValue
    }
}
