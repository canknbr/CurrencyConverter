//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Can Kanbur on 31.03.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var trLabel: UILabel!
    @IBOutlet var usdLabel: UILabel!
    @IBOutlet var jpyLabel: UILabel!
    @IBOutlet var gbpLabel: UILabel!
    @IBOutlet var chfLabel: UILabel!
    @IBOutlet var cadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getRates(_ sender: Any) {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        let session = URLSession.shared

        let task = session.dataTask(with: url!) { data, _, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            if let rates =  jsonResponse["rates"] as? [String : Any]{
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let tr = rates["TRY"] as? Double {
                                    self.trLabel.text = "TRY: \(tr)"
                                }
                            }
                        }
                        
                    } catch {
                    }
                }
            }
        }
        task.resume()
    }
}
