//
//  ViewController.swift
//  Expandable_TableViewCell
//
//  Created by SeongMinK on 2022/01/12.
//

import UIKit
import ExpyTableView

class ViewController: UIViewController, ExpyTableViewDelegate, ExpyTableViewDataSource, MyCellDelegate {
    @IBOutlet weak var myExpandableTableView: ExpyTableView!
    
    let contentArray = [
        ["섹션 1 - 하나", "섹션 1 - 둘"],
        ["섹션 2 - 하나", "섹션 2 - 둘", "섹션 2 - 셋"],
        ["섹션 3 - 하나"],
        ["섹션 4 - 하나", "섹션 4 - 둘"],
        ["섹션 5 - 하나"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myExpandableTableView.delegate = self
        myExpandableTableView.dataSource = self
    }
    
    //MARK: - ExpyTableViewDelegate
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        print("changedForSection:", section)
        
        switch state {
        case .willExpand:
            print(".willExpand")
        case .willCollapse:
            print(".willCollapse")
        case .didExpand:
            print(".didExpand")
        case .didCollapse:
            print(".didCollapse")
        }
    }

    //MARK: - ExpyTableViewDataSource
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyHeaderCell") as! MyHeaderCell
        let bgView = UIView()
        
        cell.titleLabel.text = "섹션 \(section + 1)"
        bgView.backgroundColor = .green
        cell.selectedBackgroundView = bgView
        cell.sectionIndex = section
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray[section].count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDetailCell") as! MyDetailCell
        cell.titleLabel.text = contentArray[indexPath.section][indexPath.row - 1]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //MARK: - MyCellDelegate
    func didSwitchSetOn(cell: MyHeaderCell) {
        print(#fileID, #function, "called / cell.sectionIndex:", cell.sectionIndex)
        
        switch cell.mySwitch.isOn {
        case true:
            myExpandableTableView.expand(cell.sectionIndex)
        default:
            myExpandableTableView.collapse(cell.sectionIndex)
        }
        
    }
}

protocol MyCellDelegate: class {
    func didSwitchSetOn(cell: MyHeaderCell)
}
