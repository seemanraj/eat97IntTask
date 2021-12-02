//
//  CommentsListModel.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation

class CommentHead: Codable {
    let data: [CommentsData]?
    let total, page, limit: Int?

    init(data: [CommentsData]?, total: Int?, page: Int?, limit: Int?) {
        self.data = data
        self.total = total
        self.page = page
        self.limit = limit
    }
}

// MARK: - Datum
class CommentsData: Codable {
    let id, message: String?
    let owner: Owner?
    let post, publishDate: String?

    init(id: String?, message: String?, owner: Owner?, post: String?, publishDate: String?) {
        self.id = id
        self.message = message
        self.owner = owner
        self.post = post
        self.publishDate = publishDate
    }
}

class CommentDel : Codable {
    let id: String?
    init(id: String?) {
        self.id = id

    }
}

