//
//  CommentsListViewController.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import UIKit
import Kingfisher

class CommentsListViewController: UIViewController {

    @IBOutlet weak var tblCommentsList: UITableView!
    @IBOutlet weak var txtComments: UITextView!
    @IBOutlet weak var btnComments: UIButton!
    
    var viewModel = CommentListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblCommentsList.delegate = self
        tblCommentsList.dataSource = self
        self.viewModel.performGetcommentList(id: viewModel.id)
        tblCommentsList.register(UINib(nibName: "CommentsListTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsListTableViewCell")
        self.getObserver()
        self.setupNavigation()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSaveComments(_ sender: Any) {
        self.viewModel.performGetcommentList(id: viewModel.id)
        self.getObserver()
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

extension CommentsListViewController {
    func getObserver() {
        self.viewModel.commentListSuccess = {[weak self] response in
            self?.viewModel.pagination = false
            self?.tblCommentsList.reloadData()
        }
        self.viewModel.commentDelSuccess = {[weak self] response in
            self?.tblCommentsList.reloadData()
        }
    }
    
    func setupNavigation() {
        
        self.title = "Comments"
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
    
    @objc func doDelete(__ sender : UIButton) {
        let deleteAlert = UIAlertController(title: LSString(.AppName), message: LSString(.DeleteUser), preferredStyle: UIAlertController.Style.alert)
        deleteAlert.addAction(UIAlertAction(title: LSString(.Delete), style: .default, handler: { (action: UIAlertAction!) in
            self.viewModel.performDelcommentList(id: self.viewModel.commentsListArr[sender.tag].id ?? "")
        }))
        deleteAlert.addAction(UIAlertAction(title: LSString(.cancel), style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(deleteAlert, animated: true, completion: nil)
    }
}

extension CommentsListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.commentsListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsListTableViewCell") as? CommentsListTableViewCell else{
            return UITableViewCell()
        }
        let item = self.viewModel.commentsListArr[indexPath.row]
        let items = item.owner!
        cell.lblUserName.text = "\(items.title?.rawValue ?? "") \(items.firstName ?? "") \(items.lastName ?? "")"
        let posturl = URL(string: (items.picture!) )!
        cell.userImage.kf.setImage(with: posturl, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.lblComments.text = item.message
        cell.lblDate.text = utcToLocal(dateStr: item.publishDate!)
        cell.btnDel.tag = indexPath.row
        cell.btnDel.addTarget(self, action: #selector(self.doDelete(__:)), for: UIControl.Event.touchUpInside)
        return cell
    }
    
    
}

extension CommentsListViewController {
    
    
}
