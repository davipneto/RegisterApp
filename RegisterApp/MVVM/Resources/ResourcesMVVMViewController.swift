//
//  ResourcesMVVMViewController.swift
//  RegisterApp
//
//  Created by Curitiba01 on 18/09/21.
//

import UIKit
import RxSwift

class ResourcesMVVMViewController: UITableViewController {
    // MARK: - Variables
    var resources = [Resource]() {
        didSet {
            tableView.reloadData()
        }
    }
    var selectedCell: IndexPath?
    let viewModel = ResourcesViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getResources()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "ResourcesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "resourcesCell")
        tableView.rowHeight = 90
        tableView.tableHeaderView = getTableViewHeader()
    }
    
    private func getResources() {
        viewModel.getResources()
            .subscribe { resources in
                self.resources = resources
            } onError: { error in
                DispatchQueue.main.async {
                    self.showAlert(title: "Erro", message: error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func getTableViewHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let label = UILabel()
        label.text = "Cores Pantone"
        label.font = label.font.withSize(20)
        headerView.addSubview(label)
        label.centerOnSuperview()
        return headerView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resourcesCell") as! ResourcesTableViewCell
        cell.resource = resources[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCell == indexPath {
            return 130
        }
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath
        UIView.animate(withDuration: 1) {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}
