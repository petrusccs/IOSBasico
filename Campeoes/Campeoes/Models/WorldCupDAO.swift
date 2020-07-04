//
//  WorldCupDAO.swift
//  Campeoes
//
//  Created by Petrus Souza on 04/07/20.
//  Copyright © 2020 CESAR School. All rights reserved.
//

import Foundation

class WorlCupDAO{
    
    private static var instancia: WorlCupDAO? = nil
    
    private var worldCups: [WorldCup] = []
    
    static func get() -> WorlCupDAO{
        if(instancia == nil){
            instancia = WorlCupDAO();
        }
        return instancia!
    }
    
    func getWorldCups() -> [WorldCup] {
        let fileURL = Bundle.main.url(forResource: "winners", withExtension: ".json")!
        let jsonData = try! Data(contentsOf: fileURL)
        
        do {
            worldCups = try JSONDecoder().decode([WorldCup].self, from: jsonData)
        } catch  {
            print(error.localizedDescription)
        }
        return worldCups
    }
    
    //Traz todos países não só os países campeões e vice
    func getPaises() -> [Pais] {
        var paises: [Pais] = []
        if(worldCups.count == 0){
            worldCups = getWorldCups()
        }
        for worldCup in worldCups{
            /* Verifica apenas o match 0 para otimizar a pesquisa,
            já que todos passaram tem passar pela fase 1 */
            if(worldCup.matches.count > 0){
                for game in worldCup.matches[0].games{
                    let paisHome = Pais(nome: game.home)
                    let paisAway = Pais(nome: game.away)
                    let existePaisHome = paises.contains { (value) -> Bool in
                        value.nome as String == paisHome.nome
                    }
                    if(!existePaisHome){
                        paises.append(paisHome)
                    }
                    let existePaisAway = paises.contains { (value) -> Bool in
                        value.nome as String == paisAway.nome
                    }
                    if(!existePaisAway){
                        paises.append(paisAway)
                    }
                    
                    paises.sort {
                        $0.nome < $1.nome
                    }
                    
                }
            }
        }
        return paises
    }
    
    func getConquistasCopas(pais: Pais) -> [ConquistaCopa] {
        var conquistasCopas: [ConquistaCopa] = []
        if(worldCups.count == 0){
            worldCups = getWorldCups()
        }
        for worldCup in worldCups{
            if(worldCup.matches.count > 0){
                if(worldCup.winner == pais.nome){
                    let placar = "\(worldCup.winner) \(worldCup.winnerScore) x \(worldCup.viceScore) \(worldCup.vice)"
                    let consquista = ConquistaCopa(ano: worldCup.year, local: worldCup.country, placar: placar)
                    conquistasCopas.append(consquista)
                }
                conquistasCopas.sort {
                    $0.ano < $1.ano
                }
            }
        }
        return conquistasCopas
    }
}
