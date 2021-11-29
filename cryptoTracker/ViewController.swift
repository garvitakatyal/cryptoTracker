//
//  ViewController.swift
//  cryptoTracker
//
//  Created by Garvita Katyal on 11/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let symbol = textField.text {
            getData(symbol : symbol)
        }
    }
    
    var url = "https://min-api.cryptocompare.com/data/price?tsyms=USD"
    func getData(symbol : String) {
        url = "\(url)&fsym=\(symbol)"
        
        //1. Initialize URL
        guard let url = URL(string: url) else {return}
        
        //2. Initialize Task and URL Session
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
        
        //3 Check Optionals
        guard let data = data, error == nil else {return}
        print("Data recieved")
        do {
            let Result = try JSONDecoder().decode(APIResponse.self, from: data)
            print(Result.USD)
        
            //               |HOV (Grand Central Dispatch)|1|2|3|4|5|
            //
            //                sync | async | concurrency | sequential
            //
            //
            //                seq : A -> B -> C
            //                conc :
            //                A -----end time
            //                B ----------
            //                C -----
            //
            //                0
            
            DispatchQueue.main.async{
                                    
                self.outputLabel.text = "\(Result.USD)"
                                    
            }
                    
        }
        catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
        
    }
    
    //5. Define Response Parameters in a Structure
    
    struct APIResponse : Codable {
        let USD : Float
    }
    
    
    

    
}

