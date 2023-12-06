//
//  TableViewCell.swift
//  MvvmRxSwift
//
//  Created by Muhammed fatih Elçi on 6.12.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //cryptotableviewcellden sinifi icerisinde boyle bir possibility var ve tanimladigimizda itemi tanimladigimizda didset tanimlandigi gibi ben napim direk onu sorar didset bu ozellik tanimlandigi(item) gibi namelabel ve pricelabel gelen verileri esitler
    public var item: Crypto! {
        didSet {
            self.nameLabel.text = item.currency
            self.priceLabel.text = item.price
        }
    }
}
