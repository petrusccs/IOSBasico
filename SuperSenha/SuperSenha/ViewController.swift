//
//  ViewController.swift
//  SuperSenha
//
//  Created by Douglas Frari on 01/07/20.
//  Copyright © 2020 CESAR School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tfTotalPasswords: UITextField!
    @IBOutlet weak var tfNumberOfCharacters: UITextField!
    @IBOutlet weak var swLetters: UISwitch!
    @IBOutlet weak var swNumbers: UISwitch!
    @IBOutlet weak var swCaptitalLetters: UISwitch!
    @IBOutlet weak var swSpecialCharacters: UISwitch!
    
    @IBOutlet weak var btnGerarSenhas: UIButton!
    
    private static let VALIDADOR_QTD_SENHAS = (faixa: 1...99, mensagem: "Valores não aceitáveis para a opção Quantidade de senhas: zero ou maior que 99")
    private static let VALIDADOR_QTD_CARACTERES = (faixa: 1...16, mensagem: "Valores não aceitáveis para a opção Total de caracteres: zero ou maior que 16")
    private var camposValidos = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initEventsSwitch()
    }

    private func initEventsSwitch(){
        swLetters.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        swNumbers.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        swCaptitalLetters.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        swSpecialCharacters.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        
    }
    
    @objc func switchChanged(switchAtual: UISwitch) {
        let ALPHA_HABILITADO: Float = 1
        let ALPHA_DESABILITADO: Float = 0.5
        let botaoAtivo = (swLetters.isOn || swNumbers.isOn ||
            swCaptitalLetters.isOn || swSpecialCharacters.isOn)
        btnGerarSenhas.isEnabled = botaoAtivo
        btnGerarSenhas.alpha = CGFloat((botaoAtivo) ? ALPHA_HABILITADO : ALPHA_DESABILITADO)
        
    }
    
    private func exibirMensagem(mensagem: String) {
        let alert = UIAlertController(title: "Alert", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func validarCamposValores(valor: String, validador: (faixa: ClosedRange<Int>, mensagem: String)) -> Bool{
        var campoValido = false
        let valorInteiro = Int(valor) ?? 0
        if case validador.faixa = valorInteiro {
            campoValido = true
        } else {
            exibirMensagem(mensagem: validador.mensagem)
        }
        return campoValido
    }
    
    
    @IBAction func gerarSenhas(_ sender: Any) {
        camposValidos = (validarCamposValores(valor: tfTotalPasswords.text ?? "0", validador: ViewController.VALIDADOR_QTD_SENHAS) &&
        validarCamposValores(valor: tfNumberOfCharacters.text ?? "0", validador: ViewController.VALIDADOR_QTD_CARACTERES))
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "segueGerarSenhas"){
            return camposValidos
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let passwordsViewController = segue.destination as! PasswordViewController
        
        // forma mais segura (usar if let)
        if let numberOfPasswords = Int(tfTotalPasswords.text!) {
            // se conseguir obter o valor do campo e converter para inteiro
            passwordsViewController.numberOfPasswords = numberOfPasswords
        }
        if let numberOfCharacters = Int(tfNumberOfCharacters.text!) {
            passwordsViewController.numberOfCharacters = numberOfCharacters
        }
        passwordsViewController.useNumbers = swNumbers.isOn
        passwordsViewController.useCapitalLetters = swCaptitalLetters.isOn
        passwordsViewController.useLetters = swLetters.isOn
        passwordsViewController.useSpecialCharacters = swSpecialCharacters.isOn
        
        // forcar encerrar o modo de edicao // remove o foco e libera teclado
        view.endEditing(true)
        
    }
    

}

