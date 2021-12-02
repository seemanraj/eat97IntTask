//
//  PostListApiClient.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
import Alamofire

class PostListApiClient : NSObject {
    static let shared : PostListApiClient = {
    let instance = PostListApiClient()
    return instance
    }()
    
    private override init() {
        
    }
    
    func performListPosts(pageSize: Int,completion:@escaping(Swift.Result<PostHeadData,Error>) -> ()) {
        APIManager.shared.requestAPI(router: APIRouter.getPostList(pageCount: pageSize)) { (result) -> (Void) in
            completion(result)
        }
        print(Error.self)
    }
    
    func performDelPosts(Id: String,completion:@escaping(Swift.Result<PostData,Error>) -> ()) {
        APIManager.shared.requestAPI(router: APIRouter.delPost(id: Id)) { (result) -> (Void) in
            completion(result)
        }
        print(Error.self)
    }
}
