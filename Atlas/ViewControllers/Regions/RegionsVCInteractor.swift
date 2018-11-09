//
//  Interacotr.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation

protocol RegionsVCInterctorType {
    var filterItem: ListModelType? { get set }
    var title: String { get }
    func itemList()
}

final class RegionsVCInterctor: RegionsVCInterctorType {
    var regionList: Array<ListModelType> { return appConfig.regions }
    var filterItem: ListModelType? {
        didSet {
            if let name = filterItem?.name {
                title =  name
            }
        }
    }
    var title: String = "Regions"
    
    private weak var delegate: RegionsViewController?
    private var networkService: NetworkServiceType
    private var appConfig: ApplicationConfigType

    init(networkService: NetworkServiceType,
         delegateView: RegionsViewController,
         appConfig: ApplicationConfigType )
    {
        delegate = delegateView
        self.networkService = networkService
        self.appConfig = appConfig
    }

    func itemList() {
        if let filterItem = filterItem {
            if filterItem is RegionModelType {
                networkService.region(filterItem.key) { [ weak self ] countries in
                    guard let that = self else { return }
                    that.delegate?.itemsList = countries ?? []
                }
            } else {
                networkService.regionalBlock(filterItem.key) { [ weak self ] countries in
                    guard let that = self else { return }
                    that.delegate?.itemsList = countries ?? []
                }
            }
        } else {
            delegate?.itemsList = appConfig.regions
        }
    }

}
