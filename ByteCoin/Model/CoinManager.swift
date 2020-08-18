import Foundation

protocol CoinManagerDelegate {
    func price(coin: Coin)
}
struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "30543B36-C57F-4E65-B259-D87531E7A5EA"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    if let rate = self.parseJSON(safeData) {
                        self.delegate?.price(coin: rate)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Coin? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let coin = Coin(rate: decodedData.rate, currency: decodedData.asset_id_quote)
            return coin
            
        } catch {
            return nil
        }
    }
    
}
