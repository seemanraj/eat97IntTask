//
//  CommentListAPIClient.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation

class CommentListAPIClient : NSObject {
    static let shared : CommentListAPIClient = {
    let instance = CommentListAPIClient()
    return instance
    }()
    
    private override init() {
        
    }
    
    func performCommentsList(id:String,completion:@escaping(Swift.Result<CommentHead,Error>) -> ()) {
        APIManager.shared.requestAPI(router: APIRouter.getComments(id: id)) { (result) -> (Void) in
            completion(result)
        }
        print(Error.self)
    }
    
    func performDelComments(Id: String,completion:@escaping(Swift.Result<CommentHead,Error>) -> ()) {
        APIManager.shared.requestAPI(router: APIRouter.delComments(id: Id)) { (result) -> (Void) in
            completion(result)
        }
        print(Error.self)
    }
}
