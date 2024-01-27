//
//  GlobalExtension.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import Foundation
import UIKit
import SnapKit

fileprivate var spinnerView: UIView?
fileprivate let rickandmortyLogo: UIImage? = {
    var image = UIImage(named: "rickandmorty")
    image = image?.withRenderingMode(.alwaysOriginal)
    
    return image
}()

extension UIColor {
    // add hex code color
    public convenience init(hex:String) {
        var r = 0, g = 0, b = 0, a = 255

        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let offset = hexString.hasPrefix("#") ? 1 : 0
        let ch = hexString.map{$0}
        
        switch(ch.count - offset) {
        case 8:
            a = 16 * (ch[offset+6].hexDigitValue ?? 0) + (ch[offset+7].hexDigitValue ?? 0)
            fallthrough
        case 6:
            r = 16 * (ch[offset+0].hexDigitValue ?? 0) + (ch[offset+1].hexDigitValue ?? 0)
            g = 16 * (ch[offset+2].hexDigitValue ?? 0) + (ch[offset+3].hexDigitValue ?? 0)
            b = 16 * (ch[offset+4].hexDigitValue ?? 0) + (ch[offset+5].hexDigitValue ?? 0)
            break
        case 4:
            a = 16 * (ch[offset+3].hexDigitValue ?? 0) + (ch[offset+3].hexDigitValue ?? 0)
            fallthrough
        case 3:  // Three digit #0D3 is the same as six digit #00DD33
            r = 16 * (ch[offset+0].hexDigitValue ?? 0) + (ch[offset+0].hexDigitValue ?? 0)
            g = 16 * (ch[offset+1].hexDigitValue ?? 0) + (ch[offset+1].hexDigitValue ?? 0)
            b = 16 * (ch[offset+2].hexDigitValue ?? 0) + (ch[offset+2].hexDigitValue ?? 0)
            break
        default:
            a = 0
            break
        }
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
    }
}


extension UIViewController {
    public func showLoading() {
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView?.backgroundColor = .black.withAlphaComponent(0.7)
        
        let iv = UIImageView(image: rickandmortyLogo)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        spinnerView?.addSubview(iv)
        
        applyConstraints(for: iv, in: spinnerView!)
        
        UIView.transition(with: self.view, duration: 0.4, options: .transitionCrossDissolve) { [weak self] in
            self?.view.addSubview(spinnerView!)
        }
        
        animatedFadeInOutImage(iv)
    }
    
    public func hideLoading() {
        UIView.transition(with: self.view, duration: 0.4, options: .transitionCrossDissolve) {
            spinnerView?.removeFromSuperview()
            spinnerView = nil
        }
    }
    
    private func applyConstraints(for view: UIView, in spinnerview: UIView) {
        view.snp.makeConstraints { make in
            make.centerX.equalTo(spinnerview)
            make.centerY.equalTo(spinnerview)
            make.width.equalTo(spinnerview).multipliedBy(0.15)
            make.height.equalTo(spinnerview).multipliedBy(0.15)
        }
    }
    
    private func animatedFadeInOutImage(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse]) {
            imageView.alpha = 0.1
        }
    }
    
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
