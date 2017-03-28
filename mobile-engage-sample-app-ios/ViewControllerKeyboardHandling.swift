//
//  Copyright © 2017. Emarsys. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func showAlert(with message: String) {
        let controller = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(controller, animated: true)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWasShown),
                                               name: Notification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillBeHidden),
                                               name: Notification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWasShown(notification: Notification) {
        let rect: CGRect = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! CGRect
        scrollViewBottomConstraint.constant = rect.height;
        self.view.layoutIfNeeded()
        
        if let firstResponder = firstResponder() {
            scrollView.scrollRectToVisible(firstResponder.frame, animated: true)
        }
    }
    
    func firstResponder() -> UIView? {
        let responders: [UIView] = [contactFieldIdTextField, contactFieldValueTextField, sidTextField, customEventNameTextField, customEventAttributesTextView]
        
        return responders.first { (responder:UIView) -> Bool in
            return responder.isFirstResponder
        }
    }
    
    func keyboardWillBeHidden(notification: Notification) {
        scrollViewBottomConstraint.constant = 0;
    }
}