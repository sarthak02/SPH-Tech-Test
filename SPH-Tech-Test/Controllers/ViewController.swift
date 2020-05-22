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
            tableView.register(UINib(nibName: SPHConstants.Interface.yearDataCellIdentifier, bundle: nil), forCellReuseIdentifier: SPHConstants.Interface.yearDataCellIdentifier)
        }
    }
    var output: ViewControllerOutput?
    var yearsUsageArray: [YearDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = SPHConstants.Strings.appTitle
        ViewControllerConfigurator.sharedInstance.configure(controller: self)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.output?.getUsageData()
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,         preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: SPHConstants.Strings.okButtonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.yearsUsageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SPHConstants.Interface.yearDataCellIdentifier) as! YearDataTableViewCell
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
            self.showAlert(title: SPHConstants.Strings.errorTitle, message: error)
        }
    }
}
extension ViewController: YearDataCellDelegate {
    func dataDownfallButtonDidClick(year: YearDataModel?) {
        self.showAlert(title: SPHConstants.Strings.SPHMobileDataUsageTitle, message: SPHConstants.Strings.getYearDataDownFallString(year: year?.year))
    }
}

