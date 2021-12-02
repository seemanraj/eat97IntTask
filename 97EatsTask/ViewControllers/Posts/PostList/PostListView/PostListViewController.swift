//
//  PostListViewController.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import UIKit
import Kingfisher

class PostListViewController: UIViewController {

    
    @IBOutlet weak var tblPostLIst: UITableView!
    
    var viewModel = PostListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblPostLIst.delegate = self
        tblPostLIst.dataSource = self
        tblPostLIst.register(UINib(nibName: "PostListTableViewCell", bundle: nil), forCellReuseIdentifier: "PostListTableViewCell")
        self.viewModel.performGetPostList(page: 1)
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

extension PostListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.postListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostListTableViewCell") as? PostListTableViewCell else{
            return UITableViewCell()
        }
        let item = self.viewModel.postListArr[indexPath.row]
        let items = item.owner!
        cell.lblUserName.text = "\(items.title?.rawValue ?? "") \(items.firstName ?? "") \(items.lastName ?? "")"
        let userurl = URL(string: (items.picture!))!
        cell.imgUser.kf.setImage(with: userurl, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        let posturl = URL(string: (item.image!))!
        cell.imgPost.kf.setImage(with: posturl, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)

        cell.lblTags.text = item.tags?.joined(separator: ",")
        cell.lblLike.text = "\(item.likes ?? 0) Likes"
        cell.btnComments.tag = indexPath.row
        cell.btnComments.addTarget(self, action: #selector(self.doComment(__:)), for: UIControl.Event.touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension PostListViewController {
    func getObserver() {
        self.viewModel.postListSuccess = {[weak self] response in
            self?.viewModel.pagination = false
            self?.tblPostLIst.reloadData()
        }
    }
    
    func setupNavigation() {
        
        self.title = "Posts"
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

extension PostListViewController {
    @objc func doComment(__ sender : UIButton) {
        let destinationVC = CommentsListPushingCont(nibName: CommentsListPushingCont.nibName, bundle: nil)
        destinationVC.viewModel.id = self.viewModel.postListArr[sender.tag].id ?? ""
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.pagination == false {
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if distanceFromBottom < height {
                if ((self.viewModel.totalCount)) > (self.viewModel.postListResponse?.count)! {
                    self.viewModel.performGetPostList(page: self.viewModel.current + 1)
                }
            }
        }
    }
}
