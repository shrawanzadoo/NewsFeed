import UIKit

extension UITableView {

    /**
     Convenience method to register a nib for the cells in this table view
     The name of the nib has to be the same as the name of the cell class
     */
    func registerTableViewCellNib(_ cellClass: UITableViewCell.Type) {
        let nib = UINib(nibName: "\(cellClass.self)", bundle: nil)
        register(nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
}
