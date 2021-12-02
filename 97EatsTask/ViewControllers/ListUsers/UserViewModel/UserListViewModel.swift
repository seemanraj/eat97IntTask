//
//  UserListViewModel.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation

protocol UserListProtocol {

    var userListSuccess : (([UserData]) -> ())? {get set}
    var userListResponse : [UserData]? { get set }
    func performGetUserList(page:Int)
}

class UserListViewModel: UserListProtocol {

    var pagination: Bool = false
    var current = 1
    var totalCount = 0
    var userListArr: [UserData] = []
    var userListSuccess: (([UserData]) -> ())?
    var userListResponse: [UserData]?{
        didSet{
            userListSuccess?(userListResponse!)
        }
    }

}
class UserListPushingCont : UserListVC {
    static let nibName = "UserListVC"
}


extension UserListViewModel {
    func performGetUserList(page: Int) {
        self.current = page
        pagination = true

        ListUserApiClient.shared.performListUsers(pageSize: page) { (result) in
            switch result{
            case .success(let response):
                if response.total ?? 0 > 1 {
                    self.totalCount = response.total ?? 0
                    self.userListArr += response.data?.map({$0}) ?? []
                    self.userListResponse = self.userListArr
                }else if response.total == 0 {
                    self.userListResponse = nil
                }else{
                    self.userListResponse = nil
                }
            
            case .failure(let responseError):
                debugPrint("Failure::",responseError)
                               break
            }
        }
    }
    
    func performDeleteUser(Id: String) {
        ListUserApiClient.shared.performDelUsers(Id: Id) { (result) in
            switch result{
            case .success(let response): break
            
            case .failure(let responseError):
                debugPrint("Failure::",responseError)
                               break
            }
        }
    }
}
