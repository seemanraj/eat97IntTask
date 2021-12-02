//
//  PostListViewModel.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
protocol PostListProtocol {

    var postListSuccess : (([PostData]) -> ())? {get set}
    var postListResponse : [PostData]? { get set }
    func performGetPostList(page:Int)
}

class PostListViewModel: PostListProtocol {

    var pagination: Bool = false
    var current = 1
    var totalCount = 0
    var postListArr: [PostData] = []
    var postListSuccess: (([PostData]) -> ())?
    var postListResponse: [PostData]?{
        didSet{
            postListSuccess?(postListResponse!)
        }
    }

}
class PostListPushingCont : PostListViewController {
    static let nibName = "PostListViewController"
}


extension PostListViewModel {
    func performGetPostList(page: Int) {
        self.current = page
        pagination = true

        PostListApiClient.shared.performListPosts(pageSize: page) { (result) in
            switch result{
            case .success(let response):
                if response.total ?? 0 > 1 {
                    self.totalCount = response.total ?? 0
                    self.postListArr += response.data?.map({$0}) ?? []
                    self.postListResponse = self.postListArr
                }else if response.total == 0 {
                    self.postListResponse = nil
                }else{
                    self.postListResponse = nil
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
            case .success(let response):
                break
            case .failure(let responseError):
                debugPrint("Failure::",responseError)
                               break
            }
        }
    }
}
