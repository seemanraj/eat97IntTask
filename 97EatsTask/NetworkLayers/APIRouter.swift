//
//  APIRouter.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
import Alamofire

public func checkEnvironment(){
    
    #if DEVELOPMENT
    currentEnvironment = .Development
    #else
    currentEnvironment = .Release
    #endif
    
}

/*** API Router Enum to prepare URL Request ***/
public enum APIRouter : URLRequestConvertible {
    
    //MARK:- Login
    case getUsersList(pageCount:Int)
    case getUser(id:String)
    case delUser(id:String)
    case getTag
    case getPostList(pageCount:Int)
    case getPost(id:String)
    case delPost(id:String)
    case getComments(id:String)
    case delComments(id:String)


    //MARK:- /*** Enum to change Environment ***/
    enum EnvironmentType {
        case Development
        case Release
        /*** Base URL for API ***/
        var BaseURL : String {
            switch self {
            case .Development:
               return "https://dummyapi.io/data/v1/"
            case .Release:
                return "https://dummyapi.io/data/v1/"
            }
        }
    }
    
    //MARK:- /*** Request Headers ***/
    var headers: Dictionary<String, String>? {

        set{

        }
        
        get {
            switch self {
            case .getUsersList,.delUser,.getUser,.getTag:
                return [
                    "Content-Type": "application/json",
                    "app-id":"61a4eaa5d5aacf5ec58fe571"
                ]
            default:
                return [
                    "Content-Type": "application/json",
                    "app-id":"61a4eaa5d5aacf5ec58fe571"
                ]
            }
        }
    }
    
    //MARK:- /*** Request Body ***/
    var httpBody : Data? {
        switch self {
            /*
             case .doDeletFile(let param):
             guard let data =  try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) else {
             return nil
             }
             return data
             */
        default:
            return nil
        }
    }
    
    /*** Refresh Header ***/
    mutating func udpateHeader(){
        self.headers = self.headers
    }
    
    /*** HTTPMethod Type ***/
    var method: HTTPMethod {
        switch self {
        case .getUsersList:
            return .get
        case .getUser:
            return .post
        case .delUser :
            return .delete
        case .getTag :
            return .get
        case .getPostList:
            return .get
        case .getPost:
            return .get
        case .delPost:
            return .delete
        case .getComments:
            return .get
        case .delComments:
            return .delete
        }
        
    }
    
    /*** Endpoint Path ***/
    var path: String {
        switch self {
        case .getUsersList(let pageCount):
            return "/user?page=\(pageCount)&limit=10"
        case .getUser(let id),.delUser(let id) :
            return "/user/\(id)"
        case .getTag:
            return "/tag"
        case .getPostList(let pageCount):
            return "/post?page=\(pageCount)&limit=10"
        case .getPost(id: let id):
            return "/user/\(id)"
        case .delPost(let id):
            return "/user/\(id)"
        case .getComments(let id):
            return "/post/\(id)/comment"
        case .delComments(let id):
            return "/comment/\(id)"
        }
    }
    
    /*** Parameters to pass in request ***/
    var parameters: Dictionary<String, Any>? {
        switch self {
        case .getUser,.getUsersList,.delUser,.getTag:
            return nil
        default:
            return nil
        }
    }
    
    /*** URL encoding for each router ***/
    var encoding: ParameterEncoding{
        switch method {
        case .get:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    /*** URL request to Call API ***/
    public func asURLRequest() throws -> URLRequest {
        
        var request : URLRequest?
//        switch self {
//        default:
//            if let url =  try currentEnvironment?.BaseURL.encodeUrl()?.asURL()
//            {
//                request = URLRequest(url: url.appendingPathComponent(path))
//            }
//        }
        let strUrl = "\(currentEnvironment?.BaseURL ?? "")\(path)"
        let url = URL(string: "\(currentEnvironment?.BaseURL ?? "")\(path)")

        request = URLRequest(url: url!)
        request?.httpMethod = method.rawValue
        request?.timeoutInterval = 60
        request?.allHTTPHeaderFields = headers
        
        if let request = request
        {
            return try encoding.encode(request, with: parameters)
        }
        else{
            return try encoding.encode(URLRequest(url: URL(fileURLWithPath: "")), with: parameters)
        }
    }
}

extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}


