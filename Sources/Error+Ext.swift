//
//  Error+Ext.swift
//  MoyaExtension
//
//  Created by SoalHunag on 2020/4/27.
//  Copyright © 2020 SoalHunag. All rights reserved.
//

import Foundation
import Alamofire
import Moya

internal let NormalErrorMessage = "出错了，请稍后重试"

extension Error {
    
    public var statusCode: Int {
        if let alamofireError = self as? AFError {
            return alamofireError.statusCode
        }
        if let moyaError = self as? MoyaError {
            return moyaError.statusCode
        }
        return (self as NSError).code
    }
    
    public var isCancelled: Bool {
        return statusCode == URLError.cancelled.rawValue
    }
}
