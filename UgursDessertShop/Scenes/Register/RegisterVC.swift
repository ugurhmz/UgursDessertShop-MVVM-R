//
//  RegisterVC.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 5.07.2022.
//

import UIKit

class RegisterVC: BaseViewController<RegisterViewModel>{
    
    private let shapeTopImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"registershape4")
        iv.tintColor = .white
        iv.layer.zPosition = -1
        iv.alpha = 0.5
        return iv
    }()
    
    private let shapeBottomImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"registershapetop")
        iv.tintColor = .white
        iv.layer.zPosition = -1
        iv.alpha = 0.5
        return iv
    }()
    
    private let registerTxtLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 55, weight: .bold)
        label.text = "Register"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.7163005471, green: 0.6066218019, blue: 0.9284923673, alpha: 1)
        return label
    }()
    
    private let txtUsername: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.placeholder = "Username"
        txt.layer.borderWidth = 0.4
        return txt
    }()
    
    private let txtfullName: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.placeholder = "Full Name"
        txt.layer.borderWidth = 0.4
        return txt
    }()
    
    
    private let txtEmail: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.keyboardType = .emailAddress
        txt.placeholder = "Email address"
        txt.layer.borderWidth = 0.5
        return txt
    }()
    
    private let txtPassword: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.isSecureTextEntry = true
        txt.placeholder = "Password"
        txt.layer.borderWidth =  0.4
        txt.addTarget(self, action: #selector(pwTextDidChange(_:)), for: .editingChanged)
        return txt
    }()
    
    
    private let txtRePassword: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.isSecureTextEntry = true
        txt.placeholder = "Re password"
        txt.layer.borderWidth = 0.4
        txt.addTarget(self, action: #selector(pwTextDidChange(_:)), for: .editingChanged)
        return txt
    }()
    
    // Password did change
    @objc func pwTextDidChange(_ textField: UITextField){
        
        guard let passTxt = txtPassword.text else { return }
        
        // typing then check when remove in field
        if textField == txtRePassword {
            checkPaswoordFieldImg.isHidden = false
            checkRePasswordImg.isHidden = false
        } else {
            if passTxt.isEmpty {
                checkPaswoordFieldImg.isHidden = true
                checkRePasswordImg.isHidden = true
                txtRePassword.text = ""
            }
        }
        
        // matching
        if txtPassword.text == txtRePassword.text {
            checkPaswoordFieldImg.tintColor = UIColor(red: 16/255, green: 129/255, blue: 49/255, alpha: 1)
            checkRePasswordImg.tintColor = UIColor(red: 16/255, green: 129/255, blue: 49/255, alpha: 1)
        } else {
            checkPaswoordFieldImg.tintColor = .red
            checkRePasswordImg.tintColor = .red
        }
    }
    
    private let registerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = #colorLiteral(red: 0.1703644097, green: 0.5562083125, blue: 0.2419883311, alpha: 0.7098768627).withAlphaComponent(0.6)
        btn.layer.borderWidth = 0.4
       btn.layer.borderColor = #colorLiteral(red: 0.2862745098, green: 0.6274509804, blue: 0.6392156863, alpha: 0.9085264901).cgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        btn.addTarget(self, action: #selector(clickRegisterBtn), for: .touchUpInside)
        return btn
    }()
    
    private let checkPaswoordFieldImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .red
        return iv
    }()
    
    private let checkRePasswordImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .red
        return iv
    }()
    
       @objc func clickRegisterBtn(){
           guard let email = txtEmail.text, !email.isEmpty,
                 let username = txtUsername.text, !username.isEmpty,
                 let password = txtPassword.text, !password.isEmpty,
                 let rePass = txtRePassword.text, !rePass.isEmpty,
                    let fullName = txtfullName.text, !fullName.isEmpty
                    
           else {

                     self.createAlert(title: "",
                                      msg: "Fields can't be empty!",
                                      prefStyle: .alert,
                                      bgColor: .white,
                                      textColor: .black,
                                      fontSize: 25)
                     return
                 }

           guard let rePassword = txtRePassword.text, rePassword == password else {
               self.createAlert(title: "Error",
                                msg: "Passwords do not match !",
                                prefStyle: .alert,
                                bgColor: .white,
                                textColor: .black,
                                fontSize: 25)
               return
           }
           
           viewModel.sendRegisterRequest(username: username, email: email, password: rePassword, name: fullName)
       }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerTxtLabel,txtUsername,txtEmail,txtfullName, txtPassword,txtRePassword, registerBtn ])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

//MARK: -
extension RegisterVC {
    private func setupViews(){
        view.addSubview(stackView)
        view.addSubview(shapeBottomImgView)
        view.addSubview(checkPaswoordFieldImg)
        view.addSubview(checkRePasswordImg)
        view.addSubview(shapeTopImgView)
      
        checkPaswoordFieldImg.isHidden = true
        checkRePasswordImg.isHidden = true
        
        view.backgroundColor = .white
        registerTxtLabel.underline()
        setupShadows()
        
        stackView.setCustomSpacing(42, after: registerTxtLabel)
    }
    
    private func setupShadows(){
       // view.bringSubviewToFront(shapeImageView)
        view.bringSubviewToFront(stackView)
        view.bringSubviewToFront(checkPaswoordFieldImg)
        view.bringSubviewToFront(checkRePasswordImg)
        
        
        
        txtEmail.layer.shadowOpacity = 2
        txtEmail.layer.shadowRadius = 2
        txtEmail.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.9193656871).cgColor


        txtPassword.layer.shadowOpacity = 2
        txtPassword.layer.shadowRadius = 2
        txtPassword.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.9193656871).cgColor
        
        txtRePassword.layer.shadowOpacity = 2
        txtRePassword.layer.shadowRadius = 2
        txtRePassword.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.9193656871).cgColor

        txtUsername.layer.shadowOpacity = 2
        txtUsername.layer.shadowRadius = 2
        txtUsername.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.9193656871).cgColor

        registerBtn.layer.shadowOpacity = 2
        registerBtn.layer.shadowRadius = 2
        registerBtn.layer.shadowColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.8711454884).cgColor
    }
    
    
    private func setConstraints(){
        
        stackView.anchor(top: nil,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 30, bottom: 0, right: 30))
        stackView.centerYInSuperview()
        
        shapeBottomImgView.anchor(top: nil,
                             leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 0, left: 20, bottom: 35, right: 20)
        )
        
        shapeTopImgView.anchor(top: view.topAnchor,
                               leading: nil,
                                bottom: nil,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 45, left: 0, bottom: 0, right: 2),
                               size: .init(width: 320, height: 260)
          )
        
        
        checkPaswoordFieldImg.anchor(top: txtPassword.topAnchor,
                             leading: nil,
                             bottom: nil,
                             trailing: txtPassword.trailingAnchor,
                             padding: .init(top: 5, left: 0, bottom: 0, right: 10),
                             size: .init(width: 40, height: 40))
        
        checkRePasswordImg.anchor(top: txtRePassword.topAnchor,
                             leading: nil,
                             bottom: nil,
                             trailing: txtRePassword.trailingAnchor,
                             padding: .init(top: 5, left: 0, bottom: 0, right: 10),
                             size: .init(width: 40, height: 40))
        
    }
}
