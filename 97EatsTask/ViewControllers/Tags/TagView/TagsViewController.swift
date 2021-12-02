//
//  TagsViewController.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import UIKit

class TagsViewController: UIViewController {
    
    @IBOutlet weak var tblTagList: UITableView!

    var viewModel = TagsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblTagList.delegate = self
        tblTagList.dataSource = self
        self.observer()

        DispatchQueue.main.asyncAfter(deadline: .now() + 50) {
        }
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.performGetTagList()
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

extension TagsViewController {
    func observer() {
        self.viewModel.tagDataSuccess = {[weak self] response in
            print(response.data?.count)
            self?.tblTagList.reloadData()
        }
    }
}

extension TagsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.tagDataResponse?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.viewModel.tagListArr[indexPath.row]
        return cell
    }
    
    
}
