//
//  ObjectMapper+Ext.swift
//  MoyaExtension
//
//  Created by SoalHunag on 2020/1/17.
//  Copyright © 2020 SoalHunag. All rights reserved.
//

import ObjectMapper
import SDFoundation

public extension SDExtension where T == Data {
    
    func map<T: Mappable>(mapType: T.Type) -> T? {
        guard
            let json = try? JSONSerialization.jsonObject(with: base, options: .allowFragments),
            let mapped = Mapper<T>().map(JSONObject: json)
            else {
            return nil
        }
        return mapped
    }
}
