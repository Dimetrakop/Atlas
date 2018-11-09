//
//  ApplicationConfig.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/7/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation

protocol ApplicationConfigType {
    var apiHost: String { get }
    var apiVersion: String { get }
    var regions: Array<ListModelType> { get }
}

struct StageApplicationConfig: ApplicationConfigType {
    let apiHost = "https://restcountries.eu/rest/"
    let apiVersion: String = "2"
    var regions: Array<ListModelType> = [
        RegionModel(name: "Africa"),
        RegionModel(name: "Americas"),
        RegionModel(name: "Asia"),
        RegionModel(name: "Europe"),
        RegionModel(name: "Oceania"),
        RegionalBlockModel(name: "European Union", key: "EU"),
        RegionalBlockModel(name: "European Free Trade Association", key: "EFTA"),
        RegionalBlockModel(name: "Caribbean Community", key: "CARICOM"),
        RegionalBlockModel(name: "Pacific Alliance", key: "PA"),
        RegionalBlockModel(name: "African Union", key: "AU"),
        RegionalBlockModel(name: "Union of South American Nations", key: "USAN"),
        RegionalBlockModel(name: "Eurasian Economic Union", key: "EEU"),
        RegionalBlockModel(name: "Arab League", key: "AL"),
        RegionalBlockModel(name: "Association of Southeast Asian Nations", key: "ASEAN"),
        RegionalBlockModel(name: "Central American Integration System", key: "CAIS"),
        RegionalBlockModel(name: "Central European Free Trade Agreement", key: "CEFTA"),
        RegionalBlockModel(name: "North American Free Trade Agreement", key: "NAFTA"),
        RegionalBlockModel(name: "South Asian Association for Regional Cooperation", key: "SAARC")
    ]
}
