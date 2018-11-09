//
//  RegionViewController.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import UIKit

protocol ListCellDelegate {
    func didSelectCell(indexPath: IndexPath)
}

final class RegionsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!

    private enum UIConstant {
        static let cellHeight:CGFloat = 44.0
        static let cellHeightDouble:CGFloat = 60.0
        static let letersInLine:Int = 36
    }

    public var router: ApplicationRouterType?
    public var interactor: RegionsVCInterctorType?
    public var imageCache: ImageSvgCache? 
    
    public var itemsList: Array<ListModelType> = [] {
        didSet {
            refreshTable()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        refreshData()
    }
    
    func setupView() {
        title = interactor?.title ?? ""
    }
    
    func refreshTable() {
        table.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func refreshData() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        interactor?.itemList()
    }
    
}

extension RegionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < itemsList.count {
            if let listItem = itemsList[indexPath.row] as? CountryModelType {
                let cellName = "countryCell"
                let cell = table.dequeueReusableCell(withIdentifier: cellName) as! CountryCell
                cell.indexPath = indexPath
                cell.titleLabel.text = listItem.name
                cell.descriptionLabel.text = listItem.nativeName
                cell.delegate = self
                cell.flagImage.loadSVGImageFrom(urlString: listItem.flag, imageCache: imageCache)
                return cell
            } else {
                let listItem = itemsList[indexPath.row]
                let cellName = "regionCell"
                let cell = table.dequeueReusableCell(withIdentifier: cellName) as! RegionCell
                cell.title.text = (listItem as ListModelType).name
                cell.indexPath = indexPath
                cell.delegate = self
                return cell
            }
        } else {
            print("Error create cell with indexPath: ", indexPath.row)
            return UITableViewCell()
        }
    }
}

extension RegionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if itemsList[indexPath.row] is CountryModelType {
            return UIConstant.cellHeightDouble
        }
        return itemsList[indexPath.row].name.count > UIConstant.letersInLine ? UIConstant.cellHeightDouble : UIConstant.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension RegionsViewController: ListCellDelegate {
    func didSelectCell(indexPath: IndexPath) {
        if indexPath.row < itemsList.count {
            if let country = itemsList[indexPath.row] as? CountryModel {
                router?.routeToDetail(country: country)
            } else {
              router?.routeDown(filterItem: itemsList[indexPath.row])
            }
        }
    }
}
