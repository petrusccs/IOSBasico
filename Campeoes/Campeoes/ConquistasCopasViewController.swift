//
//  ConquistasCopasViewController.swift
//  Campeoes
//
//  Created by Petrus Souza on 04/07/20.
//  Copyright © 2020 CESAR School. All rights reserved.
//

import UIKit

class ConquistasCopasViewController: UIViewController {

    var pais: Pais!
    
    @IBOutlet weak var ivPais: UIImageView!
    @IBOutlet weak var lbPais: UILabel!
    
    @IBOutlet weak var lbQtdCopas: UILabel!
    
    @IBOutlet weak var lbConquistas: UILabel!
    
    @IBOutlet weak var tvConquistasCopas: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preencheComponentes()
    }
    
    private func preencheComponentes(){
        ivPais.image = UIImage(named: pais.nome)
        lbPais.text = pais.nome
        lbQtdCopas.text = "Copas do mundo conquistadas: \(pais.conquistasCopas.count)"
        
        if(pais.conquistasCopas.count > 0){
            let arrayConquistas = pais.conquistasCopas.map { "- \($0.local), \($0.ano) (\($0.placar))" }
            let stringConquistas = arrayConquistas.joined(separator: "\r\n")
           
            lbConquistas.isHidden = false
            
            tvConquistasCopas.text = "\(stringConquistas)"
        }else{
            lbConquistas.isHidden = true
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

