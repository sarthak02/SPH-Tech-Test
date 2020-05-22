//
//  ViewController.swift
//  SPH-Tech-Test
//
//  Created by TA-002 on 22/05/20.
//  Copyright © 2020 Sarthak.org. All rights reserved.
//

import UIKit
import MBProgressHUD
protocol ViewControllerInput {
    func refreshUsageView(data: [YearDataModel])
    func getUserDataFailed(error: String)
}
protocol ViewControllerOutput {
    func getUsageData()
}
class ViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView! {
        didSet {
            tableView.register(UINib(nibName: "YearDataTableViewCell", bundle: nil), forCellReuseIdentifier: "YearDataTableViewCell")
        }
    }
    var output: ViewControllerOutput?
    var yearsUsageArray: [YearDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SPH Mobile Data Tracker"
        ViewControllerConfigurator.sharedInstance.configure(controller: self)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.output?.getUsageData()
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,         preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.yearsUsageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YearDataTableViewCell") as! YearDataTableViewCell
        cell.delegate = self
        cell.setData(data: self.yearsUsageArray[indexPath.row])
        return cell
    }
}
extension ViewController: ViewControllerInput {
    func refreshUsageView(data: [YearDataModel]) {
        self.yearsUsageArray = data
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
        }
    }
    func getUserDataFailed(error: String) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlert(title: "Error", message: error)
        }
    }
}
extension ViewController: YearDataCellDelegate {
    func dataDownfallButtonDidClick(year: YearDataModel?) {
        self.showAlert(title: "SPH MOBILE DATA USAGE", message: "Some quater(s) in \(year?.year ?? "") showed drop in data consumtion.")
    }
}

