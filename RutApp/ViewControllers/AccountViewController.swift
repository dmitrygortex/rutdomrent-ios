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
        fio.isUserInteractionEnabled = false
        
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
        email.isUserInteractionEnabled = false

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
        institute.isUserInteractionEnabled = false

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
        password.isUserInteractionEnabled = false

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: password.frame.height))
        password.leftView = paddingView
        password.leftViewMode = .always
        
        return password
    }()
    
    private lazy var phoneTextField: UITextField = {
        let phone = UITextField()
        phone.textColor = .black
        phone.backgroundColor = AppColors.grayColor
        phone.layer.cornerRadius = 12
        phone.delegate = self
        phone.returnKeyType = .go
        phone.allowsEditingTextAttributes = false
        phone.keyboardType = .phonePad
        phone.isSecureTextEntry = false
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
        
        setUp()
        addSubviews()
        setUpConstraints()
    }
    
    private func setUp() {
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewback.addGestureRecognizer(tapGesture)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
        viewback.addSubview(titlelabel)
        viewback.addSubview(changeDataButton)
        
        [loginTextField, passwordTextField, FIOTextField, instituteTextField, emailTextField, phoneTextField].forEach {
            viewback.addSubview($0)
        }
        
        [loginLabel, passwordLabel, emailLabel, FIOLabel, instituteLabel, phoneLabel].forEach {
            viewback.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        viewback.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(740)
            make.width.equalTo(self.view)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(340)
            make.leading.equalTo(44)
            make.top.equalToSuperview().inset(4)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(109)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(291)
        }
        
        FIOTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(382)
        }
        
        instituteTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(473)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(563)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(86)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(177)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(268)
        }
        
        FIOLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(359)
        }
        
        instituteLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(450)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(540)
        }
        
        changeDataButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(215)
            make.top.equalToSuperview().inset(631)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func changeDataButtonTapped() {
        [loginTextField, passwordTextField, FIOTextField, instituteTextField, emailTextField, phoneTextField].forEach {
            $0.isUserInteractionEnabled = true
        }
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

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
