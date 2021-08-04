//
//  WebCollectionViewCell.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import UIKit

class WebCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
        
        DispatchQueue.main.async {
            let request = URLRequest(url: URL(string: "https://www.cocoapods.org")!)
            self.webView.loadRequest(request)
        }
    }
}

extension WebCollectionViewCell: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        indicatorView.animate(true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicatorView.animate(false)
        
        let webviewHeight1: NSString = webView.stringByEvaluatingJavaScript(from: "document.height !== undefined ? document.height : document.body.offsetHeight") as! NSString
        let webviewHeight2 = self.webView.scrollView.contentSize.height
        print("didFinishLoad")
        print(webviewHeight1.floatValue)
        print(webviewHeight2)
    }
}
