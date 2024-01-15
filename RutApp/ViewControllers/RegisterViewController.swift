//
//  ViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 14/01/2024.
//

import UIKit
import SnapKit

final class RegisterViewController: UIViewController, UITextFieldDelegate {

    // MARK: -Properties
    
    let blueColor = UIColor(red: 43 / 255, green: 94 / 255, blue: 189 / 255, alpha: 1)
    let grayColor = UIColor(red: 234 / 255, green: 235 / 255, blue: 248 / 255, alpha: 1)
    let placeholderColor = UIColor(red: 186 / 255, green: 186 / 255, blue: 186 / 255, alpha: 1)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var viewback: UIView = {
        let view = UIView()
        
        return view
    }()
    
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
    
    private lazy var FIOTextField: UITextField = {
        let fio = UITextField()
        fio.textColor = .black
        fio.backgroundColor = grayColor
        fio.layer.cornerRadius = 24
        fio.attributedPlaceholder = NSAttributedString(
            string: " ФИО",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        fio.delegate = self
        fio.returnKeyType = .go
        
        return fio
    }()
    
    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.textColor = .black
        email.backgroundColor = grayColor
        email.layer.cornerRadius = 24
        email.attributedPlaceholder = NSAttributedString(
            string: " Email",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        email.delegate = self
        email.returnKeyType = .go
        email.keyboardType = .emailAddress
        
        return email
    }()
    
    private lazy var instituteTextField: UITextField = {
        let institute = UITextField()
        institute.textColor = .black
        institute.backgroundColor = grayColor
        institute.layer.cornerRadius = 24
        institute.attributedPlaceholder = NSAttributedString(
            string: " Институт",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        institute.delegate = self
        institute.returnKeyType = .go
        
        return institute
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
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.setTitleColor(blueColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Уже есть аккаунт? Войдите", for: .normal)
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
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
        viewback.addSubview(backgroundView)
        viewback.addSubview(titlelabel)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(registerButton)
        backgroundView.addSubview(loginButton)
        
        [loginTextField, passwordTextField, FIOTextField, instituteTextField, emailTextField].forEach {
            backgroundView.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        viewback.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(950)
            make.width.equalTo(self.view)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(298)
            make.leading.equalToSuperview().inset(78)
            make.top.equalToSuperview().inset(45)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(289)
            make.height.equalTo(620)
            make.top.equalToSuperview().inset(160)
            make.leading.equalToSuperview().inset(37)
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
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(23)
            make.top.equalToSuperview().inset(260)
        }
        
        FIOTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(23)
            make.top.equalToSuperview().inset(340)
        }
        
        instituteTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(23)
            make.top.equalToSuperview().inset(420)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(192)
            make.top.equalToSuperview().inset(500)
            make.leading.equalToSuperview().inset(46)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(230)
            make.top.equalToSuperview().inset(575)
            make.leading.equalToSuperview().inset(38)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

}

