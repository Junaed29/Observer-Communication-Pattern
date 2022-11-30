//
//  SecondViewController.swift
//  NotificationObserver
//
//  Created by Emmanuel Okwara on 31/05/2020.
//  Copyright © 2020 Macco. All rights reserved.
//

import UIKit

var secondVCIsListening = false

class SecondViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var listeningSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if secondVCIsListening {
            listeningSwitch.setOn(true, animated: false)
            switchToggled(listeningSwitch)
        }
    }
    
    deinit {
        removeObserver()
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            self.view.backgroundColor = .green
            self.titleLbl.text = "Listening"
            secondVCIsListening = true
            setUpObserver()
        } else {
            self.view.backgroundColor = .darkGray
            self.titleLbl.text = "Not Listening"
            secondVCIsListening = false
            removeObserver()
        }
    }
    
    
    func setUpObserver() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotification(_:)), name: .myNotificationName, object: nil)
    }
    
    func removeObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleNotification(_ sender: Notification){
        titleLbl.text = sender.userInfo?["name"] as? String
    }
}
