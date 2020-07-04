//
//  PaisesViewController.swift
//  Campeoes
//
//  Created by Petrus Souza on 03/07/20.
//  Copyright © 2020 CESAR School. All rights reserved.
//

import UIKit

class PaisesViewController: UIViewController {

    private var paises: [Pais] = []
    
    @IBOutlet weak var colecoesPaisesView: UICollectionView!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private static let CELULAS_POR_LINHA = 3
    private static let CELULA_MARGEM_LATERAL = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        carregarPaises()
    }
    
    private func carregarPaises(){
      paises = WorlCupDAO.get().getPaises()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let celulaLargura = (Int(colecoesPaisesView.collectionViewLayout.collectionViewContentSize.width) / PaisesViewController.CELULAS_POR_LINHA) - (PaisesViewController.CELULA_MARGEM_LATERAL)

        layout.itemSize = CGSize(width: celulaLargura, height: celulaLargura)
        layout.minimumInteritemSpacing = CGFloat(PaisesViewController.CELULA_MARGEM_LATERAL)
        layout.minimumLineSpacing = CGFloat(PaisesViewController.CELULA_MARGEM_LATERAL)
        colecoesPaisesView.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ConquistasCopasViewController {
            if let cell = sender as? UICollectionViewCell{
                let indexPath = self.colecoesPaisesView.indexPath(for: cell)
                var pais = paises[indexPath!.row]
                pais.conquistasCopas = WorlCupDAO.get().getConquistasCopas(pais: pais)
                vc.pais = pais
            }
            
        }
    }
}

extension PaisesViewController : UICollectionViewDataSource , UICollectionViewDelegate{
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PaisesCollectionViewCell
        cell.prepare(with: paises[indexPath.row])
        return cell
    }

   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
   }
    
}

