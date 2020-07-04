//
//  PaisesCollectionViewCell.swift
//  Campeoes
//
//  Created by Petrus Souza on 03/07/20.
//  Copyright © 2020 CESAR School. All rights reserved.
//

import UIKit

class PaisesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ivPais: UIImageView!
    @IBOutlet weak var lbPais: UILabel!
    
    
    func prepare(with pais: Pais) {
        ivPais.image = UIImage(named: pais.nome)
        lbPais.text = pais.nome
        
        ivPais.backgroundColor = .blue
        ivPais.layer.borderColor = UIColor.black.cgColor
        ivPais.layer.borderWidth = 1
        ivPais.layer.cornerRadius = 4
    }
}
