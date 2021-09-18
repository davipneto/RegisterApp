//
//  ReqressAPI.swift
//  RegisterApp
//
//  Created by Curitiba01 on 14/09/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

enum LoginError: Error {
    case invalidData
    case other(message: String)
}

class ReqressAPI {
    static let shared = ReqressAPI()
    static let server = "https://reqres.in"
    
    private let baseURL = "https://reqres.in/api"
    
    func register(email: String, password: String) -> Observable<RegisterResponse> {
        let url = baseURL + "/register"
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        return createRequest(url: url, method: .post, parameters: parameters)
            .map { RegisterResponse(json: $0) }
    }
    
    func login(email: String, password: String) -> Observable<String> {
        let url = baseURL + "/login"
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        return createRequest(url: url, method: .post, parameters: parameters)
            .map { $0["token"].stringValue }
    }
    
    func getResources() -> Observable<[Resource]> {
        let url = baseURL + "/unknown"
        return createRequest(url: url)
            .map {
                $0["data"].arrayValue.map { Resource(json: $0) }
            }
    }
    
    private func createRequest(url: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil) -> Observable<JSON> {
        return Observable.create { observer -> Disposable in
            let request = Alamofire.Session.default.request(url, method: method, parameters: parameters).responseData { responseData in
                if let error = responseData.error {
                    observer.onError(error)
                    return
                }
                if let data = responseData.data {
                    do {
                        let json = try JSON(data: data)
                        observer.onNext(json)
                        observer.onCompleted()
                    } catch {
                        observer.onError(LoginError.invalidData)
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
