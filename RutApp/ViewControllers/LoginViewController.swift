//
//  LoginViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: -Properties
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Мой дом"
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textColor = AppColors.miitColor
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.miitColor
        view.layer.cornerRadius = 12
       
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.textColor = .black
        email.backgroundColor = .white
        email.textAlignment = .center
        email.layer.cornerRadius = 12
        email.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor]
        )
        email.delegate = self
        email.returnKeyType = .go
        email.keyboardType = .emailAddress
        
        return email
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.textColor = .black
        password.textAlignment = .center
        password.isSecureTextEntry = true
        password.backgroundColor = .white
        password.layer.cornerRadius = 12
        password.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor]
        )
        password.delegate = self
        password.returnKeyType = .go
        
        return password
    }()
        
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.setTitleColor(AppColors.miitColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var makeAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать аккаунт", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(makeAccountButtonPressed), for: .touchUpInside)
        
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(titlelabel)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(emailTextField)
        backgroundView.addSubview(passwordTextField)
        backgroundView.addSubview(loginButton)
        backgroundView.addSubview(makeAccountButton)
    }
    
    private func setUpConstraints() {
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(298)
            make.centerX.equalToSuperview()
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
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
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
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(192)
            make.top.equalToSuperview().inset(290)
            make.centerX.equalToSuperview()
        }
        
        makeAccountButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(140)
            make.top.equalToSuperview().inset(365)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func loginButtonPressed() {
                
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !Validate.emailIsValid(email) {
            let alert = Validate.showError(title: "Неверный email", message: "Введите корректный email")
            present(alert, animated: true)
            return
        }
        
        if !Validate.passwordIsValid(password) {
            let alert = Validate.showError(title: "Неверный пароль", message: "Пароль должен быть не короче 8 символов, а также содержать хотя бы 1 цифру и 1 специальный знак")
            present(alert, animated: true)
            return
        }
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Вход успешно выполнен")
                self?.navigationController?.setNavigationBarHidden(true, animated: false)
                self?.navigationController?.pushViewController(TabBarController(), animated: true)
            }
        }
    }
    
    @objc private func makeAccountButtonPressed() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
