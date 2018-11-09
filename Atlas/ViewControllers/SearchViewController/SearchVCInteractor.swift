//
//  SearchInterctor.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation

protocol SearchVCInteractorType {
    func searchCountry(name: String)
}

final class SearchVCInteractor: SearchVCInteractorType {
    private weak var delegate: SearchViewController?
    private var networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType, delegateView: SearchViewController) {
        delegate = delegateView
        self.networkService = networkService
    }
    
    func searchCountry(name: String) {
        networkService.searchCountry(name) { [ weak self ] countries in
            guard let that = self else { return }
            that.delegate?.itemsList = countries ?? []
        }
    }
    
}
