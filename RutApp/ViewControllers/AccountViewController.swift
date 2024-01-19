//
//  AccountViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit

class AccountViewController: UIViewController {

    // MARK: -Properties
      
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки профиля"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = AppColors.miitColor
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        let login = UITextField()
        login.textColor = .black
        login.backgroundColor = AppColors.grayColor
        login.layer.cornerRadius = 12
        login.delegate = self
        login.returnKeyType = .go
        login.isUserInteractionEnabled = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: login.frame.height))
        login.leftView = paddingView
        login.leftViewMode = .always
        
        return login
    }()
    
    private lazy var FIOTextField: UITextField = {
        let fio = UITextField()
        fio.textColor = .black
        fio.backgroundColor = AppColors.grayColor
        fio.layer.cornerRadius = 12
        fio.delegate = self
        fio.returnKeyType = .go
        login.isUserInteractionEnabled = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: fio.frame.height))
        fio.leftView = paddingView
        fio.leftViewMode = .always
        
        return fio
    }()
    
    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.textColor = .black
        email.backgroundColor = AppColors.grayColor
        email.layer.cornerRadius = 12
        email.delegate = self
        email.returnKeyType = .go
        email.keyboardType = .emailAddress
        login.isUserInteractionEnabled = false

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: email.frame.height))
        email.leftView = paddingView
        email.leftViewMode = .always
        
        return email
    }()
    
    private lazy var instituteTextField: UITextField = {
        let institute = UITextField()
        institute.textColor = .black
        institute.backgroundColor = AppColors.grayColor
        institute.layer.cornerRadius = 12
        institute.delegate = self
        institute.returnKeyType = .go
        login.isUserInteractionEnabled = false

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: institute.frame.height))
        institute.leftView = paddingView
        institute.leftViewMode = .always
        
        return institute
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.textColor = .black
        password.isSecureTextEntry = true
        password.backgroundColor = AppColors.grayColor
        password.layer.cornerRadius = 12
        password.delegate = self
        password.returnKeyType = .go
        password.allowsEditingTextAttributes = false
        login.isUserInteractionEnabled = false

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: password.frame.height))
        password.leftView = paddingView
        password.leftViewMode = .always
        
        return password
    }()
    
    private lazy var phoneTextField: UITextField = {
        let phone = UITextField()
        phone.textColor = .black
        phone.isSecureTextEntry = true
        phone.backgroundColor = AppColors.grayColor
        phone.layer.cornerRadius = 12
        phone.delegate = self
        phone.returnKeyType = .go
        phone.allowsEditingTextAttributes = false
        phone.keyboardType = .phonePad
        phone.isHidden = false
        phone.isUserInteractionEnabled = false

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: phone.frame.height))
        phone.leftView = paddingView
        phone.leftViewMode = .always
        
        return phone
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
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    //TODO: Add action to buttons
    
    private lazy var changeDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить данные", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(changeDataButtonTapped), for: .touchUpInside)
        
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
        view.addSubview(titlelabel)
        view.addSubview(changeDataButton)
        
        [loginTextField, passwordTextField, FIOTextField, instituteTextField, emailTextField, phoneTextField].forEach {
            view.addSubview($0)
        }
        
        [loginLabel, passwordLabel, emailLabel, FIOLabel, instituteLabel, phoneLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(340)
            make.leading.equalTo(44)
            make.top.equalToSuperview().inset(35)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(115) 
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(206)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(297)
        }
        
        FIOTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(388)
        }
        
        instituteTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(479)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(569)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(92)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(183)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(274)
        }
        
        FIOLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(365)
        }
        
        instituteLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(456)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(546)
        }
        
        changeDataButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(215)
            make.top.equalToSuperview().inset(652)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func changeDataButtonTapped() {
        [loginTextField, passwordTextField, FIOTextField, instituteTextField, emailTextField, phoneTextField].forEach {
            $0.isUserInteractionEnabled = true
        }
    }
    
}

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
