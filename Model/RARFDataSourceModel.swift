//
//  RARFDataSourceModel.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/05/05.
//

import UIKit

final public class RARFDataSourceModel: NSObject {
    var indexNumber = 0
    var cells = RARFTableCell()
    var indexPath = IndexPath()
}

//MARK: UITableViewDelegate UITableViewDataSource
extension RARFDataSourceModel: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row, "RARFTableCell")
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RARFTableCell", for: indexPath) as? RARFTableCell {
            cells = cell
            self.indexPath = indexPath
            cell.textLabel?.text = indexPath.row.description
            return cell
        }
        return UITableViewCell()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexNumber
    }
}
