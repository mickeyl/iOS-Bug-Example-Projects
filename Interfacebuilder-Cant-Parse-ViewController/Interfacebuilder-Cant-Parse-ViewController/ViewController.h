//
//  ViewController.h
//  Interfacebuilder-Cant-Parse-ViewController
//
//  Created by Dr. Michael Lauer on 13.03.17.
//  Copyright © 2017 Dr. Lauer Information Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

// drag'n'drop from storyboard working
//@interface ViewController : UIViewController

// drag'n'drop from storyboard not working
@interface ViewController<SomeObject> : UIViewController


@end

