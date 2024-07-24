//
//  EncryptionHelper.swift
//  dummy password
//
//  Created by Praveen Yeddu on 23/07/24.
//

import Foundation
import CryptoKit

let key = SymmetricKey(size: .bits256)

func encrypt(password: String) -> (Data, Data) {
    
    let data = password.data(using: .utf8)
    
    let sealedBox = try! AES.GCM.seal(data!, using: key)
    let encryptedString = sealedBox.combined!
    let keyData = key.withUnsafeBytes { Data(Array($0)) }
    return (encryptedString, keyData)
}


func decrypt(encryptedPassword: Data, data: Data) -> String? {
    do {  let key = SymmetricKey(data: data)
        let sealedBox = try AES.GCM.SealedBox(combined: encryptedPassword)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        let decryptedMessage = String(data: decryptedData, encoding: .utf8)
        return decryptedMessage!
    } catch {
        print("error found")
        return nil
    }
    
}




