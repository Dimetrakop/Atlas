//
//  DetailsVCInteractor.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/7/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation

protocol DetailsVCInteractorType {
    var viewModel: DetailsView? { get }
    func countriesList()
}

final class DetailsVCInteractor: DetailsVCInteractorType {

    private weak var delegate: DetailsViewController?
    private var networkService: NetworkServiceType
    private var country: CountryModelType

    var viewModel: DetailsView? {
        return prepareView()
    }

    init(networkService: NetworkServiceType,
         delegateView: DetailsViewController,
         country: CountryModelType)
    {
        self.networkService = networkService
        delegate = delegateView
        self.country = country
    }

    func prepareView() -> DetailsView? {
        var languages = ""
        for language in country.languages {
            languages.append("\(languages.count > 0 ? "," : "")\(language.name ?? "")")
        }
        var currencies = ""
        for currency in country.currencies {
            currencies.append("\(currencies.count > 0 ? "," : "")\(currency.name ?? "")")
        }
        let latitude = country.latlng[0]
        let longitude = country.latlng[1]
        let flag = country.flag
        return DetailsView(name: country.name, flag: flag, currencies: currencies, lenguages: languages, latitude: latitude, longitude: longitude)
    }

    func countriesList() {
        if country.borders.count <= 0 {
            delegate?.countriesList = []
            return
        }
        networkService.countriesWithCodes(country.borders) { [ weak self ] countries in
            guard let that = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                that.delegate?.countriesList = countries ?? []
            }
        }
    }
}
