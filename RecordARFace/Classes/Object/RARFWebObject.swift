//
//  RARFWebObject.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/05/17.
//

import UIKit
import WebKit

class RARFWebObject: NSObject, WKNavigationDelegate, WKUIDelegate {

    var webFlg = false
    var rARFWebUIView: RARFWebUIView?
    var data: RARFTableViewDataSource?

    private var weBOffsetY: CGFloat = 0

    lazy var webView: WKWebView = {
        var webView = WKWebView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.delegate = data
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()

    override init() {
        super.init()

        rARFWebUIView = RARFWebUIView()
        rARFWebUIView?.goBt.alpha = 0
        rARFWebUIView?.forwardBt.alpha = 0
        webView.addSubview(rARFWebUIView ?? UIView())

        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)

        let notificationHide = NotificationCenter.default
        notificationHide.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                     name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification?) {
        webFlg = false
        let offset = CGPoint(x: 0, y: -(UINavigationController().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height))
        webView.scrollView.setContentOffset(offset, animated: false)
    }

    @objc func keyboardWillHide(_ notification: Notification?) { webFlg = true }

    func webReload() {
        webFlg = true
        guard let url = URL(string: RASRFWebUrlPath) else { fatalError() }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    func webForward() {
        if webView.canGoForward == true { webView.goForward() }
        weBOffsetY = webView.scrollView.contentOffset.y
        let offset = CGPoint(x: 0, y: weBOffsetY)
        webView.scrollView.setContentOffset(offset, animated: true)
    }

    func webBack() {
        if webView.backForwardList.backList.count == 0 {
            webView.isHidden = true
        } else {
            webView.goBack()
            webView.isHidden = false
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
        
        weBOffsetY = 0
        self.webFlg = false
    }

    func webContentOffSetX(eView: UIView, contentOffSetY: CGFloat) {
        
        if eView.frame.origin.y > webView.frame.height/2 {
            weBOffsetY += contentOffSetY
        } else {
            weBOffsetY -= contentOffSetY
        }

        if eView.frame.origin.x < 150 {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView?.goBt.alpha = 1 }
        } else {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView?.goBt.alpha = 0 }
        }

        if eView.frame.origin.x > UIScreen.main.bounds.width - 150 {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView?.forwardBt.alpha = 1 }
        } else {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView?.forwardBt.alpha = 0 }
        }

        if eView.frame.origin.y < 0 || eView.frame.origin.y > UIScreen.main.bounds.height{ webFlg = true }
    }

    func webEViewSet(eView: UIView) {
        if webFlg == true && eView.frame.origin.y > -(UINavigationController().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height) {
            let offset = CGPoint(x: 0, y: eView.frame.origin.y + weBOffsetY)
            webView.scrollView.setContentOffset(offset, animated: true)
            rARFWebUIView?.goBt.frame.origin.y = UIScreen.main.bounds.height/2
            rARFWebUIView?.forwardBt.frame.origin.y = UIScreen.main.bounds.height/2
            rARFWebUIView?.originTextField(rect: eView.frame, rARFObject: self)
        }
    }
}
