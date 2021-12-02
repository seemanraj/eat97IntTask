//
//  TagsViewModel.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation

protocol TagDetailsProtocol{

    var tagDataSuccess : ((TagData) -> ())? {get set}
    var tagDataResponse : TagData? { get set }
    func performGetTagList()
}

class TagListPushingControllers : TagsViewController {
    static let nibName = "TagsViewController"
}

class TagsViewModel:  TagDetailsProtocol {
    var tagListArr = [String]()
    var tagDataSuccess: ((TagData) -> ())?
    var tagDataResponse: TagData? {
        didSet{
            tagDataSuccess?(tagDataResponse!)
        }
    }
}


extension TagsViewModel {
    func performGetTagList() {

        TagsApiClient.shared.performGetTags { (result) in
            switch result{
            case .success(let response):
                self.tagDataResponse = response
            case .failure(let responseError):
                self.tagDataResponse = nil
                debugPrint("Failure::",responseError)
                               break
            }
        }
    }
}
