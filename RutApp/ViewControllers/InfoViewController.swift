//
//  InfoViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    //MARK: -Properties
    
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
        label.text = "Информация"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = AppColors.blueColor
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Общая информация:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.text = "График работы Дома:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var infoText: UILabel = {
        let label = UILabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "Мой Дом - это приложение для резервирования специальных помещений Дома молодёжи РУТ МИИТ под мероприятия.\n\nНужно провести конференцию? Организовать митап? Сделать профессиональные фотографии? Дом моложёжи РУТ МИИТ - это Ваш вариант!"
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    private lazy var scheduleText: UILabel = {
        let label = UILabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "По будням с 10:00 до 20:00"
        
        return label
    }()
    
    private lazy var adressText: UILabel = {
        let label = UILabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "ул. Образцова, 21"
        
        return label
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
        [titlelabel, infoLabel, scheduleLabel, adressLabel].forEach {
            viewback.addSubview($0)
        }
        
        [infoText, scheduleText, adressText].forEach {
            viewback.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
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
    }

}
