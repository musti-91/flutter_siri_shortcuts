//
//  ShortcutsHandler.swift
//  flutter_siri_shortcuts
//
//  Created by Mustafa Alroomi on 30/10/2023.
//

import Foundation
import UIKit
import Intents
import IntentsUI


enum ShortcutResponseStatus: String {
  case added = "added"
  case updated = "updated"
  case deleted = "deleted"
  case cancelled = "cancelled"
}

class ShortcutOptions: NSObject {
  let activityType: String
  let title: String?
  let requiredUserInfoKeys: Set<String>?
  let userInfo: [AnyHashable : Any]?
  let needsSave: Bool
  let keywords: Array<String>?
  let persistentIdentifier: String?
  let isEligibleForHandoff: Bool
  let isEligibleForSearch: Bool
  let isEligibleForPublicIndexing: Bool
  let expirationDate: Date?
  let webpageURL: String?
  let isEligibleForPrediction: Bool
  let suggestedInvocationPhrase: String?
  
  init(_ json: Dictionary<String, Any>) {
    self.activityType = json["activityType"] as! String
    
    if let title = json["title"] as? String {
      self.title = title
    } else {
      self.title = nil
    }
    
    if let requiredUserInfoKeys = json["requiredUserInfoKeys"] {
      self.requiredUserInfoKeys = requiredUserInfoKeys as? Set<String>
    } else {
      self.requiredUserInfoKeys = nil
    }
    
    if let userInfo = json["userInfo"] {
      self.userInfo = (userInfo as! [AnyHashable : Any])
    } else {
      self.userInfo = nil
    }
    
    if let keywords = json["keywords"] {
      self.keywords = (keywords as! Array<String>)
    } else {
      self.keywords = nil
    }
    
    if let persistentIdentifier = json["persistentIdentifier"] {
      self.persistentIdentifier = (persistentIdentifier as! String)
    } else {
      self.persistentIdentifier = nil
    }
    
    if let expirationDate = json["expirationDate"] {
      self.expirationDate = (expirationDate as! Date)
    } else {
      self.expirationDate = nil
    }
    
    if let webpageURL = json["webpageURL"] as? String {
      self.webpageURL = webpageURL
    } else {
      self.webpageURL = nil
    }
    
    if let suggestedInvocationPhrase = json["suggestedInvocationPhrase"] as? String {
      self.suggestedInvocationPhrase = suggestedInvocationPhrase
    } else {
      self.suggestedInvocationPhrase = nil
    }
    
    if let needsSave = json["needsSave"] {
      self.needsSave = needsSave as! Bool
    } else {
      self.needsSave = false
    }
    
    if let isEligibleForHandoff = json["isEligibleForHandoff"] {
      self.isEligibleForHandoff = isEligibleForHandoff as! Bool
    } else {
      self.isEligibleForHandoff = true
    }
    
    if let isEligibleForSearch = json["isEligibleForSearch"] {
      self.isEligibleForSearch = isEligibleForSearch as! Bool
    } else {
      self.isEligibleForSearch = false
    }
    
    if let isEligibleForPublicIndexing = json["isEligibleForPublicIndexing"]  {
      self.isEligibleForPublicIndexing = isEligibleForPublicIndexing as! Bool
    } else {
      self.isEligibleForPublicIndexing = false
    }
    
    if let isEligibleForPrediction = json["isEligibleForPrediction"] {
      self.isEligibleForPrediction = isEligibleForPrediction as! Bool
    } else {
      self.isEligibleForPrediction = false
    }
    
  }
  
  override var description: String {
    return "activityType: \(self.activityType), title: \(String(describing: self.title)), requiredUserInfoKeys: \(String(describing: requiredUserInfoKeys)), userInfo: \(String(describing: self.userInfo)), needsSave: \(self.needsSave), keywords: \(String(describing: self.keywords)), persistentIdentifier: \(String(describing: self.persistentIdentifier)), isEligibleForHandoff: \(self.isEligibleForHandoff), isEligibleForSearch: \(self.isEligibleForSearch), isEligibleForPublicIndexing: \(self.isEligibleForPublicIndexing), expirationDate: \(String(describing: self.expirationDate)), webpageURL: \(String(describing: self.webpageURL)), isEligibleForPrediction: \(self.isEligibleForPrediction), suggestedInvocationPhrase: \(String(describing: self.suggestedInvocationPhrase))"
  }
}


@available(iOS 12.0, *)
class ShortcutsHandler: NSObject, INUIAddVoiceShortcutViewControllerDelegate,INUIEditVoiceShortcutViewControllerDelegate {
  var presentViewController: UIViewController?
  var voiceShortcuts: Array<NSObject> = []
  
  func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
    if (voiceShortcut != nil) {
      voiceShortcuts.append(voiceShortcut!)
    }
    dismissPresenting(.cancelled)
  }
  
  func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
    dismissPresenting(.cancelled)
  }
  
  func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
    if(voiceShortcut != nil) {
      let index = (voiceShortcuts as! Array<INVoiceShortcut>).firstIndex { (shortcut) -> Bool in
        return shortcut.identifier ==  voiceShortcut!.identifier
      }
      if(index != nil) {
        voiceShortcuts[index!] = voiceShortcut!
      }
    }
    dismissPresenting(.updated)
  }
  
  func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
    let index = (voiceShortcuts as! Array<INVoiceShortcut>).firstIndex { (shortcut) -> Bool in
      return shortcut.identifier == deletedVoiceShortcutIdentifier
    }
    
    if (index != nil) {
      voiceShortcuts.remove(at: index!)
    }
    
    dismissPresenting(.deleted)
  }
  
  func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
    dismissPresenting(.cancelled)
  }
  
  
  static func generateActivity(_ jsonOptions: Dictionary<String,Any>) -> NSUserActivity {
    let options = ShortcutOptions(jsonOptions)
    
    let activity = NSUserActivity(activityType: options.activityType)
    activity.title = options.title
    activity.requiredUserInfoKeys = options.requiredUserInfoKeys
    activity.userInfo = options.userInfo
    activity.needsSave = options.needsSave
    activity.keywords = Set(options.keywords ?? [])
    activity.isEligibleForHandoff = options.isEligibleForHandoff
    activity.isEligibleForSearch = options.isEligibleForSearch
    activity.isEligibleForPublicIndexing = options.isEligibleForPublicIndexing
    activity.expirationDate = options.expirationDate
    if let urlString = options.webpageURL {
      activity.webpageURL = URL(string: urlString)
    }
    
    activity.isEligibleForPrediction = options.isEligibleForPrediction
    activity.suggestedInvocationPhrase = options.suggestedInvocationPhrase
    if let identifier = options.persistentIdentifier {
      activity.persistentIdentifier = NSUserActivityPersistentIdentifier(identifier)
    }
    
    return activity
  
  }
  
  func dismissPresenting(_ status: ShortcutResponseStatus) -> Void {
    presentViewController?.dismiss(animated: true, completion: nil)
    presentViewController = nil
  }
  
  
  // exported
  func presentShortcut(_ jsonOptions: Dictionary<String,Any>) {
    let activity = ShortcutsHandler.generateActivity(jsonOptions)
    
    let shortcut = INShortcut(userActivity: activity);
    
    let addedVoiceShortcut = (voiceShortcuts as! Array<INVoiceShortcut>).first { (voiceShortcut) -> Bool in
      if let userActivity = voiceShortcut.shortcut.userActivity, userActivity.activityType == activity.activityType {
        return true
      } else{
        return false
      }
    }
    
    if(addedVoiceShortcut == nil) {
      presentViewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
      presentViewController!.modalPresentationStyle = .formSheet
      (presentViewController as! INUIAddVoiceShortcutViewController).delegate = self
    } else {
      presentViewController = INUIEditVoiceShortcutViewController(voiceShortcut: addedVoiceShortcut!)
      presentViewController!.modalPresentationStyle = .formSheet
      (presentViewController as! INUIEditVoiceShortcutViewController).delegate = self
    }
    
    DispatchQueue.main.async {
      UIApplication.shared.keyWindow!.rootViewController!.present(self.presentViewController!, animated: true, completion: nil)
    }
  }
  
  func donateShortcut(_ jsonOptions: Dictionary<String, Any>) {
    let activity = ShortcutsHandler.generateActivity(jsonOptions)
    DispatchQueue.main.async {
      UIApplication.shared.keyWindow!.rootViewController!.userActivity = activity
    }
    activity.becomeCurrent()
    print("Created new shortcut")
  }
  
  func clearShortcuts() -> Bool {
    var result = false
    if #available(iOS 12.0, *) {
      NSUserActivity.deleteAllSavedUserActivities {
        result = true
      }
    } else{
       print("Not supported or not shortcus found")
       result = false
    }
    return result
  }
}

