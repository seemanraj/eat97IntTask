//
//  APIManager.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
import Alamofire
import UIKit
import MobileCoreServices

public enum ErrorsToThrow: Error,LocalizedError {
    case failed
    case NoInternet
    case sessionExpried
    
    public var errorDescription: String? {
        switch self {
        case .NoInternet:
            return "Network Issue"
        case .sessionExpried :
            return "Session Expried Please do login in again"
        default :
            return "Network Issue"
        }
    }
}

class APIManager : NSObject {
    
    /*** Singleton APIManager object to be used throughout the app ***/
    static let shared: APIManager = {
        let instance = APIManager()
        return instance
    }()
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?) -> Void
    private var isRefreshing = false
    
    public func requestAPI<T : Decodable>(router : APIRouter, completion: @escaping (Swift.Result<T, Error>) -> (Void)) {
        
        if !isNetworkReach{
            completion(.failure(ErrorsToThrow.NoInternet))
            return
        }
        print("Url --->",router.urlRequest?.description ?? "No URL")
        print("Header --->",router.headers ?? "No Header")
        if let body = router.httpBody {
            
            print("Body --->",body.toJSON() ?? "No Body")
        }
        print("Params --->",router.parameters ?? "No Params")
        
        AF.request(router).validate().responseDecodable { (response : AFDataResponse<T>) in
            DispatchQueue.main.async {
                if let responseData = response.data {
                    print("Response --->",responseData.toJSON() ?? "")
                    JSONResponseDecoder.decodeFrom(responseData, returningModelType: T.self, completion: { (model, error) in
                        DispatchQueue.main.async {
                            if let parserError = error {
                                completion(.failure(parserError))
                                return
                            }
                            if let model = model {
                                completion(.success(model))
                                return
                            }
                        }
                    })
                } else if let parserError = response.error {
                    print("Error")
                }
            }
        }
    }

    /*Image Upload Multipart */
    public func uploadFile<T : Decodable>(router : APIRouter,arrData:[Data],imageKey:String,URlName:String = "", mime: String = "",completion: @escaping (Swift.Result<T, Error>) -> (Void)){
        
        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "type" : "1"]
        
        print("Url --->",router.urlRequest?.description ?? "No URL")
        print("Header --->",headers)
        print("Params --->",router.parameters ?? "")
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            if let parameter = router.parameters
            {
                for (key, value) in parameter{
                    
                    if let json = try? JSONSerialization.data(withJSONObject: value, options: [.prettyPrinted]) {
                        if let jsonPresentation = String(data: json, encoding: .utf8) {
                            multipartFormData.append(jsonPresentation.data(using: .utf8)!, withName: key)
                        }
                    }
                }
            }
            
            for data in arrData {
                multipartFormData.append(data, withName: imageKey, fileName: Date.currentTimeStamp + ".jpeg", mimeType: "image/jpeg")
            }
            
            
        },to: router.urlRequest?.url?.absoluteString ?? "", usingThreshold: UInt64.init(),
        method: .post,
        headers: headers).response{ response in
            
            if let responseData = response.data
            {
                print("Response --->",responseData.toJSON() ?? "")
                
                // checkAuthorizaitonTokenIsValid(dataobj: responseData, completion: {

                JSONResponseDecoder.decodeFrom(responseData, returningModelType: T.self, completion: { (model, error) in
                    DispatchQueue.main.async {


                        if let parserError = error {
                            completion(.failure(parserError))
                            return
                        }
                        if let model = model {
                            completion(.success(model))
                            return
                        }
                    }
                })
            }
            
        }
    }


//    func mimeTypeForPath(path: String) -> String {
//        let url = NSURL(fileURLWithPath: path)
//        let pathExtension = url.pathExtension
//
//        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
//            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
//                return mimetype as String
//            }
//        }
//        return "application/octet-stream"
//    }

    func mimeType(for data: Data) -> String {

        var b: UInt8 = 0
        data.copyBytes(to: &b, count: 1)

        switch b {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
}


//MARK:- Valid the token is expired or not
func checkAuthorizaitonTokenIsValid(dataobj : Data,completion: @escaping () -> Void,failed:  @escaping () -> Void){
    
    /*
     JSONResponseDecoder.decodeFrom(dataobj, returningModelType: GeneralResponse.self, completion: { (model, error) in
     
     if let parserError = error {
     print(parserError.localizedDescription)
     failed()
     return
     }
     
     if let statusCodeValue = model?.meta?.status,
     let message = model?.meta?.message,
     let statusCode = StatusCode(rawValue: statusCodeValue) {
     
     if statusCode == .Unauthorized  {
     let destinationVC = LoginVC(nibName: LoginVC.nibName, bundle: nil)
     UIApplication.setRootViewController(targetVc: destinationVC)
     AlertManager.shared.dropCRNotificationAlert(message: message)
     HelperRightNow.shared.clearAllUserDefaultData()
     completion()
     return
     } else if statusCode == .TokenExpired {
     failed()
     return
     } else {
     completion()
     return
     }
     }
     
     failed()
     })
     */
}


//MARK:- Refresh Expired Token
func refreshToken(completion: @escaping () -> Void,error:  @escaping (Error) -> Void){
    /*
     doRefreshToken { (result) in
     switch result {
     
     case .success(let reponse):
     if let statusCodeValue = reponse.meta?.status,
     let statusCode = StatusCode(rawValue: statusCodeValue),
     let message = reponse.meta?.message{
     if statusCode == .Ok,let newToken = reponse.data?.token {
     setAuthTokenToUD(token: newToken)
     completion()
     } else {
     AlertManager.shared.dropCRNotificationAlert(message: message)
     error(ErrorsToThrow.failed)
     }
     }
     case .failure(let err):
     AlertManager.shared.dropFailureCRNotificationAlert(message: err.localizedDescription)
     error(err)
     }
     }
     */
}

extension Data
{
    func toJSON() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}

class JSONResponseDecoder {

    typealias JSONDecodeCompletion<T> = (T?, Error?) -> Void

    static func decodeFrom<T: Decodable>(_ responseData: Data, returningModelType: T.Type, completion: JSONDecodeCompletion<T>) {
        do {
            let model = try JSONDecoder().decode(returningModelType, from: responseData)
            completion(model, nil)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: ", context)
            completion(nil, DecodingError.dataCorrupted(context))
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: ", context.debugDescription, "\n codingPath:", context.codingPath)
            completion(nil, DecodingError.keyNotFound(key, context))
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found: ", context.debugDescription, "\n codingPath:", context.codingPath)
            completion(nil, DecodingError.valueNotFound(value, context))
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch: ", context.debugDescription, "\n codingPath:", context.codingPath)
            completion(nil, DecodingError.typeMismatch(type, context))
        } catch {
            print("error: ", error.localizedDescription)
            completion(nil, error)
        }
    }

}
