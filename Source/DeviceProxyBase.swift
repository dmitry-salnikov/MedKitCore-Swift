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
 Proxy device.
 */
public class DeviceProxyBase: DeviceBase, DeviceProxy {
    
    override public var defaultBackend: Backend       { return netBackend; }
    public var          ports         : [PortFactory] { return netBackend.ports.ports; }
    override public var reachable     : Bool          { return netBackend.reachable; }

    // MARK: - Private
    private var netBackend: NetBackend!;
    
    /**
     Initialize instance from device information.
     */
    override public init(from deviceInfo: DeviceInfo)
    {
        super.init(from: deviceInfo);
        netBackend = NetBackend(device: self);
        backend    = netBackend;
    }
    
    /**
     Initialize instance from profile.
     */
    override public init(_ parent: DeviceBase?, from profile: JSON)
    {
        super.init(parent, from: profile);
        netBackend = NetBackend(device: self);
        backend    = netBackend;
    }
    
    /**
     Deinitialize instance.
     */
    deinit
    {
        DeviceCache.main.removeDevice(with: identifier);
    }
    
    /**
     Add port.
     */
    func addPort(_ port: NetPortFactory)
    {
        let reachable = netBackend.reachable;
        
        netBackend.ports.addPort(port);
        observers.withEach { $0.device(self, didAdd: port); }
        
        if !reachable && netBackend.reachable {
            observers.withEach { $0.deviceDidUpdateReachability(self); }
        }
    }
    
    /**
     Remove port.
     */
    func removePort(_ port: NetPortFactory)
    {
        let reachable = netBackend.reachable;
        
        netBackend.ports.removePort(port);
        observers.withEach { $0.device(self, didRemove: port); }
        
        if reachable && !netBackend.reachable {
            observers.withEach { $0.deviceDidUpdateReachability(self); }
        }
    }
    
    /**
     Remove all ports.
     */
    func removeAllPorts()
    {
        let reachable = netBackend.reachable;
        
        netBackend.ports.removeAllPorts();
        if reachable {
            observers.withEach { $0.deviceDidUpdateReachability(self); }
        }
    }
    
    /**
     Close connection to device.
     */
    override func close(reason: Error?)
    {
        netBackend.deviceClose(self, reason: reason) { error in }
    }
    
    /**
     Close connection to device, with completion handler.
     */
    override public func close(completionHandler completion: @escaping (Error?) -> Void)
    {
        netBackend.deviceClose(self, reason: nil, completionHandler: completion);
    }
    
    /**
     Open device.
     */
    override public func open(completionHandler completion: @escaping (Error?) -> Void)
    {
        netBackend.deviceOpen(self, completionHandler: completion);
    }
    
}


// End of File
