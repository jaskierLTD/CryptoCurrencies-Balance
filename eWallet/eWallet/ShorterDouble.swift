//
//  ShorterDouble.swift
//  eWallet
//
//  Created by Alessandro Marconi on 18/07/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import Foundation

extension Double {
    
    func makeShort1f() -> NSString {
        return NSString(format: "%0.01f", self as CVarArg)
    }
    
    func makeShort2f() -> NSString {
        return NSString(format: "%0.02f", self as CVarArg)
    }
}
