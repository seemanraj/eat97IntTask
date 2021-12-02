//
//  ListUserApiClient.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
import Alamofire

class ListUserApiClient : NSObject {
    static let shared : ListUserApiClient = {
    let instance = ListUserApiClient()
    return instance
    }()
    
    private override init() {
        
    }
    
    func performListUsers(pageSize: Int,completion:@escaping(Swift.Result<UserHeadData,Error>) -> ()) {
        APIManager.shared.requestAPI(router: APIRouter.getUsersList(pageCount: pageSize)) { (result) -> (Void) in
            completion(result)
        }
        print(Error.self)
    }
    
    func performDelUsers(Id: String,completion:@escaping(Swift.Result<UserHeadData,Error>) -> ()) {
        APIManager.shared.requestAPI(router: APIRouter.delUser(id: Id)) { (result) -> (Void) in
            completion(result)
        }
        print(Error.self)
    }
}
