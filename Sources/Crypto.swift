//
//  Crypto.swift
//  SecureTransfer
//
//  Created by Alsey Coleman Miller on 12/10/17.
//  Copyright © 2017 ColemanCDA. All rights reserved.
//

import Foundation
import CryptoSwift

/// Generate random data with the specified size.
public func random(_ size: Int) -> Data {
    
    let bytes = AES.randomIV(size)
    
    return Data(bytes: bytes)
}

public let HMACSize = 64

/// Performs HMAC with the specified key and message.
@inline(__always)
public func HMAC(key: KeyData, message: Nonce) -> Data {
    
    let hmac = try! CryptoSwift.HMAC(key: key.data.bytes, variant: .sha512).authenticate(message.data.bytes)
    
    assert(hmac.count == HMACSize)
    
    return Data(bytes: hmac)
}

public let IVSize = AES.blockSize

/// Encrypt data
public func encrypt(key: Data, data: Data) -> (encrypted: Data, iv: InitializationVector) {
    
    let iv = InitializationVector()
    
    let crypto = try! AES(key: key.bytes, iv: iv.data.bytes)
    
    let byteValue = try! crypto.encrypt(data.bytes)
    
    return (Data(bytes: byteValue), iv)
}

/// Decrypt data
public func decrypt(key: Data, iv: InitializationVector, data: Data) -> Data {
    
    assert(iv.data.count == IVSize)
    
    let crypto = try! AES(key: key.bytes, iv: iv.data.bytes)
    
    let byteValue = try! crypto.decrypt(data.bytes)
    
    return Data(bytes: byteValue)
}
