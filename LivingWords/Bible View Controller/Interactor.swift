//
//  Interactor.swift
//  LivingWords
//
//  Created by Chandi Abey  on 11/13/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

//an interactor lets you control the animation progress using a pan gesture. Modal will follow your finger and if you drag down far enough it will dismiss. 


class Interactor: UIPercentDrivenInteractiveTransition
{
    //tracks whether user interaction is in progress
    var hasStarted = false
    //determines whether transition should finish or roll back to original state 
    var shouldFinish = false
    
    
    
    
}
