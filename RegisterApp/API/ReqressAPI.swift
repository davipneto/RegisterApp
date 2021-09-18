//
//  ReqressAPI.swift
//  RegisterApp
//
//  Created by Curitiba01 on 14/09/21.
//

import Foundation
import Alamofire
import SwiftyJSON

enum LoginError: Error {
    case invalidData
    case other(message: String)
}

class ReqressAPI {
    static let shared = ReqressAPI()
    static let server = "https://reqres.in"
    
    private let baseURL = "https://reqres.in/api"
    
    func register(email: String, password: String, completion: @escaping (_ response: RegisterResponse?, _ error: Error?) -> Void) {
        let url = baseURL + "/register"
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters).responseData { responseData in
            if let error = responseData.error {
                completion(nil, error)
                return
            }
            guard let data = responseData.data else {
                completion(nil, LoginError.invalidData)
                return
            }
            do {
                let json = try JSON(data: data)
                print(json)
                let response = RegisterResponse(json: json)
                completion(response, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (_ token: String?, _ error: Error?) -> Void) {
        let url = baseURL + "/login"
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters).responseData { responseData in
            if let error = responseData.error {
                completion(nil, error)
                return
            }
            guard let data = responseData.data else {
                completion(nil, LoginError.invalidData)
                return
            }
            do {
                let json = try JSON(data: data)
                print(json)
                guard let token = json["token"].string else {
                    let jsonError = json["error"].stringValue
                    completion(nil, LoginError.other(message: jsonError))
                    return
                }
                completion(token, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
    func getResources(completion: @escaping (_ response: [Resource]?, _ error: Error?) -> Void) {
        let url = baseURL + "/unknown"
        AF.request(url, method: .get).responseData { responseData in
            if let error = responseData.error {
                completion(nil, error)
                return
            }
            guard let data = responseData.data else {
                completion(nil, LoginError.invalidData)
                return
            }
            do {
                let json = try JSON(data: data)
                print(json)
                let resources = json["data"].arrayValue.map { Resource(json: $0) }
                completion(resources, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
