//
//  CommentListViewModel.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation

protocol CommentsListProtocol {

    var commentListSuccess : (([CommentsData]) -> ())? {get set}
    var commentListResponse : [CommentsData]? { get set }
    var commentDelSuccess : ((String) -> ())? {get set}
    var commentDelResponse : (String)? { get set }
    func performGetcommentList(id:String)
    func performDelcommentList(id:String)
}

class CommentListViewModel: CommentsListProtocol {

    var pagination: Bool = false
    var current = 1
    var totalCount = 0
    var id = ""
    var commentsListArr: [CommentsData] = []
    var commentListSuccess: (([CommentsData]) -> ())?
    var commentListResponse: [CommentsData]?{
        didSet{
            commentListSuccess?(commentListResponse ?? [CommentsData]())
        }
    }
    var commentDelSuccess: ((String) -> ())?
    var commentDelResponse: (String)?{
        didSet{
            commentDelSuccess?(commentDelResponse ?? String())
        }
    }


}
class CommentsListPushingCont : CommentsListViewController {
    static let nibName = "CommentsListViewController"
}


extension CommentListViewModel {
    func performGetcommentList(id:String) {

        CommentListAPIClient.shared.performCommentsList(id: id) { (result) in
            switch result{
            case .success(let response):
                if response.total ?? 0 >= 1 {
                    self.totalCount = response.total ?? 0
                    self.commentsListArr = response.data?.map({$0}) ?? []
                    self.commentListResponse = self.commentsListArr
                }else if response.total == 0 {
                    self.commentListResponse = nil
                }else{
                    self.commentListResponse = nil
                }
            case .failure(let responseError):
                debugPrint("Failure::",responseError)
                               break
            }
        }
    }
    
    func performCreatecomment(postid:String,ownerid:String,comment:String) {

        CommentListAPIClient.shared.performCommentsList(id: id) { (result) in
            switch result{
            case .success(let response):
                if response.total ?? 0 >= 1 {
                    self.totalCount = response.total ?? 0
                    self.commentsListArr = response.data?.map({$0}) ?? []
                    self.commentListResponse = self.commentsListArr
                }else if response.total == 0 {
                    self.commentListResponse = nil
                }else{
                    self.commentListResponse = nil
                }
            case .failure(let responseError):
                debugPrint("Failure::",responseError)
                               break
            }
        }
    }
    
    func performDelcommentList(id: String) {
        CommentListAPIClient.shared.performDelComments(Id: id) { (result) in
            switch result{
            case .success(let response):
                
                break
            case .failure(let responseError):
                debugPrint("Failure::",responseError)
                               break
            }
        }
    }
}
