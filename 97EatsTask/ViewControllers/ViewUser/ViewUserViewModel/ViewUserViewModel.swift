//
//  ViewUserViewModel.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation

protocol UserDetailsProtocol{

    var userDetSuccess : ((UserDetail) -> ())? {get set}
    var userDetResponse : UserDetail? { get set }
    func performGetUserList(id:String)
}

class UserListPushingControllers : SingleUserViewController {
    static let nibName = "SingleUserViewController"
}

class ViewUserViewModel:  UserDetailsProtocol {
    
    var isFromEdit = false
    var id = ""
    var totalCount = 0

    var userDetSuccess: ((UserDetail) -> ())?
    var userDetResponse: UserDetail? {
        didSet{
            userDetSuccess?(userDetResponse!)
        }
    }
}


extension ViewUserViewModel {
    func performGetUserList(id:String) {

        ViewUserApiClient.shared.performGetUser(id: id) { (result) in
            switch result{
            case .success(let response):
                self.userDetResponse = response
            case .failure(let responseError):
                debugPrint("Failure::",responseError)
                               break
            }
        }
    }
}
