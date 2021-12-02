//
//  Constant.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
import UIKit

var isNetworkReach = true
var currentEnvironment : APIRouter.EnvironmentType? = .Development


extension Date {
    internal static var currentTimeStamp: String {
        return Int64(Date().timeIntervalSince1970 * 1000).description
    }
}

func showAlert(msg : String,view : UIViewController)
{
    let alert = UIAlertController(title: LSString(.AppName), message: msg, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: LSString(.Ok), style: UIAlertAction.Style.default, handler: nil))
    view.present(alert, animated: true, completion: nil)
}



func LSString(_ key : StringKey) -> String{
    return key.indentifier
}

func localToUTC(dateStr: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    dateFormatter.calendar = Calendar.current
    dateFormatter.timeZone = TimeZone.current
    
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "H:mm:ss"
    
        return dateFormatter.string(from: date)
    }
    return nil
}

func utcToLocal(dateStr: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd MMM yy"
    
        return dateFormatter.string(from: date)
    }
    return nil
}
