//
//  Country.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/8/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation

protocol CountryModelType: ListModelType {
    var name: String { get set }
    var key: String { get set }
    var flag: String { get set }
    var region: String { get set }
    var latlng: Array<Double> { get set }
    var currencies: [Currency] { get set }
    var languages: [Language] { get set }
    var borders: Array<String> { get set }
    var nativeName: String { get set }
}

struct CountryModel: CountryModelType {
    var name: String
    var key: String = ""
    var flag: String
    var region: String
    var latlng: Array<Double>
    var currencies: [Currency]
    var languages: [Language]
    var borders: Array<String>
    var nativeName: String

    enum CodingKeys: String, CodingKey {
        case name
        case key
        case flag
        case latlng
        case currencies
        case languages
        case borders
        case nativeName
        case region
    }

    init(name: String, flag: String, latlng: Array<Double>, currencies: [Currency], languages: [Language], borders: Array<String>, nativeName: String, region: String) {
        self.name = name
        self.flag = flag
        self.latlng = latlng
        self.currencies = currencies
        self.languages = languages
        self.borders = borders
        self.nativeName = nativeName
        self.region = region
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        flag = try values.decode(String.self, forKey: .flag)
        latlng = try values.decode(Array<Double>.self, forKey: .latlng)
        currencies = try values.decode([Currency].self, forKey: .currencies)
        languages = try values.decode([Language].self, forKey: .languages)
        borders = try values.decode(Array<String>.self, forKey: .borders)
        nativeName = try values.decode(String.self, forKey: .nativeName)
        region = try values.decode(String.self, forKey: .region)
    }
}

struct Currency: Codable {
    let code: String?
    let name: String?
    let symbol: String?
}

struct Language: Codable {
    let iso639_1: String?
    let iso639_2: String?
    let name: String?
    let nativeName: String?
}
