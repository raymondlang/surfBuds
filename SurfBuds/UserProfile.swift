//
//  UserProfile.swift
//  SurfBuds
//
//  Created by Raymond Lang on 1/23/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var surfExperienceLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = user else { return }
        
        profileImageView.image = user.profileImage
        nameLabel.text = user.name
        ageLabel.text = "\(user.age) years old"
        locationLabel.text = user.location
        surfExperienceLabel.text = user.surfExperience
    }
}
