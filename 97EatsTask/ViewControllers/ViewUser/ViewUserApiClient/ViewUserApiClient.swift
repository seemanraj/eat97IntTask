//
//  ViewUserApiClient.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
import Alamofire

class ViewUserApiClient : NSObject {
    static let shared : ViewUserApiClient = {
    let instance = ViewUserApiClient()
    return instance
    }()
    
    private override init() {
        
    }
    
    func performGetUser(id: String,completion:@escaping(Swift.Result<UserDetail,Error>) -> ()) {
        APIManager.shared.requestAPI(router: APIRouter.getUser(id: id)) { (result) -> (Void) in
            completion(result)
        }
        print(Error.self)
    }
}
