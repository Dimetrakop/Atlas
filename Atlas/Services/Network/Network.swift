//
//  NetService.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/7/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Alamofire
import Foundation

protocol NetworkServiceType: class {
    func regionalBlock(_ regionalBlock: String, completion: @escaping ([CountryModel]?) -> ())
    func region(_ region: String, completion: @escaping ([CountryModel]?) -> ())
    func countriesWithCodes(_ codes: [String], completion: @escaping ([CountryModel]?) -> ())
    func searchCountry(_ name: String, completion: @escaping ([CountryModel]?) -> ())
}

final class NetworkService: NetworkServiceType {

    private var appSettings: ApplicationConfigType
    init(appSettings: ApplicationConfigType) {
        self.appSettings = appSettings
    }

    private func makeRequest<T: Codable>(url: URL, completion: @escaping (T?) -> ()) {
        Alamofire.request(url, method: .get, parameters: [:])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching ")
                    completion(nil)
                    return
                }
                do {
                    if let data = response.data {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(decodedData)
                    }
                } catch {
                    print(error)
                    completion(nil)
                }
        }
    }

    func regionalBlock(_ regionalBlock: String, completion: @escaping ([CountryModel]?) -> ()) {
        
        guard let url = URL(string: "\(appSettings.apiHost)v\(appSettings.apiVersion)/regionalbloc/\(regionalBlock)" ) else {
            completion(nil)
            return
        }
        makeRequest(url: url, completion: completion)
    }

    func region(_ region: String, completion: @escaping ([CountryModel]?) -> ()) {
        guard let url = URL(string: "\(appSettings.apiHost)v\(appSettings.apiVersion)/region/\(region)" ) else {
            completion(nil)
            return
        }
        makeRequest(url: url, completion: completion)
    }

    func countriesWithCodes(_ codes: [String], completion: @escaping ([CountryModel]?) -> ()) {
        let codesString = codes.joined(separator: ";")
        guard let url = URL(string: "\(appSettings.apiHost)v\(appSettings.apiVersion)/alpha?codes=\(codesString)" ) else {
            completion(nil)
            return
        }
        makeRequest(url: url, completion: completion)
    }

    func searchCountry(_ name: String, completion: @escaping ([CountryModel]?) -> ()) {
        guard let url = URL(string: "\(appSettings.apiHost)v\(appSettings.apiVersion)/name/\(name.lowercased())?fullText=false" ) else {
            completion(nil)
            return
        }
        makeRequest(url: url, completion: completion)
    }
}
