/*
 -----------------------------------------------------------------------------
 This source file is part of MedKitCore.
 
 Copyright 2016-2018 Jon Griffeth
 
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


import Foundation
import SecurityKit


/**
 Server connection.
 
 A base class for server connections.
 */
open class ServerConnectionBase: ConnectionBase {
    
    /**
     Initialize instance.
     
     - Parameters:
        - port:      The client port.
        - device:    The device being connected to.
        - principal: The principal associated with the device.
     */
    public required init(from port: Port, to device: DeviceFrontend, using principalManager: PrincipalManager)
    {
        super.init(port: port)
    }
    
}


// End of File
