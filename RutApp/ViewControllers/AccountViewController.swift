//
//  AccountViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit
import FirebaseAuth
import Firebase

class AccountViewController: UIViewController {

    // MARK: -Properties
    
    private var emailText = ""
    
    private var passwordText = ""
    
    private var fioText = ""
    
    private var instituteText = ""
    
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
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
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
    
    private lazy var fioLabel: UILabel = {
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
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти из аккаунта", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var deleteAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить аккаунт", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
        
        return button
    }()

    // MARK: -Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addSubviews()
        setUpConstraints()
        setData()
    }
    
    private func setUp() {
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setData() {
        let uid = Auth.auth().currentUser?.uid
        
        Firestore.firestore().collection("users").document(uid!).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                print("Данные пользователя: \(data ?? [:])")
                
                self.emailText = (data?["email"]! as? String)!
                self.passwordText = (data?["password"]! as? String)!
                self.fioText = (data?["fio"]! as? String)!
                self.instituteText = (data?["institute"]! as? String)!
                
                self.emailTextField.text = self.emailText
                self.passwordTextField.text = self.passwordText
                self.FIOTextField.text = self.fioText
                self.instituteTextField.text = self.instituteText
                
            } else {
                print("Документ пользователя не найден")
            }
        }

    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
        
        [changeDataButton, signOutButton, deleteAccountButton].forEach { viewback.addSubview($0) }
        
        [passwordTextField, FIOTextField, instituteTextField, emailTextField].forEach { viewback.addSubview($0) }
        
        [titlelabel, passwordLabel, emailLabel, fioLabel, instituteLabel].forEach { viewback.addSubview($0) }
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
        
        emailTextField.snp.makeConstraints { make in
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
        
        FIOTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(291)
        }
        
        instituteTextField.snp.makeConstraints { make in
            make.width.equalTo(247)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(382)
        }
        
        emailLabel.snp.makeConstraints { make in
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
        
        fioLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(268)
        }
        
        instituteLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(359)
        }
        
        changeDataButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(215)
            make.top.equalToSuperview().inset(460)
            make.centerX.equalToSuperview()
        }
        
        signOutButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(215)
            make.top.equalToSuperview().inset(533)
            make.centerX.equalToSuperview()
        }
        
        deleteAccountButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(215)
            make.top.equalToSuperview().inset(606)
            make.centerX.equalToSuperview()
        }
    }
    
    private func signInUser() {
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                print("Sign In doesn't successful")
            }
        }
    }
    
    @objc private func changeDataButtonTapped() {
        [passwordTextField, FIOTextField, instituteTextField, emailTextField].forEach {
            $0.isUserInteractionEnabled = true
        }
    }
    
    @objc private func signOutButtonTapped() {
        let firebaseAuth = Auth.auth()
        
        do {
          try firebaseAuth.signOut()
            print("Пользователь успешно вышел из аккаунта")
            [passwordTextField, FIOTextField, instituteTextField, emailTextField].forEach { $0.text = "" }
//            let alert = Validate.showAlert(title: "Готово", message: "Вы успешно вышли из аккаунта")
//            present(alert, animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    @objc private func deleteAccountButtonTapped() {
        signInUser()
        
        let user = Auth.auth().currentUser
        
        Firestore.firestore().collection("users").document(user!.uid).delete { error in
            if error != nil {
                print(error!.localizedDescription)
                print("Account in Firestore doesn't deleted.")
                
            } else {
                print("Account in Firestore successfully deleted.")
            }
        }
        
        user?.delete { error in
          if let error = error {
              print(error.localizedDescription)
              print("User account doesn't deleted.")
          } else {
            print("User Account successfully deleted.")
              [self.passwordTextField, self.FIOTextField, self.instituteTextField, self.emailTextField].forEach { $0.text = "" }
              let alert = Validate.showAlert(title: "Готово", message: "Вы успешно удалили аккаунт")
              self.present(alert, animated: true)
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
    
}

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if emailTextField.text != emailText || passwordTextField.text != passwordText || FIOTextField.text != fioText || instituteTextField.text != instituteText {
            
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let fio = FIOTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let institute = instituteTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if !Validate.emailIsValid(email) {
                
                let alert = Validate.showAlert(title: "Неверный email", message: "Введите корректный email")
                present(alert, animated: true)
                return true
            }
            
            if !Validate.passwordIsValid(password) {
                
                let alert = Validate.showAlert(title: "Неверный пароль", message: "Пароль должен состоять из не менее 8 символов, цифр, специальных знаков, а также букв в обоих регистрах")
                present(alert, animated: true)
                return true
            }
            
            if !Validate.fioIsValid(fio) {
                
                let alert = Validate.showAlert(title: "Неверный ФИО", message: "Введите ваш ФИО через пробел")
                present(alert, animated: true)
                return true
            }
            
            if !Validate.instituteIsValid(institute) {
                
                let alert = Validate.showAlert(title: "Неверный институт", message: "Институт должен входить в состав РУТ (МИИТ)")
                present(alert, animated: true)
                return true
            }
            
            let newEmail = emailTextField.text!
            let newPassword = passwordTextField.text!
            let newFIO = FIOTextField.text!
            let newInstitute = instituteTextField.text!
            
            let uid = Auth.auth().currentUser?.uid
            
            let updatedData = ["email": newEmail, "password": newPassword, "fio": newFIO, "institute": newInstitute, "uid": uid!]
            
            if uid != nil {
                if emailTextField.text != emailText {
                    
                    // MARK: Update email
                    
                    Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
                        if let error = error {
                            print("User email doesn't update.")
                            print(error.localizedDescription)
                        } else {
                            print("User email updated successfully.")
                        }
                    }
                }
                
                // MARK: Update password
                
                if passwordTextField.text != passwordText {
                    Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
                        if let error = error {
                            print("User password doesn't update.")
                            print(error.localizedDescription)
                        } else {
                            print("User password updated successfully.")
                        }
                    }
                }
                
                emailText = newEmail
                passwordText = newPassword
                fioText = newFIO
                instituteText = newInstitute
                
                let userDocument = Firestore.firestore().collection("users").document(uid!)
                
                // MARK: Update user data
                
                userDocument.updateData(updatedData) { error in
                    if let error = error {
                        print("Ошибка обновления дных пользователя: \(error.localizedDescription)")
                    } else {
                        print("Данные пользователя успешно обновлены")
                        let alert = Validate.showAlert(title: "Готово", message: "Ваши данные успешно обновлены")
                        self.present(alert, animated: true)
                    }
                }
            }
        }
        return true
    }
}
