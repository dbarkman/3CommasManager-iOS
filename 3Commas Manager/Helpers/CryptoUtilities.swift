//
//  CryptoUtilities.swift
//  3Commas Manager
//
//  Created by David Barkman on 1/1/22.
//

import Foundation
import CryptoKit

struct CryptoUtilities {
    
    public static func signRequest(input: String, secretKey: String) -> String {
        let inputData: Data = (input).data(using: .utf8)!
        let secretKeyData = SymmetricKey(data: secretKey.data(using: .utf8)!)
        let authenticationCode = HMAC<SHA256>.authenticationCode(for: inputData, using: secretKeyData)
        let authenticationCodeString = authenticationCode.description.components(separatedBy: " ")[3]
        return authenticationCodeString
    }

}
