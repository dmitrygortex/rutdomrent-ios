//
//  LoginViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: -Properties
    
    let blueColor = UIColor(red: 43 / 255, green: 94 / 255, blue: 189 / 255, alpha: 1)
    let grayColor = UIColor(red: 234 / 255, green: 235 / 255, blue: 248 / 255, alpha: 1)
    let placeholderColor = UIColor(red: 186 / 255, green: 186 / 255, blue: 186 / 255, alpha: 1)
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Мой дом"
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textColor = blueColor
        
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = blueColor
        view.layer.cornerRadius = 8
       
        return view
    }()
    
    private lazy var loginTextField: UITextField = {
        let login = UITextField()
        login.textColor = .black
        login.backgroundColor = grayColor
        login.layer.cornerRadius = 24
        login.attributedPlaceholder = NSAttributedString(
            string: " Логин",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        login.delegate = self
        login.returnKeyType = .go
        
        return login
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.textColor = .black
        password.isSecureTextEntry = true
        password.backgroundColor = grayColor
        password.layer.cornerRadius = 24
        password.attributedPlaceholder = NSAttributedString(
            string: " Пароль",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        password.delegate = self
        password.returnKeyType = .go
        
        return password
    }()
    
    //TODO: Add action to buttons
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.setTitleColor(blueColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    private lazy var makeAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать аккаунт", for: .normal)
        button.backgroundColor = blueColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        
        return button
    }()

    // MARK: -Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(titlelabel)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(loginTextField)
        backgroundView.addSubview(passwordTextField)
        backgroundView.addSubview(loginButton)
        backgroundView.addSubview(makeAccountButton)
    }
    
    private func setUpConstraints() {
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(298)
            make.leading.equalToSuperview().inset(78)
            make.top.equalToSuperview().inset(80)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(289)
            make.height.equalTo(439)
            make.top.equalToSuperview().inset(200)
            make.leading.equalToSuperview().inset(43)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.width.equalTo(165)
            make.height.equalTo(84)
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(65)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(23)
            make.top.equalToSuperview().inset(100)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(23)
            make.top.equalToSuperview().inset(180)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(192)
            make.top.equalToSuperview().inset(290)
            make.leading.equalToSuperview().inset(46)
        }
        
        makeAccountButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(140)
            make.top.equalToSuperview().inset(365)
            make.leading.equalToSuperview().inset(75)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

}
