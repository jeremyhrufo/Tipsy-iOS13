//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Jeremy Rufo on 7/24/20.
//

import UIKit

class ResultsViewController: UIViewController
{
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var tipObject: TipObject?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        totalLabel.text = tipObject?.totalText
        settingsLabel.text = tipObject?.splitText
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
