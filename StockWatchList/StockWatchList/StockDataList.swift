//
//  StockDataList.swift
//  StockWatchList
//
//  Created by Sujit Molleti on 1/10/21.
//

import Foundation

struct StockDataList: Codable {
    let stocks: [StockData]
}

struct StockData: Codable{
    let stockName: String
    let stockCompany: String
    let stockPrice: String
    let stockChangePrice: String
    
}
