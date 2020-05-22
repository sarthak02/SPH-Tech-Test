//
//  YearDataTableViewCell.swift
//  SPH-Tech-Test
//
//  Created by TA-002 on 22/05/20.
//  Copyright © 2020 Sarthak.org. All rights reserved.
//
import UIKit
class YearDataTableViewCell: UITableViewCell {
    @IBOutlet weak var yearLabel:UILabel! {
        didSet {
            yearLabel.font = UIFont(name: "HelveticaNeue", size: 40)
            yearLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var quaterStackView:UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(data: YearDataModel) {
        yearLabel.text = data.year + ": " + "\(data.total_volume)"
        self.emptyQuaterStack()
        for quater in data.quater_array {
            self.addQuaterData(quaterData: quater)
        }
    }
    func emptyQuaterStack() {
        for view in self.quaterStackView.subviews {
            view.removeFromSuperview()
        }
    }
    func addQuaterData(quaterData: QuarterDataModel) {
        let quaterLabel = UILabel()
        quaterLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        quaterLabel.numberOfLines = 0
        quaterLabel.text = quaterData.quarter + ": " + "\(quaterData.volume_of_mobile_data)"
        self.quaterStackView.addArrangedSubview(quaterLabel)
    }
}
