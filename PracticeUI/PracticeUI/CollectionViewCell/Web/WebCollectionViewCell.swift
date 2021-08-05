//
//  WebCollectionViewCell.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import UIKit

protocol WebViewContentHeightDelegate {
    func calculate(height: CGFloat)
}

class WebCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var delegate: WebViewContentHeightDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
    }
    
    override func prepareForReuse() {
        webView.stopLoading()
    }
    
    func request(_ urlString: String) {
        DispatchQueue.main.async {
            if self.webView.request?.url?.absoluteString == urlString { return }
            print("request \(urlString)")
            let request = URLRequest(url: URL(string: urlString)!)
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
        
        let webviewHeightString: NSString = webView.stringByEvaluatingJavaScript(from: "document.height !== undefined ? document.height : document.body.offsetHeight")! as NSString
        let height = CGFloat(webviewHeightString.floatValue)
        print("didFinishLoad \(height)")
        delegate?.calculate(height: height)
    }
}
