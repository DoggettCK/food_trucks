# FoodTrucks

This is an implementation of the [Peck Engineering Assessment](https://github.com/peck/engineering-assessment) for consideration for employment.

I gave myself a time limit of 3 hours, and chose a simple search API to find food trucks by their listed menu items, allowing for multiple items to narrow down the search. 

### TODO

Some features I wanted to get to, but was unable to in the time limit:

- Parse `dayshours` (`"Sa-Su:11AM-10PM;Mo-Fr:6PM-8PM"`) and figure out what's open at the time of the query
- LiveView browser-based geolocation call to find the nearest food trucks to your current location
- Chaining all of that together to allow user to search for what's open nearest to their location with given food items

## Examples

> To find all permits with "meat", "bread", and "seafood" on their menu:

```
$ curl http://localhost:4000/api/v1/food_trucks/by_item\?q\[\]\=meat\&q\[\]\=bread\&q\[\]\=seafood | jq
{
  "data": [
    {
      "status": "REQUESTED",
      "address": "400 CALIFORNIA ST",
      "permit": "18MFF-0088",
      "food_items": "Daily rotating menus consisting of various local & organic vegetable: poultry: meat: seafood : rice & bread dishes.",
      "applicant": "Munch India",
      "approved_date": null,
      "expiration_date": "2019-07-15T00:00:00",
      "facility_type": "Truck",
      "latitude": 37.79330427556103,
      "location_description": "CALIFORNIA ST: SANSOME ST to LEIDESDORFF ST (400 - 448)",
      "longitude": -122.4014589984134,
      "schedule": "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=18MFF-0088&ExportPDF=1&Filename=18MFF-0088_schedule.pdf"
    },
    {
      "status": "REQUESTED",
      "address": "Assessors Block /Lot",
      "permit": "17MFF-0187",
      "food_items": "Daily rotating menus consisting of various local & organic vegetable: poultry: meat: seafood : rice & bread dishes.",
      "applicant": "Munch India",
      "approved_date": null,
      "expiration_date": "2017-07-19T00:00:00",
      "facility_type": "Truck",
      "latitude": 0.0,
      "location_description": "POST ST: MONTGOMERY ST to LICK PL (1 - 40)",
      "longitude": 0.0,
      "schedule": "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=17MFF-0187&ExportPDF=1&Filename=17MFF-0187_schedule.pdf"
    }
  ]
}
```


## Startup

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
