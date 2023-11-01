//
//  AddToSiriButton.swift
//  flutter_siri_shortcuts
//
//  Created by Mustafa Alroomi on 29/10/2023.
//

import Foundation
import Flutter
import Intents
import IntentsUI
import UIKit

@available(iOS 12.0, *)
class AddToSiriButtonFactory: NSObject, FlutterPlatformViewFactory {
  private var messenger: FlutterBinaryMessenger
  
  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }
  
  func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
    return AddToSiriButtonView(
      frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
  }
  
  public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    return FlutterStandardMessageCodec.sharedInstance()
  }
}

@available(iOS 12.0, *)
class AddToSiriButtonView: NSObject, FlutterPlatformView {
  private var addToSiriButton: UIView
  init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger?) {
    addToSiriButton = AddToSiriButton(frame: frame, args: args)
    super.init()
  }
  func view() -> UIView {
    return addToSiriButton
  }
}

@available(iOS 12.0, *)
class AddToSiriButton: UIView {
  
  private var button: INUIAddVoiceShortcutButton
  
  init(frame: CGRect, args: Any?) {
    let args = args as! Dictionary<String, Any?>
    var style: INUIAddVoiceShortcutButtonStyle
    if #available(iOS 13.0, *) {
      if UITraitCollection.current.userInterfaceStyle == .light {
        style = .whiteOutline
      } else {
        style = .blackOutline
      }
    } else {
      style = .blackOutline
    }
    button = INUIAddVoiceShortcutButton(style: style)
    super.init(frame: frame)
    createActivity(args: args)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func createActivity(args: Dictionary<String, Any?>) {
    let activity = NSUserActivity(activityType: args["id"] as! String)
    activity.title = args["title"] as? String
    activity.suggestedInvocationPhrase = args["title"] as? String
    activity.webpageURL = URL(string: args["url"] as! String)
    activity.userInfo?["fromShortcut"] = true
    let shortcut = INShortcut(userActivity: activity);
    
      /// This sets up the button Add to Siri
    button.translatesAutoresizingMaskIntoConstraints = false
    button.shortcut = shortcut;
      /// This delegate declares callbacks to when the button is pressed
    button.delegate = self
    
    self.addSubview(button)
    
    button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }
}

@available(iOS 12.0, *)
extension AddToSiriButton: INUIAddVoiceShortcutButtonDelegate {
  func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
    addVoiceShortcutViewController.delegate = self
    getRootController()?.present(addVoiceShortcutViewController, animated: true, completion: nil)
  }
  
  func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
    editVoiceShortcutViewController.delegate = self
    getRootController()?.present(editVoiceShortcutViewController, animated: true, completion: nil)
  }
  
  func getRootController() -> UIViewController? {
    return UIApplication.shared.keyWindow?.rootViewController;
  }
}

@available(iOS 12.0, *)
extension AddToSiriButton: INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate {
  
  func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
