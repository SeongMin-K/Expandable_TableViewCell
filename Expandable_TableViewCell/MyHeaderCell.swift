//
//  MyHeaderCell.swift
//  Expandable_TableViewCell
//
//  Created by SeongMinK on 2022/01/12.
//

import Foundation
import UIKit
import ExpyTableView

class MyHeaderCell: UITableViewCell, ExpyTableViewHeaderCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var imgView: UIImageView!
    
    weak var delegate: MyCellDelegate?
    
    var sectionIndex: Int = 0 {
        didSet {
            print("MyHeaderCell - sectionIndex didSet():", sectionIndex)
        }
    }
    
    @IBAction func onMySwitchValueChanged(_ sender: UISwitch) {
        print(#fileID, #function, "called / isOn:", sender.isOn)
        delegate?.didSwitchSetOn(cell: self)
    }
    
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        print("MyHeaderCell - state: \(state) / cellReuse: \(cellReuse)")
        switch state {
        case .willExpand:
            print(".willExpand")
            mySwitch.setOn(true, animated: !cellReuse)
            arrowDown(animated: !cellReuse)
        case .willCollapse:
            print(".willCollapse")
            mySwitch.setOn(false, animated: !cellReuse)
            arrowUp(animated: !cellReuse)
        case .didExpand:
            print(".didExpand")
            imgView.tintColor = .green
        case .didCollapse:
            print(".didCollapse")
            imgView.tintColor = .red
        }
    }
    
    fileprivate func arrowDown(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0), animations: {
            self.imgView.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        })
    }
    
    fileprivate func arrowUp(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0), animations: {
            self.imgView.transform = CGAffineTransform(rotationAngle: 0)
        })
    }
}


