//
//  SettingsViewController.swift
//  crypto-chat
//
//  Created by Kushka Misha on 3/18/20.
//  Copyright © 2020 Misha Kushka. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    
    @IBOutlet weak var keywordsCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTitleView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var langSegmentedControl: UISegmentedControl!
    @IBOutlet weak var txTableView: UITableView!

    @IBOutlet weak var headerDate: UILabel!
    @IBOutlet weak var headerAmount: UILabel!
    
    let descriptionText = NSLocalizedString("noDescription", comment: "")
    let keywords: [String] = ["consulting", "blockchain", "smart contracts", "teaching", "+"]
    let languages = [["Українська", "uk"], ["English", "en"]]
    var currentLangCode: String = Locale.current.languageCode ?? ""
    let txs: [Tx] = [
        Tx(date: "15 June 2015 99:99:99", userName: "David Coperfield", direction: "in", amount: "0.00000"),
        Tx(date: "15 June 2015 99:99:99", userName: "David Coperfield", direction: "out", amount: "0.00000"),
        Tx(date: "15 June 2015 99:99:99", userName: "David Coperfield", direction: "in", amount: "0.00000"),
        Tx(date: "15 June 2015 99:99:99", userName: "David Coperfield", direction: "out", amount: "0.00000"),
        Tx(date: "15 June 2015 99:99:99", userName: "David Coperfield", direction: "in", amount: "0.00000")
    ]
    let months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)

        setStatusBarBackgroundColor(color : purple)
        self.view.backgroundColor = purple
        setupInputFields()
    }
    
    @IBAction func changeLang(_ sender: Any) {
        if currentLangCode != languages[langSegmentedControl.selectedSegmentIndex][1] {
            print("The language was changed")
            
            // Alert to restart app to change the app language
            let alertController = UIAlertController(title: NSLocalizedString("langChange", comment: ""), message: NSLocalizedString("langChangeDescr", comment: ""), preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                
                self.currentLangCode = self.languages[self.langSegmentedControl.selectedSegmentIndex][1]
                UserDefaults.standard.set([self.currentLangCode], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                
                exit(0)
            }
            let cancelAction = UIAlertAction(title: NSLocalizedString("restartLater", comment: ""), style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                self.selectCorrectLang()
                NSLog("Cancel Pressed")
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        print(currentLangCode)
    }
    
    @objc func rightSwipeAction(swipe: UISwipeGestureRecognizer) {
        NSLog("right swipe action")
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MessagesScreen") as! ChatViewController
        self.present(vc, animated: true, completion: nil)
    }
}
