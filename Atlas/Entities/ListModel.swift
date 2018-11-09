//
//  BlockModel.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/7/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation

protocol ListModelType: Codable {
    var name: String  { get set }
    var key: String { get set }
}
