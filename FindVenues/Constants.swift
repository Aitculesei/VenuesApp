//
//  Constants.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 14.12.2021.
//

import Foundation

struct Constants {
    enum API {

        static let stupidCookie = "_gcl_au=1.1.54083384.1639579664; dpi_utmOrigVals={\"originalutmmedium\":\"none\",\"originalutmsource\":\"none\"}; _mkto_trk=id:579-FAI-132&token:_mch-foursquare.com-1639579664253-18062; _ga=GA1.2.805097992.1639579664; _fbp=fb.1.1639579664460.685357576; _pxvid=15374cc7-5db6-11ec-9da2-644e647a4166; _hjSessionUser_1179695=eyJpZCI6Ijk3NzUxODE2LThjZDAtNTk3OC1hMDdlLTM5OGVmNDA4MjRkZCIsImNyZWF0ZWQiOjE2Mzk1Nzk2NjQ0OTAsImV4aXN0aW5nIjp0cnVlfQ==; bbhive=YCQD1GXVBBY2JVF4UCQONVO0OMYAPN::1702651738; oauth_token=POT4ORTTKDP5HCSS0TKKN1WY2IWAKBHLVZOYE1TDKUWMBLMZ-0; ajs_group_id=null; ajs_anonymous_id=\"d8cc522b-0550-4e9b-8442-014b801a76f3\"; __stripe_mid=b3dbe3dd-c78a-4ee8-9d1d-b788696eaa214f75e9; OptanonConsent=isIABGlobal=false&datestamp=Wed+Dec+22+2021+10:03:25+GMT+0200+(Eastern+European+Standard+Time)&version=6.16.0&hosts=&landingPath=NotLandingPage&groups=C0001:1,C0002:0,C0003:0,C0004:0,C0005:0&AwaitingReconsent=false"

        static let baseURL = "https://api.foursquare.com/"
        static let apiVersion = "v2"
        
        enum Paths {
            static let search = "venues/search"
            static let categories = "venues/categories"
            static let photos = "venues/"
        }
        
        enum Photo {
            static let dimensions = "250x250"
        }
        
        enum Client {
            static let id = URLQueryItem(name: "client_id", value: "K30AKLDFJ4Z5RQTV1MV1NWAOTWVKH55IWW3HM4B33ZHINEAI")
            static let secret = URLQueryItem(name: "client_secret", value: "BCFWZKQJE2AZDPPK0ZU5T2PPHUDBJVDYSZ122AHOTISAMRPM")
        }
    }
    
    enum LocalDataManagerSavings {
        static let queryKey = "query"
        static let rangeValueKey = "rangeValue"
    }
    
    enum TableViewCell {
        static let identifier = "venuesTableCell"
    }
    
    enum CollectionViewCell {
        static let queriesCollectionIdentifier = "queriesCollectionCell"
        static let venueDetailsViewIdentifier = "venueDetailsCollectionCell"
    }
    
    enum MapView {
        static let identifier = "venueOnMap"
    }
    
    enum VenuesRequest {
        static let defaultQuery = "restaurant"
        enum Parameters {
            static let query = "query"
            static let ll = "ll"
            static let nearby = "nearby"
            static let radius = "radius"
            static let v = "v"
            static let categoryId = "categoryId"
        }
    }
    
    enum VenueDetailsViewProperties {
        static let viewNumberOfSections = 2
    }
}
