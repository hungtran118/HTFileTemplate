//___FILEHEADER___

import UIKit
import GoogleMobileAds

class ___FILEBASENAMEASIDENTIFIER___: NSObject, GADInterstitialDelegate {
    
    var interstitialView: GADInterstitial!
    
    func createAd() -> GADInterstitial {
        interstitialView = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitialView.delegate = self
        let request = GADRequest()
        interstitialView.load(request)
        return interstitialView
    }
    
    @objc func showAd() {
        if interstitialView != nil {
            if (interstitialView.isReady == true){
                interstitialView.present(fromRootViewController:UIApplication.topViewController()!)
            } else {
                print("ad wasn't ready")
                interstitialView = createAd()
            }
        } else {
            print("ad wasn't ready")
            interstitialView = createAd()
        }
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Ad Received")
        if ad.isReady {
            interstitialView.present(fromRootViewController: UIApplication.topViewController()!)
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("Did Dismiss Screen")
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("Will Dismiss Screen")
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("Will present screen")
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("Will leave application")
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("Failed to present screen")
    }
    
    private func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(String(describing: ad)) did fail to receive ad with error \(error)")
    }
}


/*
 _____.*'USAGE'*._____

 - Import library 'Google-Mobile-Ads-SDK'
 
 - Put ___FILEBASENAMEASIDENTIFIER___().showAd() in where you want to show ad.
 
*/
