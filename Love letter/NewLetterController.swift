//
//  NewLetterController.swift
//  Love letter
//
//  Created by KJW on 2022/07/25.
//

import UIKit

class NewLetterController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var letterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapBack = UITapGestureRecognizer.init(target: self, action: #selector(closeLetterView(_:)))
        backView.addGestureRecognizer(tapBack)
        
        let tapLetter = UITapGestureRecognizer.init(target: self, action: #selector(closeLetterView(_:)))
        letterView.addGestureRecognizer(tapLetter)
    }
    
    
    @objc func closeLetterView(_ tap: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
