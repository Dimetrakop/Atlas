//
//  DetailsViewController.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import UIKit
import MapKit

struct DetailsView {
    let name: String
    let flag: String
    let currencies: String
    let lenguages: String
    let latitude: Double
    let longitude: Double
}

final class DetailsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapBGView: UIView!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var valuteImage: UIImageView!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var valuteLabel: UILabel!

    private enum UIConstant {
        static let cellHeight:CGFloat = 44.0
        static let cellHeightDouble:CGFloat = 80.0
        static let letersInLine:Int = 30
        static let cornerRadius: CGFloat = 18.0
        static let borderWidth: CGFloat = 1.0
        static let mapLatitudinalMeters: Double = 400000
        static let headerRect: CGRect = CGRect(x: 0, y: 0, width: 400, height: 30)
    }

    public var router: ApplicationRouterType?
    public var interactor: DetailsVCInteractorType?
    public var imageCache: ImageSvgCache?

    public var countriesList: [CountryModelType] = [] {
        didSet {
            refreshTable()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.countriesList()
    }

    func refreshTable() {
        activityIndicator.stopAnimating()
        table.reloadData()
    }
    
    func refreshData() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        interactor?.countriesList()
    }

    func setupView() {
        mapView.layer.borderWidth = UIConstant.borderWidth
        mapView.layer.cornerRadius = UIConstant.cornerRadius
        mapView.layer.borderColor = UIColor.aBorderColor.cgColor

        if let viewModel = interactor?.viewModel {
            title = viewModel.name
            languagesLabel.text = viewModel.lenguages
            valuteLabel.text = viewModel.currencies
            flagImage.loadSVGImageFrom(urlString: viewModel.flag, imageCache: imageCache)
            
            let coordinates = CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude)
            let coordinateRegion = MKCoordinateRegion(center: coordinates,
                                                      latitudinalMeters: UIConstant.mapLatitudinalMeters,
                                                      longitudinalMeters: UIConstant.mapLatitudinalMeters)
            mapView?.setRegion(coordinateRegion, animated:  true)
        }
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = "detailCell"
        let cell = table.dequeueReusableCell(withIdentifier: cellName) as! CountryCell
        let country = countriesList[indexPath.row]
        cell.indexPath = indexPath
        cell.titleLabel.text = country.name
        cell.descriptionLabel.text = country.nativeName
        cell.delegate = self
        cell.flagImage.loadSVGImageFrom(urlString: country.flag, imageCache: imageCache)
        return cell
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstant.cellHeightDouble
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel(frame: UIConstant.headerRect)
        headerLabel.text = "  Borders:"
        headerLabel.backgroundColor = UIColor.aTextBGColorGray
        return headerLabel
    }
}

extension DetailsViewController: ListCellDelegate {
    func didSelectCell(indexPath: IndexPath) {
        router?.routeToDetail(country: countriesList[indexPath.row])
    }
}
