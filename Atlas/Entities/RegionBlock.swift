//
//  RegionBlock.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/8/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation

protocol RegionBlockModelType: ListModelType {
    var name: String { get set }
    var key: String { get set }
}

struct RegionalBlockModel: RegionBlockModelType {
    var name: String
    var key: String

    init(name: String, key: String) {
        self.name = name
        self.key = key
    }
}
