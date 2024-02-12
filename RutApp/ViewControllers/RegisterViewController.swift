//
//  ViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 14/01/2024.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth

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

    private lazy var passwordTextField: CustomTextField = {
        let password = CustomTextField()
        password.textColor = .black
        password.isSecureTextEntry = true
        password.backgroundColor = .white
        password.layer.cornerRadius = 12
        password.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [.foregroundColor: AppColors.placeholderColor])
        password.textAlignment = .center
        password.delegate = self
        password.returnKeyType = .go
        
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eye.setImage(UIImage(systemName: "eye"), for: .selected)
        eye.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
        eye.tintColor = AppColors.hintColor
        eye.frame = CGRect(x: 0, y: 0, width: 45, height: 20)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 20))
        eye.center = view.center
        view.addSubview(eye)
        
        password.rightView = view
        password.rightViewMode = .always
        
        return password
    }()
        
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.setTitleColor(AppColors.miitColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
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
        
        [passwordTextField, FIOTextField, instituteTextField, emailTextField].forEach {
            backgroundView.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        viewback.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(685)
            make.width.equalTo(self.view)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(289)
            make.height.equalTo(580)
            make.top.equalToSuperview().inset(70)
            make.leading.equalToSuperview().inset(37)
            make.trailing.equalTo(-37)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.width.equalTo(165)
            make.height.equalTo(84)
            make.top.equalToSuperview().inset(4)
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
        
        FIOTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(260)
        }
        
        instituteTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(340)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(192)
            make.top.equalToSuperview().inset(440)
            make.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(230)
            make.top.equalToSuperview().inset(510)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func eyeTapped(sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    
    @objc private func loginButtonPressed() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc private func registerButtonTapped() {
        
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let fio = FIOTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let institute = instituteTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !Validate.emailIsValid(email) {
            
            let alert = Validate.showAlert(title: "Неверный email", message: "Введите корректный email")
            present(alert, animated: true)
            return
        }
        
        if !Validate.passwordIsValid(password) {
            
            let alert = Validate.showAlert(title: "Неверный пароль", message: "Пароль должен состоять из не менее 8 символов, цифр, специальных знаков, а также букв в обоих регистрах")
            present(alert, animated: true)
            return
        }
        
        if !Validate.fioIsValid(fio) {
            
            let alert = Validate.showAlert(title: "Неверный ФИО", message: "Введите ваш ФИО через пробел")
            present(alert, animated: true)
            return
        }
        
        if !Validate.instituteIsValid(institute) {
            
            let alert = Validate.showAlert(title: "Неверный институт", message: "Институт должен входить в состав РУТ (МИИТ)")
            present(alert, animated: true)
            return
        }
        
        // MARK: Create user
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let db = Firestore.firestore()
                
                let uid = result!.user.uid
                let userData = ["email": email!, "password": password!, "fio": fio!, "institute": institute!, "uid": uid]
                
                // MARK: Add user to UserDefaults to save data locally
                
                UserModel.email = email!
                UserModel.password = password!
                UserModel.fio = fio!
                UserModel.institute = institute!
                UserModel.uid = uid
                UserModel.synchronize()
                
                // MARK: Add user to Firestore to save data
                
                db.collection("users").document(uid).setData(userData) { error in
                    if let error = error {
                        print("Ошибка записи данных в Firestore: \(error.localizedDescription)")
                    } else {
                        print("Данные успешно записаны в Firestore для пользователя \(uid)")
                        self.navigationController?.pushViewController(TabBarController(), animated: true)
                    }
                }
            }
            
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

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
