//
//  RARFTableData.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/25.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

enum KeyboardCount: Int { case number, luangage, index }

final class RARFTableData: NSObject {}

// TODO MARK: UITableViewDataSource
extension RARFTableData: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KeyboardCount.index.rawValue
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RARFCell", for: indexPath)
        switch KeyboardCount(rawValue: indexPath.row) {
        case .number?:
            cell.textLabel?.text = "Calculator"
            return cell
        case .luangage?:
            cell.textLabel?.text = "Luangage"
            return cell
        default: break
        }
        return cell
    }
}
