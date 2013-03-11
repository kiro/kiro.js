window.event = {
    "action":null,
    "action_kwargs":null,
    "created":"2013-03-08T09:44:43.641406",
    "created_by":null,

    "customers":[

    {
        "created":"2013-03-08T09:44:43.652119",
        "created_by":null,
        "customer":"/api/customer_web/v1/customer/5/",
        "last_changed":"2013-03-08T09:44:43.673116",
        "last_changed_by":null,
        "late":0,
        "late_reported_time":null,
        "organiser":null,
        "requested_change":false,
        "required":false,
        "resource_uri":"/api/customer_web/v1/event/9/customers/9/",
        "name" : "Celestine Hodkiewicz",
        "state":{
            "ordinal":200,
            "type":"core.store.states.CustomerEventState",
            "value":"confirmed",
            "name": "Celestine Hodkiewicz"
        }
    }
],
    "deleted":false,
    "description":"Your appointment",
    "end_date":"2013-03-08T13:40:00",
    "event_template":"/api/customer_web/v1/event_template/36/",
    "last_changed":"2013-03-08T09:44:43.681136",
    "last_changed_by":null,
    "length":1200,
    "locations":[{name: "Surgery"}],
    "resources":[],
    "new_event":null,
    "old_event":null,
    "organisation":"/api/customer_web/v1/organisation/2/",
    "organisation_cancelled":false,
    "organisation_deleted":false,
    "organisation_state":"confirmed",
    "resource_uri":"/api/customer_web/v1/event/9/",
    "scheduled_messages":[],

    "staff":[

    {
        "created":"2013-03-08T09:44:43.651637",
        "last_changed":"2013-03-08T09:44:43.651618",
        "required":false,
        "resource_uri":"/api/customer_web/v1/event/9/staff/9/",
        "staff":"/api/customer_web/v1/staff/1/",
        "name": "Shea Smith"
    }
],
    "start_date":"2013-03-08T13:20:00",
    "state":"confirmed",
    "notes" : [
    {
        "from" : "Shea Smith",
        "date" : "4 March",
        "text" : "This is a note about this specific appointment, as opposed to a note on a customer for example"
    },
    {
        "from" : "Shea Smith",
        "date" : "28 February",
        "text" : "You can have more than one note on an appointment"
    }
    ],
    "history" : [
        {
            "action": "Customer confirmed.",
            "date": "yesterday"
        },
        {
            "action": "Customer did not reply to reminder.",
            "date": "yesterday"
        },
        {
            "action": "Reminder sent.",
            "date": "4 March"
        },
        {
            "action": "Customer confirmed.",
            "date": "28 February"
        }
    ]
}



