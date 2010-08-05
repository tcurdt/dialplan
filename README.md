# dialplan

The dialplan project is two things. One it's a structured gathering of dialplan data you can find on the web. It describes how you dial out of country, how you make national calls and what is the international country prefix. Looking at the entry for Germany you can see

    "+49": 
      country: 
      - de
      nprefix: "0"
      iprefix: "00"

that the international country code is 49. In Germany you make national calls by prefixing the area code with a single "0". When dialing out of Germany you would use the international prefix "00". Which means in practise 030... reaches someone in Berlin, while 001... is a call to the US. Calls to "+49" end up in Germany, "+4930" in Berlin even.

# Implementations

The second part of the project are the APIs to make use of the data. So far there are (early) implementations for:

## Objective-C

    NSString *number = [[DialPlan sharedInstance] internationalizeNumber:@"0301234" forCode:@"+49"];
 
## Ruby

    plan = DialPlan::DialPlan.new(path)
    country = plan.country('+49')    
    assert_equal '+49179', country.internationalizeNumber('0179')

Given that you know where you are they let you convert between local numbers and the international representation.

If you have updates to the data *please* send updates for the yaml file - the original source. The other files are just derived from that.

# License

All code and data is released under the Apache License 2.0.

# Related projects

* http://code.google.com/p/libphonenumber