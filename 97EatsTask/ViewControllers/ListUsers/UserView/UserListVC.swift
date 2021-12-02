//
//  UserListVC.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import UIKit
import Kingfisher

class UserListVC: UIViewController {

    @IBOutlet weak var tblUserLIst: UITableView!
    
    var viewModel = UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblUserLIst.delegate = self
        tblUserLIst.dataSource = self
        tblUserLIst.register(UINib(nibName: "UserListTVCTableViewCell", bundle: nil), forCellReuseIdentifier: "UserListTVCTableViewCell")
        self.viewModel.performGetUserList(page: 1)
        self.getObserver()
        self.setupNavigation()
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

}

extension UserListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.userListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTVCTableViewCell") as? UserListTVCTableViewCell else{
            return UITableViewCell()
        }
        let items = self.viewModel.userListArr[indexPath.row]
        cell.lbluserName.text = "\(items.title ?? "") \(items.firstName ?? "") \(items.lastName ?? "")"
        let url = URL(string: items.picture!)!
        cell.imgUser.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.btnPre.tag = indexPath.row
        cell.btnPre.addTarget(self, action: #selector(self.doPreview(__:)), for: UIControl.Event.touchUpInside)
        cell.btnDel.tag = indexPath.row
        cell.btnDel.addTarget(self, action: #selector(self.doDelete(__:)), for: UIControl.Event.touchUpInside)
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(self.doEdit(__:)), for: UIControl.Event.touchUpInside)

        return cell
    }
}

extension UserListVC {
    
    @objc func doPreview(__ sender : UIButton) {
        let destinationVC = UserListPushingControllers(nibName: UserListPushingControllers.nibName, bundle: nil)
        destinationVC.viewModel.id = self.viewModel.userListArr[sender.tag].id ?? ""
        destinationVC.viewModel.isFromEdit = false
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func doDelete(__ sender : UIButton) {
        let deleteAlert = UIAlertController(title: LSString(.AppName), message: LSString(.DeleteUser), preferredStyle: UIAlertController.Style.alert)
        
        deleteAlert.addAction(UIAlertAction(title: LSString(.Delete), style: .default, handler: { (action: UIAlertAction!) in
            self.viewModel.performDeleteUser(Id: self.viewModel.userListArr[sender.tag].id ?? "")
        }))
        
        deleteAlert.addAction(UIAlertAction(title: LSString(.cancel), style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(deleteAlert, animated: true, completion: nil)

    }
    
    @objc func doEdit(__ sender : UIButton) {
        let destinationVC = UserListPushingControllers(nibName: UserListPushingControllers.nibName, bundle: nil)
        destinationVC.viewModel.id = self.viewModel.userListArr[sender.tag].id ?? ""
        destinationVC.viewModel.isFromEdit = true
        self.navigationController?.pushViewController(destinationVC, animated: true)

    }
}

extension UserListVC {
    
    func getObserver() {
        self.viewModel.userListSuccess = {[weak self] response in
            self?.viewModel.pagination = false
            self?.tblUserLIst.reloadData()
        }
    }
    
    func setupNavigation() {
        
        self.title = "Users"
        let btnCancel = UIButton()
        btnCancel.setImage(UIImage(named: "back_white"), for: .normal)
        btnCancel.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        btnCancel.addTarget(self, action: #selector(self.backItem), for: .touchUpInside)
        
        //Set Left Bar Button item
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnCancel
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func backItem() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserListVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.pagination == false {
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if distanceFromBottom < height {
                if ((self.viewModel.totalCount)) > (self.viewModel.userListResponse?.count)! {
                    self.viewModel.performGetUserList(page: self.viewModel.current + 1)
                }
            }
        }
    }
}
