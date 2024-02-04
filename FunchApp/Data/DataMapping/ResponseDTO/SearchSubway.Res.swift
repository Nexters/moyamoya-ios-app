//
//  SearchSubway.Rep.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/5/24.
//

import Foundation

extension ResponseDTO {
    struct SearchSubwayStation: Respondable {
        var status: String
        var message: String
        var data: DataClass
        
        enum CodingKeys: CodingKey {
            case status
            case message
            case data
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ResponseDTO.SearchSubwayStation.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.SearchSubwayStation.CodingKeys.self)
            self.status = try container.decode(String.self, forKey: ResponseDTO.SearchSubwayStation.CodingKeys.status)
            self.message = try container.decode(String.self, forKey: ResponseDTO.SearchSubwayStation.CodingKeys.message)
            self.data = try container.decode(ResponseDTO.SearchSubwayStation.DataClass.self, forKey: ResponseDTO.SearchSubwayStation.CodingKeys.data)
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
                let container: KeyedDecodingContainer<ResponseDTO.SearchSubwayStation.DataClass.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.SearchSubwayStation.DataClass.CodingKeys.self)
                self.name = try container.decode(String.self, forKey: ResponseDTO.SearchSubwayStation.DataClass.CodingKeys.name)
                self.lines = try container.decode([String].self, forKey: ResponseDTO.SearchSubwayStation.DataClass.CodingKeys.lines)
                self.location = try container.decode(ResponseDTO.SearchSubwayStation.DataClass.Location.self, forKey: ResponseDTO.SearchSubwayStation.DataClass.CodingKeys.location)
            }
            
            struct Location: Decodable {
                var latitude: String
                var longitude: String
                
                enum CodingKeys: CodingKey {
                    case latitude
                    case longitude
                }
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<ResponseDTO.SearchSubwayStation.DataClass.Location.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.SearchSubwayStation.DataClass.Location.CodingKeys.self)
                    self.latitude = try container.decode(String.self, forKey: ResponseDTO.SearchSubwayStation.DataClass.Location.CodingKeys.latitude)
                    self.longitude = try container.decode(String.self, forKey: ResponseDTO.SearchSubwayStation.DataClass.Location.CodingKeys.longitude)
                }
            }
        }
    }
}

extension ResponseDTO.SearchSubwayStation {
    func toDomain() -> [SubwayInfo] {
        // TODO: - 
        
    }
}
