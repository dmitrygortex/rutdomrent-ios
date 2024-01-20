//
//  ViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 14/01/2024.
//

import UIKit
import SnapKit

final class RegisterViewController: UIViewController {

    // MARK: -Properties

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var viewback: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.miitColor
        view.layer.cornerRadius = 12
       
        return view
    }()
    
    private lazy var loginTextField: UITextField = {
        let login = UITextField()
        login.textColor = .black
        login.backgroundColor = .white
        login.layer.cornerRadius = 12
        login.attributedPlaceholder = NSAttributedString(
            string: "Логин",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor]
        )
        login.textAlignment = .center
        login.delegate = self
        login.returnKeyType = .go
        
        return login
    }()
    
    private lazy var FIOTextField: UITextField = {
        let fio = UITextField()
        fio.textColor = .black
        fio.backgroundColor = .white
        fio.layer.cornerRadius = 12
        fio.attributedPlaceholder = NSAttributedString(
            string: "ФИО",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor]
        )
        fio.textAlignment = .center
        fio.delegate = self
        fio.returnKeyType = .go
        
        return fio
    }()
    
    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.textColor = .black
        email.backgroundColor = .white
        email.layer.cornerRadius = 12
        email.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor]
        )
        email.textAlignment = .center
        email.delegate = self
        email.returnKeyType = .go
        email.keyboardType = .emailAddress
        
        return email
    }()
    
    private lazy var instituteTextField: UITextField = {
        let institute = UITextField()
        institute.textColor = .black
        institute.backgroundColor = .white
        institute.layer.cornerRadius = 12
        institute.attributedPlaceholder = NSAttributedString(
            string: "Институт",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor]
        )
        institute.textAlignment = .center
        institute.delegate = self
        institute.returnKeyType = .go
        
        return institute
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.textColor = .black
        password.isSecureTextEntry = true
        password.backgroundColor = .white
        password.layer.cornerRadius = 12
        password.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor]
        )
        password.textAlignment = .center
        password.delegate = self
        password.returnKeyType = .go
        
        return password
    }()
    
    private lazy var phoneTextField: UITextField = {
        let phone = UITextField()
        phone.textColor = .black
        phone.backgroundColor = .white
        phone.layer.cornerRadius = 12
        phone.attributedPlaceholder = NSAttributedString(
            string: "Номер телефона",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor]
        )
        phone.textAlignment = .center
        phone.delegate = self
        phone.returnKeyType = .go
        phone.keyboardType = .phonePad
        
        return phone
    }()
        
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.setTitleColor(AppColors.miitColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Уже есть аккаунт? Войдите", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        return button
    }()

    // MARK: -Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addSubviews()
        setUpConstraints()
    }
    
    private func setUp() {
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewback.addGestureRecognizer(tapGesture)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
        viewback.addSubview(backgroundView)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(registerButton)
        backgroundView.addSubview(loginButton)
        
        [loginTextField, passwordTextField, FIOTextField, instituteTextField, emailTextField, phoneTextField].forEach {
            backgroundView.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        viewback.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(785)
            make.width.equalTo(self.view)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(289)
            make.height.equalTo(700)
            make.top.equalToSuperview().inset(25)
            make.leading.equalToSuperview().inset(37)
            make.trailing.equalTo(-37)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.width.equalTo(165)
            make.height.equalTo(84)
            make.top.equalToSuperview().inset(4)
            make.centerX.equalToSuperview()
        }
        
        loginTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(180)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(260)
        }
        
        FIOTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(340)
        }
        
        instituteTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(420)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(500)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(192)
            make.top.equalToSuperview().inset(580)
            make.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(230)
            make.top.equalToSuperview().inset(650)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func loginButtonPressed() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
