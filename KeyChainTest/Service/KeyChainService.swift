//
//  KeyChainService.swift
//  KeyChainTest
//
//  Created by Гурген on 11.10.2021.
//

import Foundation
import KeychainAccess

class PasswordService {
    
    static let shared = PasswordService()
    
    let keyChain = Keychain(service: "testAppPassword")
    
    private init() { }
}
