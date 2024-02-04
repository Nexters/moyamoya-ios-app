//
//  SearchSubway.Rep.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/5/24.
//

import Foundation

extension ResponseDTO {
    struct SearchSubway: Respondable {
        var status: String
        var message: String
        var data: DataClass
        
        enum CodingKeys: CodingKey {
            case status
            case message
            case data
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ResponseDTO.SearchSubway.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.SearchSubway.CodingKeys.self)
            self.status = try container.decode(String.self, forKey: ResponseDTO.SearchSubway.CodingKeys.status)
            self.message = try container.decode(String.self, forKey: ResponseDTO.SearchSubway.CodingKeys.message)
            self.data = try container.decode(ResponseDTO.SearchSubway.DataClass.self, forKey: ResponseDTO.SearchSubway.CodingKeys.data)
        }
        
        struct DataClass: Decodable {
            /// 지하철 역
            let name: String
            /// 지하철 호선
            let lines: [String]
            /// 좌표
            let location: Location
            
            enum CodingKeys: CodingKey {
                case name
                case lines
                case location
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.SearchSubway.DataClass.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.SearchSubway.DataClass.CodingKeys.self)
                self.name = try container.decode(String.self, forKey: ResponseDTO.SearchSubway.DataClass.CodingKeys.name)
                self.lines = try container.decode([String].self, forKey: ResponseDTO.SearchSubway.DataClass.CodingKeys.lines)
                self.location = try container.decode(ResponseDTO.SearchSubway.DataClass.Location.self, forKey: ResponseDTO.SearchSubway.DataClass.CodingKeys.location)
            }
            
            struct Location: Decodable {
                var latitude: String
                var longitude: String
                
                enum CodingKeys: CodingKey {
                    case latitude
                    case longitude
                }
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<ResponseDTO.SearchSubway.DataClass.Location.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.SearchSubway.DataClass.Location.CodingKeys.self)
                    self.latitude = try container.decode(String.self, forKey: ResponseDTO.SearchSubway.DataClass.Location.CodingKeys.latitude)
                    self.longitude = try container.decode(String.self, forKey: ResponseDTO.SearchSubway.DataClass.Location.CodingKeys.longitude)
                }
            }
        }
    }
}
