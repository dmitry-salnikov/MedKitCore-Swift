/*
 -----------------------------------------------------------------------------
 This source file is part of MedKitCore.
 
 Copyright 2017 Jon Griffeth
 
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
 Identity
 
 - Remarks:
    Identity instances are immutable to prevent unintended side-effects.
    Changes to an identity requires the creation of a new instance.
 */
public class Identity: Equatable {
    
    /**
     Identity type.
     
     Different types of principals may have different naming conventions.  The
     identity type separates namespaces to prevent conflicts.
     */
    public enum IdentityType {
        case Device;       //: Devices.
        case Organization; //: An organization, such as a certificate authority.
        case User;         //: An actual person.
    }
    
    // MARK: - Properties
    
    public var  profile : JSON         { return getProfile(); }
    public var  name    : String       { return _name; }
    public var  type    : IdentityType { return _type; }
    public var  string  : String       { return "\(type.string)/\(name)"; }
    
    // MARK: - Shadowed
    private var _name: String;       //: Name
    private let _type: IdentityType; //: Type of identity.
    
    // MARK: - Initializers
    
    /**
     Initialize instance.
     */
    public init(named name: String, type: IdentityType)
    {
        _name = name;
        _type = type;
    }
    
    /**
     Initialize instance.
     */
    public init(from profile: JSON)
    {
        _name = profile[KeyName].string!;
        _type = IdentityType(string: profile[KeyType].string!)!;
    }
    
    // MARK: - Profile Management
    
    private func getProfile() -> JSON
    {
        let profile = JSON();
        
        profile[KeyName] = name;
        profile[KeyType] = type.string;
        
        return profile;
    }
    
}

// MARK: - Equatable

/**
 Identity equatable operator.
 */
public func ==(lhs: Identity, rhs: Identity) -> Bool
{
    return lhs.name == rhs.name && lhs.type == rhs.type;
}

// MARK: - Extensions

public extension Identity.IdentityType {
    
    public init?(string: String)
    {
        switch string {
        case "Device" :
            self = .Device;
            
        case "Organization" :
            self = .Organization;
            
        case "User" :
            self = .User;

        default :
            return nil;
        }
    }
    
    public var string: String {
        switch self {
        case .Device :
            return "Device";
        
        case .Organization :
            return "Organization";
        
        case .User :
            return "User";

        }
    }
    
}


// End of File