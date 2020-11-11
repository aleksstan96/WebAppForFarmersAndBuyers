import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MapeService {

  constructor(private httpClient: HttpClient) { }

 

  hereDistanca(lat,lng,dlat,dlng):Observable<GetResponseHereDistance>{
   
    let url=`https://route.ls.hereapi.com/routing/7.2/calculateroute.json?waypoint0=${lat}%2C${lng}&waypoint1=${dlat}%2C${dlng}&mode=fastest%3Bcar%3Btraffic%3Aenabled&departure=now&apiKey=178DH4nEPfPlq5bflJbpfB2vCZZNRG5W7NOLpJ8MP3g`;
   // let url="https://maps.googleapis.com/maps/api/directions/json"
    return this.httpClient.get<GetResponseHereDistance>(url)

  }

  hereDistancaCoord(mesto):Observable<GetResponseHereCoords>{
    //let mesto = "Mutapova 28 Beograd";
   
   
    let url=`https://geocoder.ls.hereapi.com/6.2/geocode.json?searchtext=${mesto}&gen=9&apiKey=178DH4nEPfPlq5bflJbpfB2vCZZNRG5W7NOLpJ8MP3g`
    return this.httpClient.get<GetResponseHereCoords>(url)
  }

  hereDistancaCoordUe():Observable<GetResponseHereCoords>{
   // let mesto = "Kursulina 14 Uzice";
   let mesto= 'Rogacica'
    let url=`https://geocoder.ls.hereapi.com/6.2/geocode.json?searchtext=${mesto}&gen=9&apiKey=178DH4nEPfPlq5bflJbpfB2vCZZNRG5W7NOLpJ8MP3g`
    return this.httpClient.get<GetResponseHereCoords>(url)
  }



  
}



export interface GetResponseHereCoords{
  Response: {
    MetaInfo: {
      Timestamp: any
    },
    View: [
      {
        _type: any,
        ViewId: any,
        Result: [
          {
            Relevance: any,
            MatchLevel: any,
            MatchQuality: {
              State:any,
              City: any,
              Street: [
                any
              ],
              HouseNumber: any
            },
            MatchType: any,
            Location: {
              LocationId: any,
              LocationType: any,
              DisplayPosition: {
                Latitude: number,
                Longitude: number
              },
              NavigationPosition: [
                {
                  Latitude: any,
                  Longitude: any
                }
              ],
              MapView: {
                TopLeft: {
                  Latitude: any,
                  Longitude: any
                },
                BottomRight: {
                  Latitude: any,
                  Longitude: any
                }
              },
              Address: {
                Label: any,
                Country: any,
                State: any,
                County: any,
                City: any,
                District: any,
                Street: any,
                HouseNumber: any,
                PostalCode: any,
                AdditionalData: [
                  {
                    value: any,
                    key: any
                  },
                  {
                    value: any,
                    key: any
                  },
                  {
                    value: any,
                    key: any
                  },
                  {
                    value: any,
                    key: any
                  }
                ]
              }
            }
          }
        ]
      }
    ]
  }
}


interface GetResponseHereDistance{
  response: {
    metaInfo: {
      timestamp: any,
      mapVersion: any,
      moduleVersion: any,
      interfaceVersion: any,
      availableMapVersion: [
        any
      ]
    },
    route: [
      {
        waypoint: [
          {
            linkId: any,
            mappedPosition: {
              latitude: any,
              longitude: any
            },
            originalPosition: {
              latitude: any,
              longitude: any
            },
            type: any,
            spot: any,
            sideOfStreet: any,
            mappedRoadName: any,
            label: any,
            shapeIndex:any,
            source:any
          },
          {
            linkId: any,
            mappedPosition: {
              latitude: any,
              longitude: any
            },
            originalPosition: {
              latitude:any,
              longitude: any
            },
            type: any,
            spot: any,
            sideOfStreet: any,
            mappedRoadName: any,
            label:any,
            shapeIndex: any,
            source: any
          }
        ],
        mode: {
          type: any,
          transportModes: [
            any
          ],
          trafficMode:any,
          feature: []
        },
        leg: [
          {
            start: {
              linkId:any,
              mappedPosition: {
                latitude:any,
                longitude: any
              },
              originalPosition: {
                latitude: any,
                longitude:any
              },
              type: any,
              spot: any,
              sideOfStreet: any,
              mappedRoadName: any,
              label: any,
              shapeIndex: 0,
              source: any
            },
            end: {
              linkId:any,
              mappedPosition: {
                latitude: any,
                longitude: any
              },
              originalPosition: {
                latitude: any,
                longitude: any
              },
              type:any,
              spot:any,
              sideOfStreet: any,
              mappedRoadName: any,
              label: any,
              shapeIndex: any,
              source: any
            },
            length: number,
            travelTime: number,
            maneuver: [ any
              // {
              //   position: {
              //     latitude: 52.5162041,
              //     longitude: 13.378365
              //   },
              //   instruction: "Head <span class=\"heading\">east</span> on <span class=\"street\">Pariser Platz</span>. <span class=\"distance-description\">Go for <span class=\"length\">80 m</span>.</span>",
              //   travelTime: 31,
              //   "length": 80,
              //   "id": "M1",
              //   "_type": "PrivateTransportManeuverType"
              // },
              // {
              //   "position": {
              //     "latitude": 52.5162792,
              //     "longitude": 13.3795345
              //   },
              //   "instruction": "Continue on <span class=\"next-street\">Unter den Linden</span>. <span class=\"distance-description\">Go for <span class=\"length\">90 m</span>.</span>",
              //   "travelTime": 55,
              //   "length": 90,
              //   "id": "M2",
              //   "_type": "PrivateTransportManeuverType"
              // },
              // {
              //   "position": {
              //     "latitude": 52.5163651,
              //     "longitude": 13.3808541
              //   },
              //   "instruction": "Turn <span class=\"direction\">left</span> onto <span class=\"next-street\">Wilhelmstraße</span> <span class=\"number\">(B2)</span>. <span class=\"distance-description\">Go for <span class=\"length\">192 m</span>.</span>",
              //   "travelTime": 43,
              //   "length": 192,
              //   "id": "M3",
              //   "_type": "PrivateTransportManeuverType"
              // },
              // {
              //   "position": {
              //     "latitude": 52.5180817,
              //     "longitude": 13.3804464
              //   },
              //   "instruction": "Continue on <span class=\"next-street\">Wilhelmstraße</span>. <span class=\"distance-description\">Go for <span class=\"length\">94 m</span>.</span>",
              //   "travelTime": 21,
              //   "length": 94,
              //   "id": "M4",
              //   "_type": "PrivateTransportManeuverType"
              // },
              // {
              //   "position": {
              //     "latitude": 52.5189292,
              //     "longitude": 13.3802962
              //   },
              //   "instruction": "Turn <span class=\"direction\">right</span> onto <span class=\"next-street\">Reichstagufer</span>. <span class=\"distance-description\">Go for <span class=\"length\">447 m</span>.</span>",
              //   "travelTime": 73,
              //   "length": 447,
              //   "id": "M5",
              //   "_type": "PrivateTransportManeuverType"
              // },
              // {
              //   "position": {
              //     "latitude": 52.5206638,
              //     "longitude": 13.3861149
              //   },
              //   "instruction": "Arrive at <span class=\"street\">Reichstagufer</span>. Your destination is on the right.",
              //   "travelTime": 0,
              //   "length": 0,
              //   "id": "M6",
              //   "_type": "PrivateTransportManeuverType"
              // }
            ]
          }
        ],
        summary: {
          distance: number,
          trafficTime: number,
          baseTime: any,
          flags: [
            any,
            any
          ],
          text: string,
          travelTime: number,
          _type: any
        }
      }
    ],
    language: any
  }
}
