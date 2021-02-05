//
//  StockCell.swift
//  StockWatchList
//
//  Created by Sujit Molleti on 1/9/21.
//

import UIKit

class StockCell: UITableViewCell {
    @IBOutlet weak var stockSymbolLabel: UILabel!
    @IBOutlet weak var stockCompanyLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var stockChangePriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(stockData: StockData?){
        
        guard let data = stockData else{ return }
        
        stockSymbolLabel.text = data.stockName
        
        stockCompanyLabel.text = data.stockCompany
        
        stockPriceLabel.text = data.stockPrice
        
        stockChangePriceLabel.text = data.stockChangePrice
        stockChangePriceLabel.textColor = data.stockChangePrice.hasPrefix("+") ? UIColor.green : UIColor.red
    }

}
