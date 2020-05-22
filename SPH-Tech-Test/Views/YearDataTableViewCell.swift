//
//  YearDataTableViewCell.swift
//  SPH-Tech-Test
//
//  Created by TA-002 on 22/05/20.
//  Copyright © 2020 Sarthak.org. All rights reserved.
//
import UIKit
protocol YearDataCellDelegate {
    func dataDownfallButtonDidClick(year: YearDataModel?)
}
class YearDataTableViewCell: UITableViewCell {
    @IBOutlet weak var yearLabel: UILabel! {
        didSet {
            yearLabel.font = UIFont(name: "HelveticaNeue", size: 40)
            yearLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var dataDownfallButton: UIButton!
    @IBOutlet weak var quaterStackView:UIStackView!
    var yearData: YearDataModel?
    var delegate: YearDataCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func downfallButtonClicked() {
        self.delegate?.dataDownfallButtonDidClick(year: self.yearData)
    }
    func setData(data: YearDataModel) {
        self.yearData = data
        yearLabel.text = data.year + ": " + String(format: "%.5f", data.total_volume)
        dataDownfallButton.isHidden = !data.did_volume_decrease
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
        quaterLabel.text = quaterData.quarter + ": " + String(format: "%.5f", quaterData.volume_of_mobile_data)
        self.quaterStackView.addArrangedSubview(quaterLabel)
    }
}
