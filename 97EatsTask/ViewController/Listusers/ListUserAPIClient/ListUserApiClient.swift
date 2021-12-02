//
//  ListUserApiClient.swift
//  MVVM Starter Project
//
//  Created by System Admin on 30/11/21.
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
    
    func performListUsers(completion:@escaping(Swift.Result<UserHeadData,Error>) -> ()) {
        APIManager.shared.requestAPI(router: APIRouter.getUsersList) { (result) -> (Void) in
            completion(result)
        }
    }
}
