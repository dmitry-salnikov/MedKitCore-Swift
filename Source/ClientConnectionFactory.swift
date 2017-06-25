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


import Foundation


/**
 ClientConnectionFactory protocol.
 */
public protocol ClientConnectionFactory {
    
    var priority: Int { get } //: Protocol priority.
    
    /**
     Create connection.
     
     - Parameters:
        - port: The server port.
        - principal: The principal for the client.
     */
    func instantiate(to port: Port, for device: DeviceBackend, as principal: Principal?) -> ClientConnectionBase
    
}

/**
 ClientConnectionFactory template.
 */
public class ClientConnectionFactoryTemplate<T: ClientConnectionBase>: ClientConnectionFactory {
    
    public let priority: Int
    
    public init(priority: Int)
    {
        self.priority = priority
    }
    
    public func instantiate(to port: Port, for device: DeviceBackend, as principal: Principal?) -> ClientConnectionBase
    {
        return T(to: port, for: device, as: principal)
    }
    
}


// End of File
