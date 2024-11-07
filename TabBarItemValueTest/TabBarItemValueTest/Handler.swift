//
//  Handler.swift
//  TabBarItemValueTest
//
//  Created by Dr. Michael Lauer on 07.11.24.
//
import Foundation

@Observable
class Handler {

    var homeBadgeValue: Int = 0

    static var shared = Handler()
    private init () {

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.homeBadgeValue += 1

        }

    }
}

