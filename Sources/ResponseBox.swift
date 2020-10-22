//
//  ResponseBox.swift
//  MoyaExtension
//
//  Created by SoalHunag on 2020/5/9.
//  Copyright © 2020 SoalHunag. All rights reserved.
//

import ObjectMapper
import Result
import Moya
import SDFoundation

extension ResponseBox: SDExtensionCompatible { }

public struct ResponseBox<Value> {
    
    public let response: Moya.Response
    public let value: Value
    
    public init(response: Moya.Response, value: Value) {
        self.response = response
        self.value = value
    }
}


extension Result: SDExtensionCompatible { }

public protocol MoyaWrapable {
    
    func wrap<M: Mappable>(mapType: M.Type) -> Result<M, MoyaError>
}

public extension SDExtension where T: MoyaWrapable {
    
    func wrap<M: Mappable>(mapType: M.Type) -> Result<M, MoyaError> {
        return base.wrap(mapType: mapType)
    }
}

extension Result: MoyaWrapable where Value: MoyaWrapable, Error: MoyaWrapable {
    
    public func wrap<M: Mappable>(mapType: M.Type) -> Result<M, MoyaError> {
        switch self {
        case .success(let box): return box.wrap(mapType: mapType)
        case .failure(let err): return err.wrap(mapType: mapType)
        }
    }
}

extension ResponseBox: MoyaWrapable {
    
    public func wrap<M: Mappable>(mapType: M.Type) -> Result<M, MoyaError> {
        if let res = value as? M { return .success(res) }
        return response.map(mapType: mapType.self)
    }
}

extension MoyaError: MoyaWrapable {
    
    public func wrap<M: Mappable>(mapType: M.Type) -> Result<M, MoyaError> {
        guard let res = response else { return .failure(self) }
        return res.map(mapType: mapType.self)
    }
}
