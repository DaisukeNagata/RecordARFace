//
//  RARFTableCell.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/05/04.
//

import UIKit

open class RARFTableCell: UITableViewCell {

    var cellFlg = false
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "RARFTableCell")

        loadNib()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        loadNib()
    }

    func loadNib() {
        let bundle = Bundle(for: RARFTableCell.self)
        let view = bundle.loadNibNamed("RARFTableCell", owner: self, options: nil)?.first as! UIView
        view.frame = self.frame
        self.addSubview(view)
    }

    func didSelectBt(table: UITableView,eView: UIView) {
        DispatchQueue.main.async {
            if self.cellFlg == true {
                self.cellFlg = false
                guard table.indexPathForRow(at: eView.frame.origin)?.row == nil else {
                    table.selectRow(at: table.indexPathForRow(at: eView.frame.origin)!, animated: true, scrollPosition: UITableView.ScrollPosition(rawValue: table.indexPathForRow(at: eView.frame.origin)!.row)!)
                    table.delegate?.tableView!(table, didSelectRowAt: table.indexPathForRow(at: eView.frame.origin)!)
                    return
                }
            }
        }
    }
}
