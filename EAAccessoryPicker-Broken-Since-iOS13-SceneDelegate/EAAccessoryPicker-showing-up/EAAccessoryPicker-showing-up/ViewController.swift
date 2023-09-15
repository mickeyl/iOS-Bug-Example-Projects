//
//  ViewController.swift
//  EAAccessoryPicker-showing-up
//
//  Created by Dr. Michael Lauer on 12.05.22.
//

import UIKit
import ExternalAccessory

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.view.backgroundColor = UIColor.green
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            EAAccessoryManager.shared().showBluetoothAccessoryPicker(withNameFilter: nil) { _ in
                print("Done")
            }
        }
        
        // Do any additional setup after loading the view.
    }


}

