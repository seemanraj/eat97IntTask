//
//  InitialViewController.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onUsers(_ sender: Any) {
        let destinationVC = UserListPushingCont(nibName: UserListPushingCont.nibName, bundle: nil)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func onPosts(_ sender: Any) {
        
        let destinationVC = PostListPushingCont(nibName: PostListPushingCont.nibName, bundle: nil)
        self.navigationController?.pushViewController(destinationVC, animated: true)

    }
    
    @IBAction func onTags(_ sender: Any) {
        let destinationVC = TagListPushingControllers(nibName: TagListPushingControllers.nibName, bundle: nil)
        self.navigationController?.pushViewController(destinationVC, animated: true)
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
