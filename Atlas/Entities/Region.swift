//
//  Region.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/8/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation

protocol RegionModelType: ListModelType {
    var name: String { get set }
    var key: String { get set }
}

struct RegionModel: RegionModelType {
    var name: String
    var key: String

    init(name: String) {
        self.name = name
        self.key = name
    }
}
