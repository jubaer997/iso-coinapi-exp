import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    @IBOutlet weak var bitcoinLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getPrice(for: coinManager.currencyArray[row])
    }
    
    
    func price(coin: Coin) {
        DispatchQueue.main.async {
            self.bitcoinLbl.text = String(format: "%.2f", coin.rate)
            self.currencyLbl.text = coin.currency
        }
    }
    
}

