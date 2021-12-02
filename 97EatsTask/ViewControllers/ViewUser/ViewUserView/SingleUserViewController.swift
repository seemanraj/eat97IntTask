//
//  SingleUserViewController.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import UIKit
import Kingfisher

class SingleUserViewController: UIViewController {

    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var vuImageVu: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var imgVu: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtMobileNum: UITextField!
    
    var viewModel = ViewUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.performGetUserList(id: viewModel.id)
        getUserDetails()
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onEdit(_ sender: Any) {
    }
    
    @IBAction func onSave(_ sender: Any) {
        
    }
}

extension SingleUserViewController {
    
    func setupUIValue() {
        let curItem = viewModel.userDetResponse
        self.title = curItem?.firstName?.uppercased()
        self.txtTitle.text = curItem?.title
        self.txtDob.text = curItem?.dateOfBirth
        self.txtFirstName.text = curItem?.firstName
        self.txtLastName.text = curItem?.lastName
        self.txtMobileNum.text = curItem?.phone
        self.txtGender.text = curItem?.gender
        let url = URL(string: (curItem?.picture!)!)!
        self.imgVu.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)

        self.txtEmail.text = curItem?.email
        self.imgVu.layer.cornerRadius  = self.imgVu.frame.size.width / 2
        self.vuImageVu.layer.cornerRadius  = self.vuImageVu.frame.size.width / 2
        self.btnImage.layer.cornerRadius  = self.btnImage.frame.size.width / 2
        self.btnImage.layer.borderWidth   = 2.0
        self.btnImage.layer.borderColor = UIColor.green.cgColor

    }
    
    func getUserDetails() {
        self.viewModel.userDetSuccess = {[weak self] response in
            self?.setupUIValue()
        }
    }
}
