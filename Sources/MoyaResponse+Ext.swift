//
//  MoyaResponse+Ext.swift
//  MoyaExtension
//
//  Created by SoalHunag on 2020/1/17.
//  Copyright © 2020 SoalHunag. All rights reserved.
//

import Foundation
import Result
import ObjectMapper
import Moya

public let ErrorDomain: String = "com.sd.extension.moya.error.domain"

public extension Moya.Response {
    
    func map<T: Mappable>(mapType: T.Type) -> Result<T, MoyaError> {
        do {
            let json = try mapJSON()
            guard let mapped = Mapper<T>().map(JSONObject: json) else {
                return .failure(MoyaError.jsonMapping(self))
            }
            return .success(mapped)
        } catch {
            let userInfo: [String : Any] = ["statusCode" : statusCode, NSLocalizedDescriptionKey: NormalErrorMessage + "(\(statusCode))"]
            let customError = NSError(domain: ErrorDomain, code: statusCode, userInfo: userInfo)
            return .failure(.underlying(customError, self))
        }
    }
    
    func map<T: Mappable>(mapType: T.Type, tagedTarget: TagedTargetType) -> Result<T, MoyaError> {
        do {
            let json = try mapJSON()
            guard let mapped = Mapper<T>().map(JSONObject: json) else {
                return .failure(MoyaError.jsonMapping(self))
            }
            return .success(mapped)
        } catch {
            var codeText: String = ""
            if let tag = tagedTarget.tag {
                codeText = "\(tag)-\(statusCode)"
            } else {
                codeText = "\(statusCode)"
            }
            let userInfo: [String : Any] = ["statusCode" : statusCode, NSLocalizedDescriptionKey: NormalErrorMessage + "(\(codeText))"]
            let customError = NSError(domain: ErrorDomain, code: statusCode, userInfo: userInfo)
            return .failure(.underlying(customError, self))
        }
    }
}
