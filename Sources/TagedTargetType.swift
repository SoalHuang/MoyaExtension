//
//  TagedTargetType.swift
//  MoyaExtension
//
//  Created by SoalHunag on 2020/3/9.
//  Copyright © 2020 SoalHunag. All rights reserved.
//

import Moya

public protocol TagedTargetType: Moya.TargetType {
    
    var named: String? { get }
    var tag: Int? { get }
}

extension TagedTargetType {
    
    public var named: String? { return nil }
    public var tag: Int? { return nil }
}
