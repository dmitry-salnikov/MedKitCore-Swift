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


// string constants
fileprivate let NullString         = "Null";
fileprivate let PublicKeyString    = "Public Key";
fileprivate let SharedSecretString = "Shared Secret";

/**
 Credentials type.
 */
public enum CredentialsType {
    case Null;
    case PublicKey;
    case SharedSecret;
    
    /**
     Initialize instance from string.
     
     - Parameters:
        - string: String representation for the credentials type.
     */
    init?(string: String)
    {
        switch string {
        case NullString :
            self = .Null;
            
        case PublicKeyString :
            self = .PublicKey;
            
        case SharedSecretString :
            self = .SharedSecret;
            
        default :
            return nil;
        }
    }
    
    /**
     Get string representation.
     
     - Returns:
        Returns a string representation for the credentials type.
     */
    public var string: String {
        switch self {
        case .Null :
            return NullString;

        case .PublicKey :
            return PublicKeyString;
            
        case .SharedSecret :
            return SharedSecretString;
        }
    }
}


// End of File