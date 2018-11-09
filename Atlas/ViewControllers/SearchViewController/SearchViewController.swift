//
//  SearchViewController.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    private enum UIConstant {
        static let toolBarWidth: CGFloat = 320.0
        static let toolBarHeight: CGFloat = 50.0
        static let buttonRadius: CGFloat = 6.0
    }
    
    public var itemsList: Array<ListModelType> = [] {
        didSet {
            refreshTable()
        }
    }

    public var router: ApplicationRouterType?
    public var interactor: SearchVCInteractorType?
    public var imageCache: ImageSvgCache?
    public var isFirstDataSet = true
    private var doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIConstant.toolBarWidth, height: UIConstant.toolBarHeight))

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTable()
        setupView()
    }

    func setupView() {
        let done: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelBtnClick))
        doneToolbar.items = [done]
        searchBar.inputAccessoryView = doneToolbar
        searchBar.inputAccessoryView = doneToolbar
    }

    func refreshTable() {
        table.reloadData()
        activityIndicator.stopAnimating()
        noResultsLabel.isHidden = itemsList.count > 0 || isFirstDataSet == true
    }

    @objc
    private func cancelBtnClick() {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = "searchCell"
        let cell = table.dequeueReusableCell(withIdentifier: cellName) as! CountryCell
        cell.indexPath = indexPath
        if let listItem = itemsList[indexPath.row] as? CountryModelType {
            cell.titleLabel.text = listItem.name
            cell.descriptionLabel.text = listItem.nativeName
            cell.delegate = self
            cell.flagImage.loadSVGImageFrom(urlString: listItem.flag, imageCache: imageCache)
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            activityIndicator.isHidden = false
            isFirstDataSet = false
            interactor?.searchCountry(name:  searchText)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("XXX")
    }
}

extension SearchViewController: ListCellDelegate {
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
