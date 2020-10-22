//
//  MoyaTargetType+Ext.swift
//  MoyaExtension
//
//  Created by SoalHunag on 2020/4/28.
//  Copyright © 2020 SoalHunag. All rights reserved.
//

import Moya
import SDFoundation

public extension Moya.TargetType {
    
    var identifer: String {
        return baseURL.absoluteString + path + "?method=" + method.rawValue
    }
    
    var cacheKey: String {
        let key = baseURL.absoluteString + "#" + path + "#" + method.rawValue
        switch task {
        case .requestPlain:
            return key.sd.md5
            
        case .requestData(let data):
            return "\(key)\(data)".sd.md5
            
        case .requestParameters(let para, _):
            let paraIdentifier = para.compactMap({ "\($0.key):\($0.value)" }).sorted().joined(separator: "#")
            return "\(key)\(paraIdentifier)".sd.md5
            
        case .requestCompositeData(let data, let para):
            let paraIdentifier = para.compactMap({ "\($0.key):\($0.value)" }).sorted().joined(separator: "#")
            return "\(key)\(paraIdentifier)\(data)".sd.md5
            
        case .requestCompositeParameters(let bd, _, let para):
            let paraIdentifier = para.compactMap({ "\($0.key):\($0.value)" }).sorted().joined(separator: "#")
            return "\(key)\(paraIdentifier)\(bd)".sd.md5
            
        default: return key
        }
    }
}
