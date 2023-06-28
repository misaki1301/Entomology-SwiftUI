//
//  UITestingHelper.swift
//  Entomology
//
//  Created by Paul Pacheco on 15/06/23.
//
#if DEBUG
import Foundation
struct UITestingHelper {
	static var isUITesting: Bool {
		ProcessInfo.processInfo.arguments.contains("-ui-testing")
	}
	
	static var isInPreview: Bool {
		ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
	}
}
#endif
