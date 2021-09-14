//
//  KeychainHelper.swift
//  RegisterApp
//
//  Created by Curitiba01 on 14/09/21.
//

import Foundation

enum KeychainError: Error {
    case errorStatus(status: OSStatus)
    case invalidData
}

class KeychainHelper {
    static func addItem(server: String, account: String, data: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: account,
            kSecAttrServer as String: server,
            kSecValueData as String: data
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            try KeychainHelper.replaceItem(server: server, account: account, data: data)
            return
        }
        
        guard status == errSecSuccess else { throw KeychainError.errorStatus(status: status) }
    }
    
    static func retriveItem(server: String, account: String) throws -> Data {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: account,
            kSecAttrServer as String: server,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else { throw KeychainError.errorStatus(status: status) }
        
        guard let itemDictionary = item as? [String: Any],
              let data = itemDictionary[kSecValueData as String] as? Data
        else { throw KeychainError.invalidData }
        
        return data
    }
    
    static func replaceItem(server: String, account: String, data: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: account,
            kSecAttrServer as String: server
        ]
        
        let attributes: [String: Any] = [kSecValueData as String: data]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status == errSecSuccess else { throw KeychainError.errorStatus(status: status) }
    }
}
