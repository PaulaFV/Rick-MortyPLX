//
//  ClasePrueba.swift
//  RIckYMortyUIKIt...
//
//  Created by Paula Fernández Vázquez on 23/5/25.
//

import Foundation
import UIKit

class ClasePrueba: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        let testlabel = UILabel()
        testlabel.text = "HOLA"
        testlabel.textAlignment = .center
        testlabel.textColor = .black
        testlabel.font = .systemFont(ofSize: 100, weight: .medium)
        testlabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(testlabel)
        
        NSLayoutConstraint.activate([
            testlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testlabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
