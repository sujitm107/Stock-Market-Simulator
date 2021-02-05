//
//  WatchListViewController.swift
//  StockWatchList
//
//  Created by Sujit Molleti on 1/9/21.
//

import UIKit

class WatchListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    let stocksSymbols: [String] = ["S&P 500", "NYSE", "Dow Jones", "NASDAQ", "AAPL", "GOOG", "AMZN", "FB", "VZ", "SBUX", "NKE"]
//    let stockCompanys: [String] = ["S&P 500", "NYSE Composite (DJ)", "Dow Jones Industrial Average", "NASDAQ Composite", "Apple Inc.", "Alphabet Inc.", "Amazon.com, Inc.", "Facebook, Inc.", "Verizon Communications", "Starbucks Corporation", "Nike, Inc."]
//    let stockPrices: [String] = ["3,824.68", "14,966.83", "31,097.97", "13,201.98", "132.05", "1,807.21", "3,182.70", "267.57", "57.80", "105.67", "146.35"]
//    let stockChangePrices: [String] = ["+20.89", "+38.08", "+56.84", "+134.50", "+1.13", "+19.96", "+20.54", "-1.17", "-0.73", "+2.32", "+1.40"]
    
    var stockDataList: StockDataList?
    var timer: Timer?

    @IBOutlet weak var stockSearchBar: UISearchBar!
    @IBOutlet weak var watchListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        watchListTableView.dataSource = self
        watchListTableView.delegate = self
        
        getStockData()
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(getStockData), userInfo: nil, repeats: true)
        
    }
    
    @objc func getStockData(){
        makeRequest { (data) in
            
            DispatchQueue.main.async {
                self.stockDataList = data
                self.watchListTableView.reloadData()
            }
        }
        
    }
    
    
    func makeRequest(completion: @escaping (StockDataList) -> ()){
        guard let url = URL(string: "http://localhost:3000") else { return }

        let request = URLRequest(url: url)

        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, err) in
            if(data != nil && err == nil){
                
                let decoder = JSONDecoder()
                
                do {
                    let json = try decoder.decode(StockDataList.self, from: data!)
                    completion(json)
                } catch {
                    print("Unable To Parse")
                }
                
//                print(data)
                
            } else {
                print("error")
            }
        }.resume()
    }
    

}

extension WatchListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockDataList?.stocks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        
//        let symbol = stocksSymbols[indexPath.row]
//        let company = stockCompanys[indexPath.row]
//        let price = stockPrices[indexPath.row]
//        let changePrice = stockChangePrices[indexPath.row]
        
        cell.setCell(stockData: stockDataList?.stocks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
