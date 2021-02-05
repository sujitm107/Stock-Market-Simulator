const http = require('http');

let stockNames = ["S&P 500", "NYSE", "Dow Jones", "NASDAQ", "AAPL", "GOOG", "AMZN", "FB", "VZ", "SBUX", "NKE"];
let companies = ["S&P 500", "NYSE Composite (DJ)", "Dow Jones Industrial Average", "NASDAQ Composite", "Apple Inc.", "Alphabet Inc.", "Amazon.com, Inc.", "Facebook, Inc.", "Verizon Communications", "Starbucks Corporation", "Nike, Inc."]

function getRandomPrice(){

    //generate Number between 1 and 1000
    let num = (Math.random()*1000).toFixed(2) + 1;
    return num.toString();
}

function getRandomChangePrice(){

    let num = Math.floor((Math.random()*2));

    let change = num === 1 ? "+" : "-";

    return change + getRandomPrice();

}

function createData(){
    // let data = {
    //     "stockName": "AAPL",
    //     "stockCompany": "APPLE INC.",
    //     "stockPrice": "200.43",
    //     "stockChangePrice": "+23.45"
    // };

    var temp = [];

    for(i = 0; i<stockNames.length; i++){
        
        let name = stockNames[i];
        let company = companies[i];
        let price = getRandomPrice();
        let changePrice = getRandomChangePrice();

        temp.push({
            "stockName": name,
            "stockCompany": company,
            "stockPrice": price,
            "stockChangePrice": changePrice
        });
    }
    
    let dataList = {
        "stocks": temp
    };

    return dataList;
}

const server = http.createServer((req, res)=>{

    let data = createData()

    if(req.url === '/'){
        res.write(JSON.stringify(data));
        res.end();
    }
    
});

//emit
server.listen(3000)
console.log('Listening on port 3000')