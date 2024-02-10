//
//  LoginViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit
import FirebaseAuth
import Firebase

final class LoginViewController: UIViewController {
    
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
    
    private lazy var passwordTextField: CustomTextField = {
        let password = CustomTextField()
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
            make.top.equalToSuperview().inset(280)
            make.centerX.equalToSuperview()
        }
        
        makeAccountButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(140)
            make.top.equalToSuperview().inset(355)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func loginButtonPressed() {
        
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
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
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = Validate.showAlert(title: "Ошибка", message: "Неверный email или пароль")
                self?.present(alert, animated: true)
            } else {
                print("Вход успешно выполнен")
                
                let uid = Auth.auth().currentUser?.uid
                
                // MARK: Add user to UserDefaults to save data locally
                
                Firestore.firestore().collection("users").document(uid!).getDocument { document, error in
                    if let document = document, document.exists {
                        let data = document.data()
                        
                        UserModel.email = email!
                        UserModel.password = password!
                        UserModel.fio = data!["fio"]! as! String
                        UserModel.institute = data!["institute"]! as! String
                        UserModel.uid = uid!
                        UserModel.synchronize()
                        
                        let bookings = data!["bookings"] as? [[String: Any]]
                        
                        if let unwrappedBookings = bookings {
                            for array in unwrappedBookings {
                                let model = BookingsModel(date: array["date"] as! String, time: array["time"] as! String, purpose: array["purpose"] as! String, room: array["room"] as! String, uid: uid!)
                                UserModel.bookingsModel = [model]
                                print("Bookings successfully added to UserDefaults: \(model)")
                                print(unwrappedBookings.count)
                            }
                        }
                    }
                    
                    self?.navigationController?.setNavigationBarHidden(true, animated: false)
                    self?.navigationController?.pushViewController(TabBarController(), animated: true)
                }
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
    
    @objc private func eyeTapped(sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
