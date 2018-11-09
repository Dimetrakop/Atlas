//
//  RegionCell.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import UIKit

final class RegionCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var title: UILabel!

    var delegate: ListCellDelegate?
    var indexPath: IndexPath?
    
    private enum UIConstant {
        static let cornerRadius: CGFloat = 16.0
        static let borderWidth: CGFloat = 1.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        cellView.layer.cornerRadius = UIConstant.cornerRadius
        cellView.layer.borderColor = UIColor.aBorderColor.cgColor
        cellView.layer.borderWidth = UIConstant.borderWidth
    }
    
    @IBAction func detailButtonDidTap(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.didSelectCell(indexPath: indexPath)
        }
    }
    
    
}
