//
//  AccountViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit

class AccountViewController: UIViewController, UITextFieldDelegate {

    // MARK: -Properties
    
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
        label.text = "Настройки профиля"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = AppColors.blueColor
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        let login = UITextField()
        login.textColor = .black
        login.backgroundColor = AppColors.grayColor
        login.layer.cornerRadius = 24
        login.delegate = self
        login.returnKeyType = .go
        
        return login
    }()
    
    private lazy var FIOTextField: UITextField = {
        let fio = UITextField()
        fio.textColor = .black
        fio.backgroundColor = AppColors.grayColor
        fio.layer.cornerRadius = 24
        fio.delegate = self
        fio.returnKeyType = .go
        
        return fio
    }()
    
    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.textColor = .black
        email.backgroundColor = AppColors.grayColor
        email.layer.cornerRadius = 24
        email.delegate = self
        email.returnKeyType = .go
        email.keyboardType = .emailAddress
        
        return email
    }()
    
    private lazy var instituteTextField: UITextField = {
        let institute = UITextField()
        institute.textColor = .black
        institute.backgroundColor = AppColors.grayColor
        institute.layer.cornerRadius = 24
        institute.delegate = self
        institute.returnKeyType = .go
        
        return institute
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.textColor = .black
        password.isSecureTextEntry = true
        password.backgroundColor = AppColors.grayColor
        password.layer.cornerRadius = 24
        password.delegate = self
        password.returnKeyType = .go
        password.allowsEditingTextAttributes = false
        
        return password
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Логин:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var FIOLabel: UILabel = {
        let label = UILabel()
        label.text = "ФИО:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var instituteLabel: UILabel = {
        let label = UILabel()
        label.text = "Институт:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    //TODO: Add action to buttons
    
    private lazy var changeDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить данные", for: .normal)
        button.backgroundColor = AppColors.blueColor
        button.layer.cornerRadius = 24
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
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
        viewback.addSubview(titlelabel)
        viewback.addSubview(changeDataButton)
        
        [loginTextField, passwordTextField, FIOTextField, instituteTextField, emailTextField].forEach {
            viewback.addSubview($0)
        }
        
        [loginLabel, passwordLabel, emailLabel, FIOLabel, instituteLabel].forEach {
            viewback.addSubview($0)
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
            make.height.equalTo(830)
            make.width.equalTo(self.view)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(370)
            make.leading.equalToSuperview().inset(44)
            make.top.equalToSuperview().inset(35)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(240)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(330)
        }
        
        FIOTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(420)
        }
        
        instituteTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(510)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(127)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(217)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(308)
        }
        
        FIOLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(399)
        }
        
        instituteLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(488)
        }
        
        changeDataButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(200)
            make.top.equalToSuperview().inset(600)
            make.centerX.equalToSuperview()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}
