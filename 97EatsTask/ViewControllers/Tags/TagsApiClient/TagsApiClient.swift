//
//  TagsApiClient.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
import Alamofire

class TagsApiClient : NSObject {
    static let shared : TagsApiClient = {
    let instance = TagsApiClient()
    return instance
    }()
    
    private override init() {
        
    }
    
    func performGetTags(completion:@escaping(Swift.Result<TagData,Error>) -> ()) {
        APIManager.shared.requestAPI(router: APIRouter.getTag) { (result) -> (Void) in
            completion(result)
        }
        print(Error.self)
    }
}
