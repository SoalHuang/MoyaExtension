//
//  MoyaProvider+ObjectMapper.swift
//  Bloks
//
//  Created by SoalHunag on 2018/9/11.
//  Copyright © 2018 soso. All rights reserved.
//

import Foundation
import Result
import ObjectMapper
import Moya

public extension MoyaProviderType where Target : Moya.TargetType {
    
    @discardableResult
    func request<T: Mappable>(_ target: Target,
                              mapType: T.Type,
                              progress: Moya.ProgressBlock? = .none,
                              callbackQueue: DispatchQueue = .main,
                              completion: @escaping (Result<ResponseBox<T>, MoyaError>) -> Void) -> Moya.Cancellable {
        return request(target, callbackQueue: callbackQueue, progress: progress) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error.format(by: target)))
            case .success(let response):
                let value = response.map(mapType: mapType)
                switch value {
                case .failure(let error):   completion(.failure(error))
                case .success(let mapped):  completion(.success(ResponseBox<T>(response: response, value: mapped)))
                }
            }
        }
    }
}

public extension MoyaProviderType where Target : TagedTargetType {
    
    @discardableResult
    func request<T: Mappable>(_ target: Target,
                              mapType: T.Type,
                              progress: Moya.ProgressBlock? = .none,
                              callbackQueue: DispatchQueue = .main,
                              completion: @escaping (Result<ResponseBox<T>, MoyaError>) -> Void) -> Moya.Cancellable {
        return request(target, callbackQueue: callbackQueue, progress: progress) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error.format(by: target)))
            case .success(let response):
                let value = response.map(mapType: mapType, tagedTarget: target)
                switch value {
                case .failure(let error):   completion(.failure(error))
                case .success(let mapped):  completion(.success(ResponseBox<T>(response: response, value: mapped)))
                }
            }
        }
    }
}
