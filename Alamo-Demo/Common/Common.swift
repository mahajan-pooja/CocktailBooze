import Foundation
import UIKit

class Common {
    static func setImage(imageView: UIImageView, url: URL) {
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "cocktail"), options: nil, progressBlock: nil, completionHandler: { _, _, _, _ in
                imageView.clipsToBounds = true
        })
    }
    
    static func setShadow(view: UIView) {
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1.5
    }
    
    static func setButtonShadow(button: UIButton) {
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 5
        button.layer.cornerRadius = button.frame.height / 2
    }
}
