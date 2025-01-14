return cachedServices["HttpService"]:JSONDecode(game:HttpGet("https://gist.githubusercontent.com/MimiTest2/bd25bf3c77de4af31fcc3268fce70f29/raw/throwndata.json"))
--[[cachedServices["HttpService"]:JSONDecode([[
    {
        "TRACKER": {
          "Roll": false,
          "Name": "TRACKER",
          "Range": 10.7,
          "Delay": 0
        },
        "indicator": {
          "Name": "indicator",
          "Range": 31.4,
          "Delay": 650,
          "Roll": true
        },
        "STREAMPART": {
          "Name": "STREAMPART",
          "Range": 35.3,
          "Delay": 0,
          "Roll": false
        },
        "GrabPart": {
          "Name": "GrabPart",
          "Range": 3,
          "Delay": 0,
          "Roll": false
        },
        "ImpactIndicator": {
          "Roll": false,
          "Delay": 350,
          "Name": "ImpactIndicator",
          "Range": 15.5
        }
      }
]]--)
