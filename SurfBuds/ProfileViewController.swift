//
//  ProfileViewController.swift
//  SurfBuds
//
//  Created by Raymond Lang on 1/31/23.
//

import SwiftUI
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var btnEditPrifle: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lblProfession: UILabel!
    @IBOutlet weak var surfExperienceLabel: UILabel!
    
    @IBOutlet weak var ConstraintSafeArea: NSLayoutConstraint!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = user else { return }
        
        profileImageView.image = user.profileImage
        nameLabel.text = user.name
        ageLabel.text = "\(user.age) years old"
        locationLabel.text = user.location
        surfExperienceLabel.text = user.surfExperience
        
        //UIButton Clicked Events
        
        @IBAction func btnBack_Clicked(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
        
        @IBAction func btnEditProfile_Clicked(_ sender: Any) {
            THelper.btnAnimation(btn: self.btnEditProfile)
            let vc = DatinnEditProfileViewController(nibName: "ProvileViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

