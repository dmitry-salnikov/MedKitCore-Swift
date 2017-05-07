/*
 -----------------------------------------------------------------------------
 This source file is part of MedKitCore.
 
 Copyright 2016-2017 Jon Griffeth
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
 */


import Foundation;


/**
 Port
 
 A base class for objects that serve as components in a protocol stack.  Ports
 may be linked together to instantiate a complete stack, with each component serving
 as a port to the component above it.
 
 - Remarks: Apparently the class must inherit from NSObject in order for
    derived classes to conform with some protocols, such as StreamDelegate.
 */
public protocol Port: class {
    
    /**
     Port delegate.
     
     A delegate used to process incoming data and other types of events.
     */
    weak var delegate : PortDelegate? { get set }
    
    /**
     Send data.
     
     Used to send data to the port.
     
     - Parameters:
        - data: Data to be sent to the port.  The data may either be a fragment
            in a data stream or a complete message depending on the
            functionality being provided by the port.
     */
    func send(_ data: Data);

    /**
     Start port.
     
     When a stack is first constructed, it will typically be quiescent until
     the start() method is called from the top of the stack.  The call is
     propagated downward to the port at the base of the stack, which then
     begins the initialization process.
     */
    func start();

    /**
     Shutdown port.
     
     This method is used to initiate a graceful shutdown of the stack.  The
     call is propagated downward to the port at the base of the stack, which
     then initiates the shutdown process.
     */
    func shutdown(reason: Error?);
    
}


// End of File